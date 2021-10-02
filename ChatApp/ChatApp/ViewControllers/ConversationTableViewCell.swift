//
//  ConversationTableViewCell.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 02.10.2021.
//

import UIKit

class ConversationTableViewCell: UITableViewCell {
    
    struct ConversationModel {
        var name: String?
        var message: String?
//        var date: Date?
//        var online: Bool
//        var hasUnreadMessage: Bool
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//
//        // Initialization code
//    }
    
    
    
    func configure(with model: ConversationModel) {
        nameLabel.text = model.name
//        messageLabel.text = model.message
//        dateLabel.text = formateDate(model.date ?? Date())
    }
    
    func formateDate(_ date: Date) -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd/MM"
        return dateFormater.string(from: date)
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
//
}


