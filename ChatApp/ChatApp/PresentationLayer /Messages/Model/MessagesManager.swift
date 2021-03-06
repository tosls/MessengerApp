//
//  MessagesManager.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 17.11.2021.
//

import Foundation
import Firebase
import FirebaseFirestore
import CoreData

class MessagesManager {
    
    var actualChannel: DBChannel?
    var channelMessages = [Message]()
    
    private let frcDelegate = FRCDelegate()
    
    private lazy var db = Firestore.firestore()

    func getMessagesReferenceFormFirebase(channelIdentifier: String) -> CollectionReference {
        return db.collection("channels").document(channelIdentifier).collection("messages")
    }

    func fetchedResult(channelIdentifier: String) -> NSFetchedResultsController<DBMessage> {
        let request: NSFetchRequest<DBMessage> = DBMessage.fetchRequest()
    
        let sortDescription = NSSortDescriptor(key: "created", ascending: true)
        request.sortDescriptors = [sortDescription]
        let channelID = channelIdentifier
        let predicate = NSPredicate(format: "channel.identifier == %@", channelID)
        request.predicate = predicate
        request.fetchBatchSize = 20
        let fetchedResultController = NSFetchedResultsController(fetchRequest: request,
                                                                 managedObjectContext: CoreDataManager.shared.contex,
                                                                 sectionNameKeyPath: nil,
                                                                 cacheName: nil)
        
        fetchedResultController.delegate = frcDelegate
        do {
            try fetchedResultController.performFetch()
        } catch {
            print(error)
        }
        return fetchedResultController
    }
    
    func getChannelMessages(channelIdentifier: String, tableView: UITableView) {
        let messagesReference = getMessagesReferenceFormFirebase(channelIdentifier: channelIdentifier)
        messagesReference.addSnapshotListener { snapshot, error in
            if let error = error {
                print(error)
                return
            } else {
                guard let snap = snapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                self.channelMessages.removeAll()
                for documnet in snap.documents {
                    let content = documnet.data()["content"] as? String ?? "Channel Name"
                    let senderName = documnet.data()["senderName"] as? String ?? "Sender Name"
                    let senderID = documnet.data()["senderid"] as? String ?? "senderid Name"
                    let created = documnet.data()["created"] as? Timestamp
                
                    self.channelMessages.append(Message(
                        content: content,
                        created: created?.dateValue() ?? Date(),
                        senderid: senderID,
                        senderName: senderName
                    )
                    )
                }
                self.checkingTheMessages(channelIdentifier: channelIdentifier)
            }
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        }
    }
    
    func checingImageInMessage(messageText: String, messageCell: MessageTableViewCell) {
        if validateURL(url: messageText) {
            guard let imageURL = URL(string: messageText) else {return}
            let queue = DispatchQueue.global(qos: .userInteractive)
            queue.async {
                if let data = try? Data(contentsOf: imageURL) {
                    DispatchQueue.main.async {
                        messageCell.sendedImage.image = UIImage(data: data)
                    }
                } else {
                    DispatchQueue.main.async {
                        messageCell.messageLabel.text = "The API is not supported, imageURL: \(imageURL)"
                    }
                }
            }
        } else {
            messageCell.messageLabel.text = messageText
        }
    }
    
    private func validateURL(url: String) -> Bool {
            let regex = "http[s]?://(([^/:.[:space:]]+(.[^/:.[:space:]]+)*)|([0-9](.[0-9]{3})))(:[0-9]+)?((/[^?#[:space:]]+)([^#[:space:]]+)?(#.+)?)?"
            let test = NSPredicate(format: "SELF MATCHES %@", regex)
            let result = test.evaluate(with: url)
            return result
     }

    private func checkingTheMessages(channelIdentifier: String) {
        let messages = fetchedResult(channelIdentifier: channelIdentifier)
        guard let messagesCD = messages.fetchedObjects else {
            return
        }
        if channelMessages.count > messagesCD.count {
            for message in channelMessages {
                CoreDataManager.shared.saveMessagesWithCoreData(message:
                                                                    Message(
                                                                        content: message.content,
                                                                        created: message.created,
                                                                        senderid: message.senderid,
                                                                        senderName: message.senderName
                                                                    ),
                                                                identifier: channelIdentifier
                )
            }
        }
    }
}
