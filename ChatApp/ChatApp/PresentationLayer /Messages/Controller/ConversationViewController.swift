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
    var actualChannel: DBChannel?
    
    lazy var channelIdentifier = actualChannel?.identifier ?? ""
    
    private let cellIdentifier = "messageCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = titleName ?? "Messages"
        
        tableView.register(MessageTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.separatorStyle = .none
        
        MessagesManager().getChannelMessages(channelIdentifier: channelIdentifier, tableView: tableView)
        setupNewMessageButton()
    }
    
    // MARK: Work with TableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let fetchedMessages = MessagesManager().fetchedResult(channelIdentifier: channelIdentifier)
        guard let sections = fetchedMessages.sections else {return 0}
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MessageTableViewCell else {return UITableViewCell()}
        let messagesManager = MessagesManager()
        let fetchedMessages = messagesManager.fetchedResult(channelIdentifier: channelIdentifier)
        let channelMessages = fetchedMessages.object(at: indexPath)
        messagesManager.checingImageInMessage(messageText: channelMessages.content ?? "No message", messageCell: cell)
        
        cell.channelMessageID = channelMessages.senderId
        cell.userNameLabel.text = channelMessages.senderName
        cell.messageLabel.textColor = .black
        cell.backgroundColor = .white
        
        return cell
    }
    
    @objc func addNewChannelButtonTapped(_ sender: Any) {
        newMessageAlert()
    }
    
    // MARK: Sending Message

    private func setupNewMessageButton() {
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
        
        let sendImage = UIAlertAction(title: "Image",
                                        style: .default) { [weak self] _ in
            self?.sendImage()
        }
        
        alert.addAction(cancel)
        alert.addAction(sendImage)
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
    
    private func sendImage() {
        let imageVC = ImageCollectionViewController()
        imageVC.newProfileImageURLClosure = { [weak self] (text) in
            if let vc = self {
                vc.sendMessage(message: text)
            }
        }
        present(imageVC, animated: true, completion: nil)
    }
    
    private func sendMessage(message: String) {
        let newMessage: Message = Message(content: message,
                                          created: Date(),
                                          senderid: UserSenderID.shared.getUserSenderId(),
                                          senderName: UserProfile.shared.getUserProfile().userName ?? "User Name"
        )
        let messagesReference = MessagesManager().getMessagesReferenceFormFirebase(channelIdentifier: channelIdentifier)
        messagesReference.addDocument(data: newMessage.toDict)
    }
}
