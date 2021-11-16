//
//  ConversationTableView.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 16.11.2021.
//

import UIKit
import CoreData

class ConversationTableView: NSObject, UITableViewDataSource {
    
    private let identifier = String(describing: ConversationTableViewCell.self)
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = ChannelsManager().fetchedResultsController.sections else {return 0}
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? ConversationTableViewCell else {
            return UITableViewCell()
        }
        let channels = ChannelsManager().fetchedResultsController.object(at: indexPath)
        cell.configure(with: ChannelModel(identifier: channels.identifier ?? "no identifier",
                                          name: channels.name ?? "No name",
                                          lastMessage: channels.lastMessage,
                                          lastActivity: channels.lastActivity))
        return cell
    }
}
