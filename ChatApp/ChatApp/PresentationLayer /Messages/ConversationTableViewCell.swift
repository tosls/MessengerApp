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
 
    func configure(with model: ChannelModel) {
        compareDate(messageDate: model.lastActivity ?? Date(), dateLabel: dateLabel)
        nameLabel.text = model.name
        
        switch model.lastMessage {
        case nil:
            messageLabel.text = "Сообщений еще нет"
        case "":
            messageLabel.text = "Пусто"
        default:
            messageLabel.text = model.lastMessage
        }
       
        messageLabel.font = UIFont.systemFont(ofSize: 13, weight: .thin)
        userImage.layer.cornerRadius = userImage.frame.size.height / 2
        userImage.backgroundColor = .orange
        let imageViewHeight = userImage.bounds.height
        let imageViewWidth = userImage.bounds.width
        let userInitials = UserProfileModel.userNameToInitials(name: model.name )
        userImage.image = UserProfileModel.userInitialsToImage(userInitials, imageViewHeight, imageViewWidth)
    }
    
    private func compareDate(messageDate: Date, dateLabel: UILabel) {
        let dateFormater = DateFormatter()
        let comparison = Calendar.current.compare(messageDate, to: Date(), toGranularity: .day)
        switch comparison {
        case .orderedAscending:
            dateFormater.dateFormat = "dd.MM"
            dateLabel.text = dateFormater.string(from: messageDate)
        default:
            dateFormater.dateFormat = "HH:mm"
            dateLabel.text = dateFormater.string(from: messageDate)
        }
    }
}
