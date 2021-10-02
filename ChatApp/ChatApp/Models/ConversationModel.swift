//
//  ConversationModel.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 03.10.2021.
//

import UIKit

struct ConversationModel: ConversationCellConfiguretion {
    var name: String?
    var message: String?
    var date: Date?
    var online: Bool
    var hasUnreadMessage: Bool
    
}

protocol ConversationCellConfiguretion {
    var name: String? {get set}
    var message: String? {get set}
    var date: Date? {get set}
    var online: Bool {get set}
    var hasUnreadMessage: Bool {get set}
}
