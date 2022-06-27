//
//  LocationMessage.swift
//  Ghaithapp
//
//  Created by Raed Alharbi on 10/11/1443 AH.
//

import Foundation
import CoreLocation
import MessageKit

class LocationMessage: NSObject, LocationItem {
    var location: CLLocation
    var size: CGSize
    
    init (location: CLLocation) {
        self.location = location
        self.size = CGSize(width: 240, height: 240)
    }
    
    
}
