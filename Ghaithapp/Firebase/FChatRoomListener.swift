//
//  FChatRoomListener.swift
//  Ghaithapp
//
//  Created by Raed Alharbi on 22/10/1443 AH.
//

import Foundation
import Firebase

class FChatRoomListener {
    
    static let shared = FChatRoomListener()
    
    private init () {}
    
    
    func saveChatRoom (_ chatRoom: ChatRoom) {
        
        do {
            try FirestoreReference(.Chat).document(chatRoom.id).setData(from: chatRoom)
            
        } catch {
            print("No able to save documents", error.localizedDescription)
        }
        
    }
    
    //MARK: - Delete function
    
    func deleteChatRoom (_ chatRoom: ChatRoom) {
        
        FirestoreReference(.Chat).document(chatRoom.id).delete()
    }
    
    
    
    //MARK: - Download all chat rooms
    
    
    func downloadChatRooms (completion: @escaping(_ allFBChatRooms: [ChatRoom])->Void) {
        
        FirestoreReference(.Chat).whereField(KSENDERID, isEqualTo: User.currentId).addSnapshotListener { snapshot, error in
            
            
            var chatRooms:[ChatRoom] = []
            guard let documents = snapshot?.documents else {
                print("no documents found")
                return
            }
            
            let allFBChatRooms = documents.compactMap { snapshot -> ChatRoom? in
                return try? snapshot.data(as: ChatRoom.self)
            }
            
            for chatRoom in allFBChatRooms {
                if chatRoom.lastMessage != "" {
                    chatRooms.append(chatRoom)
                }
            }
            
            chatRooms.sort(by: {$0.date! > $1.date!})
            
            completion(chatRooms)
        }
    }
    
    //MARK: - reset unread counter
    
    func clearUnreadCounter(chatRoom: ChatRoom) {
        
        var newChatRoom = chatRoom
        newChatRoom.unreadCounter = 0
        self.saveChatRoom(newChatRoom)
    }
    
    func clearUnreadCounterUnsingChatRoomId(chatRoomId: String) {
        
        FirestoreReference(.Chat).whereField(KCHATROOMID, isEqualTo: chatRoomId).whereField(KSENDERID, isEqualTo: User.currentId).getDocuments { querySnapshot, error in
            
            guard let documents = querySnapshot?.documents else {return}
            
            let allChatRooms = documents.compactMap { querySnapshot -> ChatRoom? in
                return try? querySnapshot.data(as: ChatRoom.self)
            }
            
            if allChatRooms.count > 0 {
                self.clearUnreadCounter(chatRoom: allChatRooms.first!)
            }
            
        }
    }
    
    //MARK: - Update Chatroom with New message
    
    private func updateChatRommWithNewMessage(chatRoom: ChatRoom, lastMessage: String) {
        var tempChatRoom = chatRoom
        
        if tempChatRoom.senderId != User.currentId {
            tempChatRoom.unreadCounter += 1
        }
        
        tempChatRoom.lastMessage = lastMessage
        tempChatRoom.date = Date()
        self.saveChatRoom(tempChatRoom)
    }
    
    func updateChatRooms (chatRoomId: String, lastMessaage: String) {
        
        FirestoreReference(.Chat).whereField(KCHATROOMID, isEqualTo: chatRoomId).getDocuments { querySnapshot, error in
            
            
            guard let documents = querySnapshot?.documents else {return}
            
            let allChatRooms = documents.compactMap { querySnapshot -> ChatRoom? in
                
                return try? querySnapshot.data(as: ChatRoom.self)
            }
            
            for chatRoom in allChatRooms {
                self.updateChatRommWithNewMessage(chatRoom: chatRoom, lastMessage: lastMessaage)
            }
        }
    }
    
}
