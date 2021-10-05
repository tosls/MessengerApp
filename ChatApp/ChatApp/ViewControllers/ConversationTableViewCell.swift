//
//  ConversationTableViewCell.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 02.10.2021.
//

import UIKit

class ConversationTableViewCell: UITableViewCell {
   
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!

    func configure(with model: ConversationModel) {
        nameLabel.text = model.name
        messageLabel.text = model.message ?? "No message yet"
        messageLabel.font = model.hasUnreadMessage ? UIFont.systemFont(ofSize: 13, weight: .bold) : UIFont.systemFont(ofSize: 13, weight: .thin)
        
        let date = model.date ?? Date()
        compareDate(date, _dateLabel: dateLabel)

        backgroundColor = model.online ? UIColor(red: 1.00,
                                                 green: 0.95,
                                                 blue: 0.74,
                                                 alpha: 1) : UIColor(red: 1.00,
                                                                     green: 1.00,
                                                                     blue: 1.00,
                                                                     alpha: 1)
        
        userImage.layer.cornerRadius = userImage.frame.size.height / 2
        userImage.backgroundColor = .orange
        let imageViewHeight = userImage.bounds.height
        let imageViewWidth = userImage.bounds.width
        let userInitials = UserProfileModel.userNameToInitials(name: model.name ?? "User Profile")
        
        userImage.image = UserProfileModel.userInitialsToImage(userInitials, imageViewHeight, imageViewWidth)
    }
    
    private func compareDate(_ dialogDate: Date, _dateLabel: UILabel) {
        let dateFormater = DateFormatter()
        let comparison = Calendar.current.compare(dialogDate, to: Date(), toGranularity: .day)
        switch comparison {
        case .orderedAscending:
            dateFormater.dateFormat = "dd.MM"
            dateLabel.text = dateFormater.string(from: dialogDate)
        default:
            dateFormater.dateFormat = "HH:mm"
            dateLabel.text = dateFormater.string(from: dialogDate)
        }
    }
}

