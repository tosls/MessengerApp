//
//  FirebaseChannelManager.swift
//  ChatApp
//
//  Created by Антон Бобрышев on 16.11.2021.
//

import Foundation
import Firebase
import FirebaseFirestore

class FirebaseChannelManager {
    
    lazy var actualChannels = [ChannelModel]()
    
    private lazy var db = Firestore.firestore()
    private lazy var referenceChannel = db.collection("channels")
    
    func getChannelsFromFirebase() {
        
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
//                self?.checkingTheRelevanceOfChannels()
            }
//            DispatchQueue.main.async {
//                self?.tableView.reloadData()
//            }
        }
    }
    
   func deleteChannel(identifier: String?) {
        guard let channelIdentifier = identifier else {return}
        referenceChannel.document(channelIdentifier).delete()
    }
    
}
