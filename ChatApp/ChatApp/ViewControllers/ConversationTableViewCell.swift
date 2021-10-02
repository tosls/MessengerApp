//
//  ConversationTableViewCell.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 02.10.2021.
//

import UIKit

class ConversationTableViewCell: UITableViewCell {
   
//    struct ConversationModel {
//        var name: String?
//        var message: String?
//        var date: Date?
//        var online: Bool
////        var hasUnreadMessage: Bool
//    }
//    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!


    func configure(with model: ConversationModel) {
        nameLabel.text = model.name
        messageLabel.text = model.message ?? "No message yet"
        let date = model.date ?? Date()
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd:MM"
        
        dateLabel.text = dateFormater.string(from: date)
        backgroundColor = model.online ? UIColor(red: 1.00,
                                                 green: 0.95,
                                                 blue: 0.74,
                                                 alpha: 1) : UIColor(red: 1.00,
                                                                     green: 1.00,
                                                                     blue: 1.00,
                                                                     alpha: 1)
        
    }
    
    
    func formateDate(_ date: Date) -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd/MM"
        return dateFormater.string(from: date)
    }
}


