//
//  ConversationsViewController.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 02.10.2021.
//

import UIKit
import Firebase
import FirebaseFirestore
import CoreData

class ConversationsListViewController: UIViewController {

    var userPhoto = UIImage()
    var tableViewDataSource = ConversationTableView()
    let channelsManager = ChannelsManager()
    
    private let cellIdentifier = String(describing: ConversationTableViewCell.self)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.frame, style: .plain)
        tableView.register(UINib(nibName: String(describing: ConversationTableViewCell.self), bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = tableViewDataSource
        tableView.delegate = self
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        NetworkImageService.shared.getURL()
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
    
    private func setupView() {
        title = "Channels"
        view.addSubview(tableView)
        
        setupUserProfileButton()
        setupLeftBarButtons()
        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth = true
    }
    
    private func setupUserProfileButton() {
        let gcdManager = GCDManager()
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(profileButtonTapped(_:)), for: .touchUpInside)
        button.frame = CGRect(x: 0,
                              y: 0,
                              width: 40,
                              height: 40
        )
        button.backgroundColor = UIColor(red: 0.894,
                                         green: 0.908,
                                         blue: 0.17,
                                         alpha: 1
        )
        let buttonImage = UIImageView(frame: CGRect(x: 0.0,
                                                    y: 0.0,
                                                    width: button.frame.width,
                                                    height: button.frame.height
                                                   )
        )
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
    
    private func setupLeftBarButtons() {
        let newChannelBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                      target: self,
                                                      action: #selector(addNewChannelButtonTapped(_:)
                                                                       )
        )
        let settingsBarButtonItem = UIBarButtonItem(title: "Settings",
                                                    style: .plain,
                                                    target: self,
                                                    action: #selector(settingsButtonTapped(_:)
                                                                     )
        )
        self.navigationItem.setLeftBarButtonItems([newChannelBarButtonItem, settingsBarButtonItem], animated: false)
    }
    
    private func updateView() {
        setupUserProfileButton()
    }
    
    private func themeChanging(selectedTheme: ThemeSettings) {
        ThemeSettings.themeChanging(selectedTheme: selectedTheme)
        self.navigationController?.loadView()
    }
    
    private func userImageChanging() {
        self.navigationController?.loadView()
    }
    
    // MARK: Work with Channels

    private func getActualChannels() {
        channelsManager.getChannelsFromFirebase(tableView: tableView)
    }

    private func newChannelAlert() {
        var channelName: String?
        let alert = UIAlertController(title: "Создать новый канал",
                                      message: nil,
                                      preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "Cancel",
                                   style: .cancel,
                                   handler: nil)
        
        let createAChannel = UIAlertAction(title: "Создать",
                                           style: .default) { [weak self] _ in let
            newChannel = ChannelModel(
                identifier: "",
                name: channelName ?? "Channel Name",
                lastMessage: "", lastActivity: Date()
            )
            self?.channelsManager.addChannelToFirebase(newChannel: newChannel)
            self?.tableView.reloadData()
        }
        alert.addAction(cancel)
        alert.addAction(createAChannel)
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Название канала"
            createAChannel.isEnabled = false
            NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textField, queue: OperationQueue.main) { (_) in
                if textField.text?.isEmpty == false {
                    createAChannel.isEnabled = true
                    channelName = textField.text ?? "Channel Name"
                } else {
                    createAChannel.isEnabled = false
                }
            }
        })
        present(alert, animated: true, completion: nil)
    }
}

// MARK: extension UITableViewDelegate

extension ConversationsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channelVC = ConversationViewController()
        let actualChannel = channelsManager.fetchedResultsController.object(at: indexPath)
        channelVC.actualChannel = actualChannel
        channelVC.titleName = actualChannel.name
        
        navigationController?.pushViewController(channelVC, animated: true)
    }
    
    // MARK: Swipe Actions

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = self.contextualDeleteAction(forRowAtIndexPath: indexPath)
        let swipeConfigure = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeConfigure
    }

    private func contextualDeleteAction (forRowAtIndexPath indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") {(_, _, _) in
            let managedObject = self.channelsManager.fetchedResultsController.object(at: indexPath)
            self.channelsManager.deleteChannel(identifier: managedObject.identifier)
            CoreDataManager.shared.deleteChannel(object: managedObject)
            self.tableView.reloadData()
        }
        action.backgroundColor = .red
        action.image = UIImage(named: "delete")
        return action
    }
}
