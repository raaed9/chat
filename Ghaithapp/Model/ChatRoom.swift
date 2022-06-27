//
//  ChatRoom.swift
//  Ghaithapp
//
//  Created by Raed Alharbi on 21/10/1443 AH.
//

import Foundation
import FirebaseFirestoreSwift

struct ChatRoom: Codable {
    
    var id = ""
    var chatRoomId = ""
    var senderId = ""
    var senderName = ""
    var receiverId = ""
    var receiverName = ""
    @ServerTimestamp var date = Date()
    var memberIds = [""]
    var lastMessage = ""
    var unreadCounter = 0
    var avatarLink = ""
}
