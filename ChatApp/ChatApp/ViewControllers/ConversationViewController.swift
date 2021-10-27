//
//  ConversationViewController.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 02.10.2021.
//

import UIKit
import Firebase

class ConversationViewController: UITableViewController {
    
    var titleName: String?
    var channel: ChannelModel?
    var channelMessages = [Message]()
    
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
//        sendMessage()
    }
    
    private func sendMessage() {
        
        let newMessage: Message = Message(content: "🦦",
                                          created: Date(),
                                          senderId: UserSenderID.shared.getUserSenderId(),
                                          senderName: UserProfile.shared.getUserProfile().userName ?? "User Name")
        messagesReference.addDocument(data: newMessage.toDict)
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
                    let created = data["created"] as? Date ?? Date()
                    
                    self?.channelMessages.append(Message(
                        content: content,
                        created: created,
                        senderId: sendeId,
                        senderName: senderName)
                    )
                }
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? MessageTableViewCell else {return UITableViewCell()}
        let channelMessage = channelMessages[indexPath.row]
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
}
