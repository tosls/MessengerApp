//
//  MessageTableViewCell.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 05.10.2021.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    let messageLabel = UILabel()
    let userNameLabel = UILabel()
    let messageBackgroundView = UIView()
    var sendedImage = UIImageView()
    var leadingConstraint: NSLayoutConstraint?
    var trailingConstraint: NSLayoutConstraint?
    
    let messageColor: UIColor = UIColor(red: 0.88,
                                        green: 0.96,
                                        blue: 0.79,
                                        alpha: 1.00)
    
    let SendingMessageColor: UIColor = UIColor(red: 0.87,
                                                green: 0.87,
                                                blue: 0.88,
                                                alpha: 1.00)
    
    var channelMessageID: String? {
        didSet {
            guard let messageID = channelMessageID  else {return}
            messageBackgroundView.backgroundColor = messageColor
 
            if messageID == UserSenderID.shared.getUserSenderId() {
                leadingConstraint?.isActive = false
                trailingConstraint?.isActive = true
                userNameLabel.isHidden = true

                messageBackgroundView.backgroundColor = SendingMessageColor
                
            } else {
                leadingConstraint?.isActive = true
                trailingConstraint?.isActive = false
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        messageBackgroundView.layer.cornerRadius = 10
        messageBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.font = userNameLabel.font.withSize(14)
        sendedImage.clipsToBounds = true
        
        addSubview(messageBackgroundView)
        addSubview(userNameLabel)
        
        messageLabel.addSubview(sendedImage)
        addSubview(messageLabel)
        
        sendedImage.layer.cornerRadius = messageBackgroundView.layer.cornerRadius
    
        sendedImage.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        messageLabel.numberOfLines = 0
        userNameLabel.numberOfLines = 0
        
        let constraints = [messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32),
                           messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
                           messageLabel.widthAnchor.constraint(equalToConstant: self.bounds.width / 2),
                           userNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
                           userNameLabel.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: 0),
                           messageBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -16),
                           messageBackgroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -16),
                           messageBackgroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16),
                           messageBackgroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 16),
                           sendedImage.leadingAnchor.constraint(equalTo: messageBackgroundView.leadingAnchor, constant: 0),
                           sendedImage.trailingAnchor.constraint(equalTo: messageBackgroundView.trailingAnchor, constant: 0),
                           sendedImage.topAnchor.constraint(equalTo: messageBackgroundView.topAnchor, constant: 0),
                           sendedImage.bottomAnchor.constraint(equalTo: messageBackgroundView.bottomAnchor, constant: 0),
                           sendedImage.widthAnchor.constraint(equalToConstant: messageLabel.bounds.width)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        leadingConstraint = messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32)
        leadingConstraint?.isActive = false
        trailingConstraint = messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        trailingConstraint?.isActive = true
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
