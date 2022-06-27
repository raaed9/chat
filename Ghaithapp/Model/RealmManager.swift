//
//  RealmManager.swift
//  Ghaithapp
//
//  Created by Raed Alharbi on 26/10/1443 AH.
//

import Foundation
import RealmSwift

class RealmManager {
    
    static let shared = RealmManager()
    
    let realm = try! Realm()
    
    private init () {}
    
    func save<T: Object> (_ object: T) {
        
        
        do {
           try realm.write {
                realm.add(object, update: .all)
            }
        } catch {
            print("error saving data", error.localizedDescription)
        }
        

    }
}
