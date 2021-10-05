//
//  MessageTableViewCell.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 05.10.2021.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    let messageLabel = UILabel()
    let messageBackgroundView = UIView()
    
    var leadingConstraint: NSLayoutConstraint?
    var trailingConstraint: NSLayoutConstraint?
    
    let messageColor: UIColor = UIColor(red: 0.88,
                                        green: 0.96,
                                        blue: 0.79,
                                        alpha: 1.00)
    
    let inComingMessageColor: UIColor = UIColor(red: 0.87,
                                                green: 0.87,
                                                blue: 0.88,
                                                alpha: 1.00)
    
    var chatMessage: Message? {
        didSet {
            guard let message = chatMessage else {return}
            messageBackgroundView.backgroundColor = message.isIncoming ? inComingMessageColor : messageColor
        
            if message.isIncoming {
                leadingConstraint?.isActive = true
                trailingConstraint?.isActive = false
            } else {
                leadingConstraint?.isActive = false
                trailingConstraint?.isActive = true
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        messageBackgroundView.layer.cornerRadius = 10
        messageBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(messageBackgroundView)
        addSubview(messageLabel)
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.numberOfLines = 0
        
        let constraints = [messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32),
                           messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
                           messageLabel.widthAnchor.constraint(equalToConstant: self.bounds.width / 2),
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
