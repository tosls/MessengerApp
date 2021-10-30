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
    var channelMessages = [Message]()
    var conteiner: NSPersistentContainer!
    
    private lazy var db = Firestore.firestore()
    private lazy var messagesReference: CollectionReference = {
        guard let channelIdentifier = channel?.identifier else {fatalError()}
        return db.collection("channels").document(channelIdentifier).collection("messages")
    }()
    
    private let cellID = "messageCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        title = titleName ?? "Messages"
        
        tableView.register(MessageTableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.separatorStyle = .none
        
        getChannelMessages()
        setupMessageButton()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? MessageTableViewCell else {return UITableViewCell()}
        let messages = channelMessages.sorted { $0.created < $1.created }
        let channelMessage = messages[indexPath.row]
        cell.userNameLabel.text = channelMessage.senderName
        cell.messageLabel.text = channelMessage.content
        cell.channelMessage = channelMessage
        cell.messageLabel.textColor = .black
        cell.backgroundColor = .white
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        channelMessages.count
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
                    let sendeId = data["senderID"] as? String ?? "SenderID Name"
                    let created = data["created"] as? Timestamp
                    
                    self?.channelMessages.append(Message(
                        content: content,
                        created: created?.dateValue() ?? Date(),
                        senderid: sendeId,
                        senderName: senderName)
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
        
        let newMessageBarButtonItem = UIBarButtonItem(title: "New Message", style: .plain, target: self, action: #selector(addNewChannelButtonTapped(_:)))
        self.navigationItem.rightBarButtonItem = newMessageBarButtonItem
    }
    
    private func newMessageAlert() {
        
        var newMessage: String?
        
        let alert = UIAlertController(title: "Отправить новое сообщение", message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let sendMessage = UIAlertAction(title: "Отправить", style: .default) { [weak self] _ in
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
                                          senderName: UserProfile.shared.getUserProfile().userName ?? "User Name")
        messagesReference.addDocument(data: newMessage.toDict)
    }
}
