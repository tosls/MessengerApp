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
    
    private let cellID = "messageCell"
    
    private lazy var db = Firestore.firestore()
    private lazy var reference: CollectionReference = {
        guard let channelIdentifier = channel?.identifier else { fatalError() }
        print(channelIdentifier)
        return db.collection("channels").document(channelIdentifier).collection("messages")
     }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        title = titleName ?? "Messages"
        tableView.register(MessageTableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.separatorStyle = .none
        getMessages()
    }
    
    func getMessages() {
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? MessageTableViewCell else {return UITableViewCell()}
        
        let channelMessage = channelMessages[indexPath.row]
        cell.messageLabel.text = channelMessage.content
        cell.channelMessage = channelMessage

        
//        let chatMessage = chat[indexPath.row]
//        cell.messageLabel.text = chatMessage.text
        cell.messageLabel.textColor = .black
//        cell.chatMessage = chatMessage
        cell.backgroundColor = .white
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        channelMessages.count
    }
}
