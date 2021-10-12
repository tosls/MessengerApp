//
//  ConversationsViewController.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 02.10.2021.
//

import UIKit

class ConversationsListViewController: UIViewController {
    
    private let profileUserName = userProfile.userName
    private let identifier = String(describing: ConversationTableViewCell.self)
    private var testText: [String] = [""]
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.frame, style: .plain)

        tableView.register(UINib(nibName: String(describing: ConversationTableViewCell.self), bundle: nil), forCellReuseIdentifier: identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? SettingsViewController else {return}
        destination.closure = { [weak self] theme in self?.logThemeChanging(selectedTheme: theme) }
        
    }
    
    @objc func profileButtonTapped(_ sender: Any) {
        print(testText)
        performSegue(withIdentifier: "profileVC", sender: nil)
    }
    
    @objc func settingsButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "settingsVC", sender: nil)
        
    }
    
    func logThemeChanging(selectedTheme: ThemeSettings) {
        ThemeSettings.themeChanging(selectedTheme: selectedTheme)
        self.navigationController?.loadView()
    }
    
    private func setupView() {
        title = "Tinkoff Chat"
        view.addSubview(tableView)
        
        setupUserProfileButton()
        settingsButton()
    }
    
    private func settingsButton() {
        let barButtonItem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(settingsButtonTapped(_:)))
        self.navigationItem.leftBarButtonItem = barButtonItem
    }
    
    private func setupUserProfileButton() {
    
        let buttonImage = UIImageView(frame: CGRect(x: 0.0,
                                                    y: 0.0,
                                                    width: 40.0,
                                                    height: 40.0))
        
        buttonImage.layer.cornerRadius = buttonImage.frame.size.height / 2
        buttonImage.backgroundColor = UIColor(red: 0.894,
                                              green: 0.908,
                                              blue: 0.17,
                                              alpha: 1)

        let button : UIButton = UIButton.init(type: .custom)
        button.frame = CGRect(x: 0,
                              y: 0,
                              width: 40,
                              height: 40)
        
        button.addTarget(self, action: #selector(profileButtonTapped(_:)), for: .touchUpInside)
        buttonImage.addSubview(button)
        
        let profileButton = UIBarButtonItem()
        profileButton.customView = buttonImage
        self.navigationItem.rightBarButtonItem = profileButton
        
        let imageViewHeight = buttonImage.bounds.height
        let imageViewWidth = buttonImage.bounds.width
        
        let userInitials = UserProfileModel.userNameToInitials(name: profileUserName ?? "User Profile")
        buttonImage.image = UserProfileModel.userInitialsToImage(userInitials, imageViewHeight, imageViewWidth)
    }
}


// MARK: extension UITableViewDataSource


extension ConversationsListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        conversations.count
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        conversations[section].conversation.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let sectionName = conversations[section].userStatus
        switch sectionName {
        case .online:
            return "Online"
        case .history:
            return "History"
        }
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let conversation = conversations[indexPath.section]
        let dialog = conversation.conversation[indexPath.row]

        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? ConversationTableViewCell else {
            return UITableViewCell() }
        
        cell.configure(with: ConversationModel(name: dialog.userName,
                                               message: dialog.message,
                                               date: dialog.date,
                                               online: dialog.status,
                                               hasUnreadMessage: dialog.hasUnreadMessage))
    
        return cell
    }
}


// MARK: extension UITableViewDelegate


extension ConversationsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let conversationVC = ConversationViewController()
        let conversation = conversations[indexPath.section]
        let dialog = conversation.conversation[indexPath.row]
        let userName = dialog.userName
        let lastMessage = dialog.message
        conversationVC.titleName = userName
        conversationVC.chatLastMessage = Message(text: lastMessage, isIncoming: true)
        
        navigationController?.pushViewController(conversationVC, animated: true)
    }
}
