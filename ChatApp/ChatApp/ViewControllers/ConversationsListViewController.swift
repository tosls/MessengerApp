//
//  ConversationsViewController.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 02.10.2021.
//

import UIKit

class ConversationsListViewController: UIViewController {
    
    private let identifier = String(describing: ConversationTableViewCell.self)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.frame, style: .plain)

        tableView.register(UINib(nibName: String(describing: ConversationTableViewCell.self), bundle: nil), forCellReuseIdentifier: identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Tinkoff Chat"
        view.addSubview(tableView)
        print(Date())
    }
}

extension ConversationsListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        conversations.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        conversations[section].dialogs.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionName = conversations[section].status
        
        switch sectionName {
        case .online:
            return Status.online.rawValue
        case .oflline:
            return Status.oflline.rawValue
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let conversation = conversations[indexPath.section]
        let dialog = conversation.dialogs[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? ConversationTableViewCell else {
            return UITableViewCell() }
        
        cell.configure(with: ConversationModel(name: dialog.userName, message: dialog.message, online: dialog.status, hasUnreadMessage: dialog.hasUnreadMessage))
        
        return cell
    }
}

extension ConversationsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let conversationVC = ConversatioViewController()
        let rowIndex = indexPath.row
        let sectionIndex = indexPath.section
        let title = conversations[sectionIndex].dialogs[rowIndex]
    }
}
