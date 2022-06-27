//
//  User.swift
//  Ghaithapp
//
//  Created by Raed Alharbi on 15/10/1443 AH.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift




struct User: Codable, Equatable {
    
    var id = ""
    var username: String
    var email: String
    var pushId = ""
    var avatarLink = ""
    var status: String
    
    
    
    
    static var currentId: String {
        
        return Auth.auth().currentUser!.uid
    }
    
    
    static var currentUser: User? {
        
        if Auth.auth().currentUser != nil {
        
            if let data = userDefaults.data(forKey: KCURRENTUSER) {
            
            let decoder = JSONDecoder()
            
            do {
            
            let userObject = try decoder.decode(User.self , from: data)
            
            return userObject
        } catch {
            
            print (error.localizedDescription)
            
           }
       }
    }
        return nil

       }
    
    static func == (lhs: User, rhs: User)-> Bool {
        lhs.id == rhs.id
    }
    
}


func saveUserLocally(_ user: User) {
    
    let econder = JSONEncoder()
    
    do{
        let data = try econder.encode(user)
        
        userDefaults.set(data, forKey: KCURRENTUSER)
    } catch {
        print (error.localizedDescription)
    }
    
}
