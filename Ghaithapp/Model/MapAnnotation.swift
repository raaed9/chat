//
//  MapAnnotation.swift
//  Ghaithapp
//
//  Created by Raed Alharbi on 10/11/1443 AH.
//

import Foundation
import MapKit

class MapAnnotation: NSObject, MKAnnotation {
    
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init (title: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
}
