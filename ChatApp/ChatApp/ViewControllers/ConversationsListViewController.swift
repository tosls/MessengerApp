//
//  ConversationsViewController.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 02.10.2021.
//

import UIKit
import Firebase

class ConversationsListViewController: UIViewController, ThemesViewControllerDelegate {

    private let identifier = String(describing: ConversationTableViewCell.self)
    var userPhoto = UIImage()
    
    private lazy var db = Firestore.firestore()
    private lazy var reference = db.collection("channels")
   
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.frame, style: .plain)

        tableView.register(UINib(nibName: String(describing: ConversationTableViewCell.self), bundle: nil), forCellReuseIdentifier: identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        reference.addSnapshotListener { [weak self] snapshot, error in
//            print(snapshot?.documents[0].data()) }
        setupView()
      
        
//        lazy var db = Firestore.firestore()
//        lazy var reference = db.collection("channels")
//        reference.addSnapshotListener { [weak self] snapshot, error in
//            print(snapshot)
//        }
        
//        private lazy var db = Firestore.firestore()
//        private lazy var reference: CollectionReference = {
//        guard let channelIdentifier = channel?.identifier else { fatalError() }
//        return db.collection("channels").document(channelIdentifier).collection("messages")
//         }()
//        reference.addDocument(data: newMessage.toDict)
//
//        extension Message {
//         var toDict: [String: Any] {
//         return ["content": content,
//         "created": Timestamp(date: created),
//         "senderID": senderId,
//         "senderName": senderName]
//         }
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationObjC = segue.destination as? ThemesViewController {
            destinationObjC.delegate = self
        }
        if let destination = segue.destination as? SettingsViewController {
            destination.settingsClosure = { [weak self] theme in self?.themeChanging(selectedTheme: theme) }
        }
        
        if let destination = segue.destination as? ProfileViewController {
            destination.updateProfileImageClosure = { switch $0 {
            case true:
                print("Test12")
                self.setupUserProfileButton()
            case false:
                print("Test13")
                return
            }
            }
        }

//        guard let destination = segue.destination as? SettingsViewController else {return}
//        destination.closure = { [weak self] theme in self?.logThemeChanging(selectedTheme: theme) }
    }
    
    @objc func profileButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "profileVC", sender: nil)
    }
    
    @objc func settingsButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "settingsVC", sender: nil)
    }
    
    @objc func settingsObjCButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "settingsObjCVC", sender: nil)
    }
    
    func themesViewController(_ controller: ThemesViewController, didSelectedTheme selectedTheme: UIColor) {
        logThemeChanging(themeColor: selectedTheme)
    }
    
    private func themeChanging(selectedTheme: ThemeSettings) {
            ThemeSettings.themeChanging(selectedTheme: selectedTheme)
            self.navigationController?.loadView()
    }
    
    private func userImageChanging() {
        self.navigationController?.loadView()
    }
    
    private func updateView() {
        setupUserProfileButton()
    }
    
    private func logThemeChanging(themeColor: UIColor) {
        print(themeColor)
    }

    private func setupView() {
        title = "Tinkoff Chat"
        view.addSubview(tableView)
        
        setupUserProfileButton()
//        settingsButton()
        setupSettingsButtons()
    }
 
    private func setupSettingsButtons() {
        let barButtonItemObjC = UIBarButtonItem(title: "Obj-C", style: .plain, target: self, action: #selector((settingsObjCButtonTapped(_:))))
        
        let barButtonItem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(settingsButtonTapped(_:)))
        
        self.navigationItem .setLeftBarButtonItems([barButtonItem, barButtonItemObjC], animated: false)
    }
    
    private func settingsButton() {
        let barButtonItem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(settingsButtonTapped(_:)))
        self.navigationItem.leftBarButtonItem = barButtonItem
    }
    
    private func setupUserProfileButton() {
        
        let gcdManager = GCDManager()
        
        let button = UIButton(type: .custom)
        
        button.addTarget(self, action: #selector(profileButtonTapped(_:)), for: .touchUpInside)
        button.frame = CGRect(x: 0,
                              y: 0,
                              width: 40,
                              height: 40)
        
        button.backgroundColor = UIColor(red: 0.894,
                                         green: 0.908,
                                         blue: 0.17,
                                         alpha: 1)
        
        let buttonImage = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: button.frame.width, height: button.frame.height))
        buttonImage.layer.cornerRadius = buttonImage.frame.height / 2
        buttonImage.clipsToBounds = true
        
        gcdManager.loadUserImage { userImage in
            if userImage != nil {
                buttonImage.image = userImage
                button.addSubview(buttonImage)
            } else {
                let userInitials = UserProfileModel.userNameToInitials(name: UserProfile.shared.getUserProfile().userName ?? "User Name")
                let userInitialsImage = UserProfileModel.userInitialsToImage(userInitials, button.frame.width, button.frame.height)
                button.setImage(userInitialsImage, for: .normal)
            }
        }
        
        button.layer.cornerRadius = button.bounds.size.height / 2
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
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
