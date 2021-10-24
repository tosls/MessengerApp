//
//  MessageModel.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 03.10.2021.
//

import UIKit

struct MessageModel: MessageCellConfiguration {
    var text: String?
    var isIncoming: Bool
}

protocol MessageCellConfiguration {
    var text: String? {get set}
    var isIncoming: Bool {get set}
}
