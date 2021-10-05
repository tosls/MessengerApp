//
//  ConversationsModel.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 03.10.2021.
//

import UIKit

struct Conversations {
    var userStatus: Status
    var conversation: [Conversation]
}

enum Status: String {
    case online
    case history
}

struct Conversation {
        let userName: String?
        let message: String?
        var date: Date?
        let status: Bool
        let hasUnreadMessage: Bool
}

var conversations: [Conversations] = [
    Conversations(
        userStatus: .online,
        conversation: [
            Conversation(userName: "Charles Bukowski",
                    message: "Пошли в бар?",
                    date: Date(),
                    status: true,
                    hasUnreadMessage: false),
            Conversation(userName: "Ayn Rand",
                    message: "За исключением собственных имен, любое слово — абстракция",
                    date: Date(),
                    status: true,
                    hasUnreadMessage: false),
            Conversation(userName: "Harper Lee",
                    message: "Почти все люди хорошие, когда их в конце концов поймешь.",
                    date: Date(),
                    status: true,
                    hasUnreadMessage: true),
            Conversation(userName: "Vladimir Nabokov",
                    message: "Я люблю шахматы, однако обман в шахматах, так же как и в искусстве, лишь часть игры",
                    date: Date(timeIntervalSinceNow: -157120.43923699856),
                    status: true,
                    hasUnreadMessage: false),
            Conversation(userName: "Katherine Dunn",
                    message: "Надежда – хорошее чувство, и в ней всегда присутствует доля риска.",
                    date: Date(timeIntervalSinceNow: -153533.27118694782),
                    status: true,
                    hasUnreadMessage: false),
            Conversation(userName: "Edgar Allan Poe",
                    message: "Если Вы хотите что-то тотчас же забыть, запишите, что об этом следует помнить",
                    date: Date(timeIntervalSinceNow: -265163.8063650131),
                    status: true,
                    hasUnreadMessage: true),
            Conversation(userName: "Howard Lovecraft",
                    message: "Запредельный ужас, бывает, милосердно отнимает память.",
                    date: Date(timeIntervalSinceNow: -239977.51269102097),
                    status: true,
                    hasUnreadMessage: false),
            Conversation(userName: "William Golding",
                    message: "Объяснения отнимают у вещей всю прелесть",
                    date: Date(timeIntervalSinceNow: -236393.172852993),
                    status: true,
                    hasUnreadMessage: true),
            Conversation(userName: "Markus Zusak",
                    message: "Был понедельник, и они шли к солнцу по канату.",
                    date: Date(timeIntervalSinceNow: -322805.39335000515),
                    status: true,
                    hasUnreadMessage: true),
            Conversation(userName: "Orhan Pamuk",
                    message: "Когда человек счастлив, он не знает, что он счастлив",
                    date: Date(timeIntervalSinceNow: -409219.00280702114),
                    status: true,
                    hasUnreadMessage: false)
        ]
        ),
    Conversations(
        userStatus: .history,
        conversation: [
            Conversation(userName: "Jerome Salinger",
                    message: "Если девушка приходит на свидание красивая - кто будет расстраиваться, что она опоздала? Никто!",
                    date: Date(timeIntervalSinceNow: -956217.4196799994),
                    status: false,
                    hasUnreadMessage: true),
            Conversation(userName: "George Martin",
                    message: "Читатель проживает тысячу жизней до того, как умрет",
                    date: Date(timeIntervalSinceNow: -1046199.1714099646),
                    status: false,
                    hasUnreadMessage: false),
            Conversation(userName: "Iain Banks",
                    message: "Иногда мои мысли ну никак не могут между собой договориться, да и чувства тоже; не мозг, право слово, а целое народное собрание",
                    date: Date(timeIntervalSinceNow: -524237.1887830496),
                    status: false,
                    hasUnreadMessage: true),
            Conversation(userName: "Aldous Huxley",
                    message: "История как мясной паштет: лучше не вглядываться, как его приготовляют.",
                    date: Date(timeIntervalSinceNow: -610584.104779005),
                    status: false,
                    hasUnreadMessage: false),
            Conversation(userName: "John Ronald Tolkien",
                    message: "Спору нет, если ищешь, то всегда что-нибудь найдешь, но совсем не обязательно то, что искал",
                    date: Date(timeIntervalSinceNow: -254159.36281394958),
                    status: false,
                    hasUnreadMessage: true),
            Conversation(userName: "Jack Kerouac",
                    message: nil,
                    date: Date(timeIntervalSinceNow: -2849734.069650054),
                    status: false,
                    hasUnreadMessage: false),
            Conversation(userName: "Erich Maria Remarque",
                    message: "Немногое на свете долго бывает важным.",
                    date: Date(timeIntervalSinceNow: -91423.49729800224),
                    status: false,
                    hasUnreadMessage: false),
            Conversation(userName: "Irvine Welsh",
                    message: "Книги по большому счету должны тебе помогать что-то делать.",
                    date: Date(timeIntervalSinceNow: -869039.9105629921),
                    status: false,
                    hasUnreadMessage: false),
            Conversation(userName: "Richard Feynman",
                    message: "Узнайте, как устроен остальной мир. Разнообразие – стоящая вещь",
                    date: Date(timeIntervalSinceNow: -5304305.651039958),
                    status: false,
                    hasUnreadMessage: false),
            Conversation(userName: "Neil deGrasse Tyson",
                    message: "Мы не просто живем во Вселенной - Вселенная живет внутри нас",
                    date: Date(timeIntervalSinceNow: -1761891.0825459957),
                    status: false,
                    hasUnreadMessage: false)
        ])
]
