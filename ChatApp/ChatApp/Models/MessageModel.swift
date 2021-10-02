//
//  MessageModel.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 03.10.2021.
//

import UIKit

struct MessageModel: MessageCellConfiguration {
    var text: String?
    
    
}
protocol MessageCellConfiguration {
    var text: String? {get set}
}
