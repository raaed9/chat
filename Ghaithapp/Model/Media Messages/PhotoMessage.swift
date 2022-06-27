//
//  PhotoMessage.swift
//  Ghaithapp
//
//  Created by Raed Alharbi on 07/11/1443 AH.
//

import Foundation
import MessageKit

class PhotoMessage: NSObject, MediaItem {
    var url: URL?
    
    var image: UIImage?
    
    var placeholderImage: UIImage
    
    var size: CGSize
    
    init (path: String) {
        self.url = URL(fileURLWithPath: path)
        self.placeholderImage = UIImage(named: "photoPlaceholder")!
        self.size = CGSize(width: 240, height: 240)
    }
    
}
