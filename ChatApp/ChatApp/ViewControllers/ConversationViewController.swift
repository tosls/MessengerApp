//
//  ConversationViewController.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 02.10.2021.
//

import UIKit

class ConversationViewController: UITableViewController {
    
    private let cellID = "messageCell"
    var chat: [Message] = messages
    var chatLastMessage: Message?
    var titleName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = titleName ?? "Messages"
        tableView.register(MessageTableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.separatorStyle = .none
        
        setupLastMessage()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! MessageTableViewCell
        
        let chatMessage = chat[indexPath.row]
        cell.messageLabel.text = chatMessage.text
        cell.messageLabel.textColor = .black
        cell.chatMessage = chatMessage
        cell.backgroundColor = .white
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chat.count
    }
    
    private func setupLastMessage() {
        chat.append(chatLastMessage ?? Message(text: "Никакая", isIncoming: true))
    }
}

