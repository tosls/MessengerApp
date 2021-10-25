//
//  ConversationsViewController.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 02.10.2021.
//

import UIKit
import Firebase

class ConversationsListViewController: UIViewController {

    private let identifier = String(describing: ConversationTableViewCell.self)
    var userPhoto = UIImage()
    
    private lazy var db = Firestore.firestore()
    private lazy var reference = db.collection("channels")
    private lazy var channelsCount: Int = 0
    
    var channels = [ChannelModel]()
    var message = [Message]()
    
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
        getChannels()
        
    }
    
    private func getChannels() {
        
        reference.addSnapshotListener { [weak self] snapshot, error in
            if let error = error {
                print(error)
            } else {
                guard let snap = snapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                for document in snap.documents {
                    let chanelName = document.data()["name"] as? String ?? "Channel Name"
                    let lastMessage = document.data()["lastMessage"] as? String ?? "Last Message"
                    let identifier = document.data()["identifier"] as? String ?? "identifier"
                    self?.channels.append(ChannelModel(identifier: identifier, name: chanelName, lastMessage: lastMessage))
                }
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SettingsViewController {
            destination.settingsClosure = { [weak self] theme in self?.themeChanging(selectedTheme: theme) }
        }
        
        if let destination = segue.destination as? ProfileViewController {
            destination.updateProfileImageClosure = {
            switch $0 {
            case true:
                self.setupUserProfileButton()
            case false:
                return
            }
            }
        }
    }
    
    @objc func profileButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "profileVC", sender: nil)
    }
    
    @objc func settingsButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "settingsVC", sender: nil)
    }
    
    @objc func addNewChannelButtonTapped(_ sender: Any) {
        newChannelAlert()
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
        setupLeftBarButtons()
    }
 
    private func setupLeftBarButtons() {
        let newChannelBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewChannelButtonTapped(_:)))
        
        let settingsBarButtonItem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(settingsButtonTapped(_:)))
        
        self.navigationItem .setLeftBarButtonItems([newChannelBarButtonItem, settingsBarButtonItem], animated: false)
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
    
    private func newChannelAlert() {
        let alert = UIAlertController(title: "Создать новый канал", message: nil, preferredStyle: .alert)
        let createAChannel = UIAlertAction(title: "Создать", style: .default, handler: nil)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(createAChannel)
        alert.addAction(cancel)
        
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Название канала"
            createAChannel.isEnabled = false
            NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textField, queue: OperationQueue.main) { (_) in
                if textField.text?.isEmpty == false {
                    createAChannel.isEnabled = true
                } else {
                    createAChannel.isEnabled = false
                }
            }
        })
        present(alert, animated: true, completion: nil)
    }
}

// MARK: extension UITableViewDataSource

extension ConversationsListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let channel = channels[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? ConversationTableViewCell else {
            return UITableViewCell() }
        cell.configure(with: ChannelModel(identifier: channel.identifier, name: channel.name, lastMessage: channel.lastMessage))
    
        return cell
    }
}

// MARK: extension UITableViewDelegate

extension ConversationsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channelVC = ConversationViewController()
        let chanel = channels[indexPath.row]
        channelVC.channel = chanel
        channelVC.titleName = chanel.name
        
        navigationController?.pushViewController(channelVC, animated: true)
    }
}
