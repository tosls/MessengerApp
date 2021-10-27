//
//  MessageModel.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 03.10.2021.
//

import UIKit
import Firebase

struct Message {
    
    let content: String
    let created: Date
    let senderId: String
    let senderName: String
}

extension Message {
    
    var toDict: [String: Any] {
        return ["content": content,
                "created": Timestamp(date: created),
                "senderID": senderId,
                "senderName": senderName]
    }
}
