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

    var channelMessage: Message? {
        didSet {
            guard let message = channelMessage else {return}
            messageBackgroundView.backgroundColor = messageColor
            
            if message.senderid == UserSenderID.shared.getUserSenderId() {
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
        
        addSubview(messageBackgroundView)
        addSubview(userNameLabel)
        addSubview(messageLabel)
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.numberOfLines = 0
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.numberOfLines = 0
        
        let constraints = [messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32),
                           messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
                           messageLabel.widthAnchor.constraint(equalToConstant: self.bounds.width / 2),
                           
                           userNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
                           userNameLabel.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: 0),

                           messageBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -16),
                           messageBackgroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -16),
                           messageBackgroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16),
                           messageBackgroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 16)
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
