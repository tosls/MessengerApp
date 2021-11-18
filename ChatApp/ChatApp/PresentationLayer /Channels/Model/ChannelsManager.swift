//
//  ChannelsManager.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 16.11.2021.
//

import Foundation
import Firebase
import FirebaseFirestore
import CoreData

class ChannelsManager {
    
    private let frcDelegate = FRCDelegate()
    lazy var actualChannels = [ChannelModel]()
    
    lazy var fetchedResultsController: NSFetchedResultsController<DBChannel> = {
        let request: NSFetchRequest<DBChannel> = DBChannel.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "lastActivity", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: request,
                                                                  managedObjectContext: CoreDataManager.shared.contex,
                                                                  sectionNameKeyPath: nil,
                                                                  cacheName: nil)
        fetchedResultsController.delegate = frcDelegate
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error)
        }
        return fetchedResultsController
    }()
    
    private lazy var db = Firestore.firestore()
    private lazy var referenceChannel = db.collection("channels")
    
    func getChannelsFromFirebase(tableView: UITableView) {
        referenceChannel.addSnapshotListener { [weak self] snapshot, error in
            if let error = error {
                print(error)
            } else {
                guard let snap = snapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                self?.actualChannels.removeAll()

                for document in snap.documents {
                    let chanelName = document.data()["name"] as? String ?? "Channel Name"
                    let lastMessage = document.data()["lastMessage"] as? String ?? "Last Message"
                    let identifier = document.documentID
                    let lastMessageDate = document.data()["lastActivity"] as? Timestamp
                
                    self?.actualChannels.append(ChannelModel(
                        identifier: identifier,
                        name: chanelName,
                        lastMessage: lastMessage,
                        lastActivity: lastMessageDate?.dateValue() ?? Date()
                    )
                    )
                }
                self?.printTest()
                self?.checkingTheRelevanceOfChannels()
                self?.printTest()
            }
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        }
    }
    
    func printTest() {
        print("AAAA")
    }
    

    
   func deleteChannel(identifier: String?) {
        guard let channelIdentifier = identifier else {return}
        referenceChannel.document(channelIdentifier).delete()
    }
    
    func addChannelToFirebase(newChannel: ChannelModel) {
        referenceChannel.addDocument(data: newChannel.toDict)
    }
    
    private func checkingTheRelevanceOfChannels() {
        guard let channelsFromCoreData = fetchedResultsController.fetchedObjects else {return}
        if actualChannels.count < channelsFromCoreData.count {
            var channelsIdentifier: [String] = []
            for channel in actualChannels {
                channelsIdentifier.append(channel.identifier)
            }
            let request: NSFetchRequest<DBChannel> = DBChannel.fetchRequest()
            let predicate = NSPredicate(format: "NOT identifier IN %@", channelsIdentifier)
            request.predicate = predicate
            do {
                let channelData = try CoreDataManager.shared.contex.fetch(request)
                for channelInCoreData in channelData {
                    CoreDataManager.shared.deleteChannel(object: channelInCoreData)
                }
            } catch let error as NSError {
                print(error.debugDescription)
            }
        } else if actualChannels.count > channelsFromCoreData.count {
            for channel in actualChannels {
                CoreDataManager.shared.saveChannelsWithCoreData(channel: ChannelModel(
                    identifier: channel.identifier,
                    name: channel.name,
                    lastMessage: channel.lastMessage,
                    lastActivity: channel.lastActivity
                )
                )
            }
        }
    }
}
