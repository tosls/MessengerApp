//
//  ConversationViewController.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 02.10.2021.
//

import UIKit
import Firebase
import CoreData

class ConversationViewController: UITableViewController {
    
    var titleName: String?
    var channel: ChannelModel?
    var newChannel: DBChannel?
    var messagesDB: DBMessage?
    
    var channelMessages = [Message]()
//    var conteiner: NSPersistentContainer!
    
    private let cellID = "messageCell"
    
    private lazy var db = Firestore.firestore()
    private lazy var messagesReference: CollectionReference = {
        guard let channelID = newChannel?.identifier else {fatalError()}
        return db.collection("channels").document(channelID).collection("messages")
    }()
    
    lazy var fetchedResultsController: NSFetchedResultsController<DBMessage> = {
        let request: NSFetchRequest<DBMessage> = DBMessage.fetchRequest()
    
        let sortDescription = NSSortDescriptor(key: "created", ascending: true)
        request.sortDescriptors = [sortDescription]
        let channelID = newChannel?.identifier ?? ""
        let predicate = NSPredicate(format: "channel.identifier == %@", channelID)
        request.predicate = predicate
        let fetchedResultController = NSFetchedResultsController(fetchRequest: request,
                                                                 managedObjectContext: CoreDataManager.shared.contex,
                                                                 sectionNameKeyPath: nil,
                                                                 cacheName: nil)
        
        fetchedResultController.delegate = self
        do {
            try fetchedResultController.performFetch()
        } catch {
            print(error)
        }
        return fetchedResultController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = titleName ?? "Messages"

        tableView.register(MessageTableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.separatorStyle = .none
        
        getChannelMessages()
        setupMessageButton()
    }
    
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            guard let sections = fetchedResultsController.sections else {
                print("Sections error")
                return 0}
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? MessageTableViewCell else {return UITableViewCell()}
        let channelMessages = fetchedResultsController.object(at: indexPath)
        cell.channelMessageID = channelMessages.senderId
        cell.userNameLabel.text = channelMessages.senderName
        cell.messageLabel.text = channelMessages.content
        cell.messageLabel.textColor = .black
        cell.backgroundColor = .white
        return cell
    }

    @objc func addNewChannelButtonTapped(_ sender: Any) {
        newMessageAlert()
    }

    private func getChannelMessages() {
        messagesReference.addSnapshotListener { [weak self] snapshot, error in
            if let error = error {
                print(error)
                return
            }
            self?.channelMessages.removeAll()

            if let documents = snapshot?.documents {
                for document in documents {
                    let data = document.data()

                    let content = data["content"] as? String ?? "Channel Name"
                    let senderName = data["senderName"] as? String ?? "Sender Name"
                    let senderId = data["senderid"] as? String ?? "senderid Name"
                    let created = data["created"] as? Timestamp
                    
                    self?.channelMessages.append(Message(
                        content: content,
                        created: created?.dateValue() ?? Date(),
                        senderid: senderId,
                        senderName: senderName
                    )
                    )
                    CoreDataManager.shared.saveMessagesWithCoreData(message: Message(
                        content: content,
                        created: created?.dateValue() ?? Date(),
                        senderid: senderId,
                        senderName: senderName),
                                                                    identifier: self?.newChannel?.identifier ?? ""
                    )

                }
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    // MARK: Sending Message

    private func setupMessageButton() {

        let newMessageBarButtonItem = UIBarButtonItem(title: "New Message",
                                                      style: .plain,
                                                      target: self,
                                                      action: #selector(addNewChannelButtonTapped(_:)
                                                                       )
        )
        self.navigationItem.rightBarButtonItem = newMessageBarButtonItem
    }

    private func newMessageAlert() {

        var newMessage: String?
        let alert = UIAlertController(title: "Отправить новое сообщение",
                                      message: nil,
                                      preferredStyle: .alert)

        let cancel = UIAlertAction(title: "Cancel",
                                   style: .cancel,
                                   handler: nil)

        let sendMessage = UIAlertAction(title: "Отправить",
                                        style: .default) { [weak self] _ in
            self?.sendMessage(message: newMessage ?? "")
        }

        alert.addAction(cancel)
        alert.addAction(sendMessage)
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Сообщение"
            sendMessage.isEnabled = false
            NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textField, queue: OperationQueue.main) { (_) in
                if textField.text?.isEmpty == false {
                    sendMessage.isEnabled = true
                    newMessage = textField.text
                } else {
                    sendMessage.isEnabled = false
                }
            }
        })
        present(alert, animated: true, completion: nil)
    }

    private func sendMessage(message: String) {
        let newMessage: Message = Message(content: message,
                                          created: Date(),
                                          senderid: UserSenderID.shared.getUserSenderId(),
                                          senderName: UserProfile.shared.getUserProfile().userName ?? "User Name"
        )
        print(newMessage.content)
        messagesReference.addDocument(data: newMessage.toDict)
    }
}

extension ConversationViewController: NSFetchedResultsControllerDelegate {

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
