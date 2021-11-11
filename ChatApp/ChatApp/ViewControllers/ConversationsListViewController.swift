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

    var actualChannels = [ChannelModel]()
    var userPhoto = UIImage()
    var themeName: String?

    private let identifier = String(describing: ConversationTableViewCell.self)
    
    private lazy var db = Firestore.firestore()
    private lazy var referenceChannel = db.collection("channels")
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.frame, style: .plain)
        tableView.register(UINib(nibName: String(describing: ConversationTableViewCell.self), bundle: nil), forCellReuseIdentifier: identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    lazy var fetchedResultsController: NSFetchedResultsController<DBChannel> = {
        let request: NSFetchRequest<DBChannel> = DBChannel.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "lastActivity", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: request,
                                                                  managedObjectContext: CoreDataManager.shared.contex,
                                                                  sectionNameKeyPath: nil,
                                                                  cacheName: nil)
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error)
        }
        return fetchedResultsController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupView()
        getChannelsFromFirebase()
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
        title = "Channels"
        
        view.addSubview(tableView)
        
        setupUserProfileButton()
        setupLeftBarButtons()
        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth = true
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
    
    // MARK: Work with Channels

    private func getChannelsFromFirebase() {
        
        referenceChannel.addSnapshotListener { [weak self] snapshot, error in
            if let error = error {
                print(error)
            } else {
                guard let snap = snapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                self?.actualChannels.removeAll()

                for document in snap.documents {
                    let chanelName = document.data()["name"] as? String ?? "Channel Name"
                    let lastMessage = document.data()["lastMessage"] as? String ?? "Last Message"
                    let identifier = document.documentID
                    let lastMessageDate = document.data()["lastActivity"] as? Timestamp
                
                    self?.actualChannels.append(ChannelModel(
                        identifier: identifier,
                        name: chanelName,
                        lastMessage: lastMessage,
                        lastActivity: lastMessageDate?.dateValue() ?? Date()
                    )
                    )
                }
                self?.checkingTheRelevanceOfChannels()
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func checkingTheRelevanceOfChannels() {
        guard let channelsFromCoreData = fetchedResultsController.fetchedObjects else {return}
        if actualChannels.count < channelsFromCoreData.count {
            var channelsIdentifier: [String] = []
            for channel in actualChannels {
                channelsIdentifier.append(channel.identifier)
            }
            let request: NSFetchRequest<DBChannel> = DBChannel.fetchRequest()
            let predicate = NSPredicate(format: "NOT identifier IN %@", channelsIdentifier)
            request.predicate = predicate
            do {
                let channelData = try CoreDataManager.shared.contex.fetch(request)
                for channelInCoreData in channelData {
                    CoreDataManager.shared.deleteChannel(object: channelInCoreData)
                }
            } catch let error as NSError {
                print(error.debugDescription)
            }
        } else if actualChannels.count > channelsFromCoreData.count {
            for channel in actualChannels {
                CoreDataManager.shared.saveChannelsWithCoreData(channel: ChannelModel(
                    identifier: channel.identifier,
                    name: channel.name,
                    lastMessage: channel.lastMessage,
                    lastActivity: channel.lastActivity
                )
                )
            }
        }
    }
    
    private func deleteChannel(identifier: String?) {
        guard let channelIdentifier = identifier else {return}
        referenceChannel.document(channelIdentifier).delete()
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
            self?.referenceChannel.addDocument(data: newChannel.toDict)
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

// MARK: extension UITableViewDataSource

extension ConversationsListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchedResultsController.sections else {return 0}
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? ConversationTableViewCell else {
            return UITableViewCell()
        }
        
        let channels = fetchedResultsController.object(at: indexPath)
        cell.configure(with: ChannelModel(identifier: channels.identifier ?? "no identifier",
                                          name: channels.name ?? "No name",
                                          lastMessage: channels.lastMessage,
                                          lastActivity: channels.lastActivity))
        return cell
    }
    
    // MARK: Swipe Actions
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = self.contextualDeleteAction(forRowAtIndexPath: indexPath)
        let swipeConfigure = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeConfigure
    }
    
   private func contextualDeleteAction (forRowAtIndexPath indexPath: IndexPath) -> UIContextualAction {
       let action = UIContextualAction(style: .destructive, title: "Delete") {(_, _, _) in
           let managedObject = self.fetchedResultsController.object(at: indexPath)
           self.deleteChannel(identifier: managedObject.identifier)
           CoreDataManager.shared.deleteChannel(object: managedObject)
       }
       action.backgroundColor = .red
       action.image = UIImage(named: "delete")
       return action
   }
}

// MARK: extension UITableViewDelegate

extension ConversationsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channelVC = ConversationViewController()
        let actualChannel = fetchedResultsController.object(at: indexPath)
        channelVC.actualChannel = actualChannel
        channelVC.titleName = actualChannel.name

        navigationController?.pushViewController(channelVC, animated: true)
    }
}

// MARK: fetched Results Controller Delegate

extension ConversationsListViewController: NSFetchedResultsControllerDelegate {

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        @unknown default:
            print("Error fetched Results Controller Delegate")
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
    }
}
