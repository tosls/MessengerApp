//
//  ConversationsViewController.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 02.10.2021.
//

import UIKit

class ConversationsListViewController: UIViewController {
    
    private let userName = userProfile.userName
    private let identifier = String(describing: ConversationTableViewCell.self)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.frame, style: .plain)

        tableView.register(UINib(nibName: String(describing: ConversationTableViewCell.self), bundle: nil), forCellReuseIdentifier: identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Tinkoff Chat"
        view.addSubview(tableView)
        setupUserProfileButton()
    }
    
    @objc func btnTapped(_ sender: Any) {
        performSegue(withIdentifier: "profileVC", sender: nil)
        
    }
    
    func setupUserProfileButton() {
    
        let buttonImage = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0))
        buttonImage.layer.cornerRadius = buttonImage.frame.size.height / 2
        buttonImage.backgroundColor = UIColor(red: 0.894,
                                              green: 0.908,
                                              blue: 0.17,
                                              alpha: 1)

        let Button : UIButton = UIButton.init(type: .custom)
        Button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        Button.addTarget(self, action: #selector(btnTapped(_:)), for: .touchUpInside)
        buttonImage.addSubview(Button)
        
        let profileButton = UIBarButtonItem()
        profileButton.customView = buttonImage
        self.navigationItem.rightBarButtonItem = profileButton
        
        let imageViewHeight = buttonImage.bounds.height
        let imageViewWidth = buttonImage.bounds.width
        
        let userInitials = UserProfileModel.userNameToInitials(name: userName ?? "User Profile")
        buttonImage.image = UserProfileModel.userInitialsToImage(userInitials, imageViewHeight, imageViewWidth)
    }
}


// MARK: extension UITableViewDataSource


extension ConversationsListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        conversations.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        conversations[section].dialogs.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionName = conversations[section].status
        
        switch sectionName {
        case .online:
            return Status.online.rawValue
        case .oflline:
            return Status.oflline.rawValue
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let conversation = conversations[indexPath.section]
        let dialog = conversation.dialogs[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? ConversationTableViewCell else {
            return UITableViewCell() }
        
        cell.configure(with: ConversationModel(name: dialog.userName, message: dialog.message, date: dialog.date, online: dialog.status, hasUnreadMessage: dialog.hasUnreadMessage))
    
        return cell
    }
}


// MARK: extension UITableViewDelegate


extension ConversationsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let conversationVC = ConversatioViewController()
        navigationController?.pushViewController(conversationVC, animated: true)
    }
}
