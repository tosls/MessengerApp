//
//  Messages.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 05.10.2021.
//

import UIKit

struct Message {
    var text: String?
    var isIncoming: Bool
}

var messages = [Message(text: "Привет!", isIncoming: true),
                Message(text: "Привет!", isIncoming: false),
                Message(text: "У меня тут мысль появилась", isIncoming: true),
                Message(text: "Какая?", isIncoming: false),
                Message(text: "Вот такая:", isIncoming: true)]
