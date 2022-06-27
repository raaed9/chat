//
//  VideoMessage.swift
//  Ghaithapp
//
//  Created by Raed Alharbi on 08/11/1443 AH.
//

import Foundation
import MessageKit

class VideoMessage: NSObject, MediaItem {
    var url: URL?
    
    var image: UIImage?
    
    var placeholderImage: UIImage
    
    var size: CGSize
    
    init (url: URL?) {
        self.url = url
        self.placeholderImage = UIImage(named: "photoPlaceholder")!
        self.size = CGSize(width: 240, height: 240)
    }
    
}
