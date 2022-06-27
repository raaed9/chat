//
//  AudioMessage.swift
//  Ghaithapp
//
//  Created by Raed Alharbi on 10/11/1443 AH.
//

import Foundation
import MessageKit

class AudioMessage: NSObject , AudioItem {
    var url: URL
    var duration: Float
    var size: CGSize
    
    init(duration: Float) {
        
        self.url = URL(fileURLWithPath: "")
        self.size = CGSize(width: 180, height: 35)
        self.duration = duration
    }
}
