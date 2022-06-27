//
//  StartChat.swift
//  Ghaithapp
//
//  Created by Raed Alharbi on 22/10/1443 AH.
//

import Foundation
import Firebase



func restartChat(chatRoomId: String, memberIds:[String]) {
    // Download users using memberIds
    FUserListener.shared.downloadUsersFromFirestore(withIds: memberIds) { allUsers in
        
        if allUsers.count > 0 {
            createChatRooms(chatRoomId: chatRoomId, users: allUsers)
        }
    }
    
}



func statChat (sender: User, receiver: User) -> String {
    var chatRoomId = ""
    
    let value = sender.id.compare(receiver.id).rawValue
    
    chatRoomId = value < 0 ? (sender.id + receiver.id) : (receiver.id + sender.id)
    
    
    createChatRooms(chatRoomId: chatRoomId, users: [sender, receiver])
    
    
    return chatRoomId
}


func createChatRooms(chatRoomId: String, users: [User]) {
    // if user has already chatroom we will not create
    
    
    var usersToCreateChatsFor:[String]
    usersToCreateChatsFor = []
    
    for user in users {
        usersToCreateChatsFor.append(user.id)
    }
    
    
    FirestoreReference(.Chat).whereField(KCHATROOMID, isEqualTo: chatRoomId).getDocuments { querySnapshot, error in
        
        guard let snapshot = querySnapshot else {return}
        
        if !snapshot.isEmpty {
            
            for chatData in snapshot.documents {
                
                let currentChat = chatData.data() as Dictionary
                
                if let currentUserId = currentChat[KSENDERID] {
                    if usersToCreateChatsFor.contains(currentUserId as! String) {
                        
                        usersToCreateChatsFor.remove(at: usersToCreateChatsFor.firstIndex(of: currentUserId as! String)!)
                    }
                }
            }
        }
        
        for userId in usersToCreateChatsFor {
            
            let senderUser = userId == User.currentId ? User.currentUser! : getRecieverFrom(users: users)
            
            let receiverUser = userId == User.currentId ? getRecieverFrom(users: users) : User.currentUser!
            
            
            let chatRoomObject = ChatRoom(id: UUID().uuidString, chatRoomId: chatRoomId, senderId: senderUser.id, senderName: senderUser.username, receiverId: receiverUser.id, receiverName: receiverUser.username, date: Date(), memberIds: [senderUser.id, receiverUser.id], lastMessage: "", unreadCounter: 0, avatarLink: receiverUser.avatarLink)
            
            //TODO: Save chat to firestore
            
            FChatRoomListener.shared.saveChatRoom(chatRoomObject)
            
        }
    }
    
}


func getRecieverFrom(users: [User]) -> User {
    
    var allUsers = users
    
    allUsers.remove(at: allUsers.firstIndex(of: User.currentUser!)!)
    
    return allUsers.first!
}
