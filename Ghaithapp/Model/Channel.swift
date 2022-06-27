//
//  Channel.swift
//  Ghaithapp
//
//  Created by Raed Alharbi on 11/11/1443 AH.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Channel: Codable {
    
    var id = ""
    var name = ""
    var adminId = ""
    var memberIds = [""]
    var avatarLink = ""
    var aboutChannel = ""
    @ServerTimestamp var createdDate = Date()
    @ServerTimestamp var lastMessageDate = Date()
    
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case name
        case adminId
        case avatarLink
        case aboutChannel
        case createdDate
        case lastMessageDate = "date"
    }
}
