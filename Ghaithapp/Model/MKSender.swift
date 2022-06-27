//
//  MKSender.swift
//  Ghaithapp
//
//  Created by Raed Alharbi on 26/10/1443 AH.
//

import Foundation
import MessageKit
import UIKit

struct MKSender: SenderType, Equatable {
    
    var senderId: String
    var displayName: String
}
