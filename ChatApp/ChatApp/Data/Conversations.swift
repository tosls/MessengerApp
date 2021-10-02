//
//  ConversationsModel.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 03.10.2021.
//

import UIKit

struct Conversations {
    let status: Status
    let dialogs: [Dialogs]
}

struct Dialogs {
    let userName: String?
    let message: String?
    let date: Date?
    let status: Bool
    let hasUnreadMessage: Bool
    
}

enum Status: String {
    case online = "Online"
    case oflline = "History"
}

var conversations: [Conversations] = [
    Conversations(
        status: .online,
        dialogs: [
            Dialogs(userName: "Charles Bukowski",
                    message: "Пошли в бар?",
                    date: Date(),
                    status: true,
                    hasUnreadMessage: false),
            Dialogs(userName: "Ayn Rand",
                    message: "За исключением собственных имен, любое слово — абстракция",
                    date: Date(),
                    status: true,
                    hasUnreadMessage: false),
            Dialogs(userName: "Harper Lee",
                    message: "Почти все люди хорошие, когда их в конце концов поймешь.",
                    date: Date(),
                    status: true,
                    hasUnreadMessage: true),
            Dialogs(userName: "Vladimir Nabokov",
                    message: "Я люблю шахматы, однако обман в шахматах, так же как и в искусстве, лишь часть игры",
                    date: Date(),
                    status: true,
                    hasUnreadMessage: false),
            Dialogs(userName: "Katherine Dunn",
                    message: "Надежда – хорошее чувство, и в ней всегда присутствует доля риска.",
                    date: Date(),
                    status: true,
                    hasUnreadMessage: false),
            Dialogs(userName: "Edgar Allan Poe",
                    message: "Если Вы хотите что-то тотчас же забыть, запишите, что об этом следует помнить",
                    date: Date(),
                    status: true,
                    hasUnreadMessage: true),
            Dialogs(userName: "Howard Lovecraft",
                    message: "Запредельный ужас, бывает, милосердно отнимает память.",
                    date: Date(),
                    status: true,
                    hasUnreadMessage: false),
            Dialogs(userName: "William Golding",
                    message: "Объяснения отнимают у вещей всю прелесть",
                    date: Date(),
                    status: true,
                    hasUnreadMessage: true),
            Dialogs(userName: "Markus Zusak",
                    message: "Был понедельник, и они шли к солнцу по канату.",
                    date: Date(),
                    status: true,
                    hasUnreadMessage: true),
            Dialogs(userName: "Orhan Pamuk",
                    message: "Когда человек счастлив, он не знает, что он счастлив",
                    date: Date(),
                    status: true,
                    hasUnreadMessage: false)
        ]
        ),
    Conversations(
        status: .oflline,
        dialogs: [
            Dialogs(userName: "Jerome Salinger",
                    message: "Если девушка приходит на свидание красивая - кто будет расстраиваться, что она опоздала? Никто!",
                    date: Date(),
                    status: false,
                    hasUnreadMessage: true),
            Dialogs(userName: "George Martin",
                    message: "Читатель проживает тысячу жизней до того, как умрет",
                    date: Date(),
                    status: false,
                    hasUnreadMessage: false),
            Dialogs(userName: "Iain Banks",
                    message: "Иногда мои мысли ну никак не могут между собой договориться, да и чувства тоже; не мозг, право слово, а целое народное собрание",
                    date: Date(),
                    status: false,
                    hasUnreadMessage: true),
            Dialogs(userName: "Aldous Huxley",
                    message: "История как мясной паштет: лучше не вглядываться, как его приготовляют.",
                    date: Date(),
                    status: false,
                    hasUnreadMessage: false),
            Dialogs(userName: "John Ronald Tolkien",
                    message: "Спору нет, если ищешь, то всегда что-нибудь найдешь, но совсем не обязательно то, что искал",
                    date: Date(),
                    status: false,
                    hasUnreadMessage: true),
            Dialogs(userName: "Jack Kerouac",
                    message: nil,
                    date: Date(),
                    status: false,
                    hasUnreadMessage: false),
            Dialogs(userName: "Erich Maria Remarque",
                    message: "Немногое на свете долго бывает важным.",
                    date: Date(),
                    status: false,
                    hasUnreadMessage: false),
            Dialogs(userName: "Irvine Welsh",
                    message: "Книги по большому счету должны тебе помогать что-то делать. ",
                    date: Date(),
                    status: false,
                    hasUnreadMessage: false),
            Dialogs(userName: "Richard Feynman",
                    message: "Узнайте, как устроен остальной мир. Разнообразие – стоящая вещь",
                    date: Date(),
                    status: false,
                    hasUnreadMessage: false),
            Dialogs(userName: "Neil deGrasse Tyson",
                    message: "Мы не просто живем во Вселенной - Вселенная живет внутри нас",
                    date: Date(),
                    status: false,
                    hasUnreadMessage: false)
        ])
]

