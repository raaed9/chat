//
//  FCollectionReference.swift
//  Ghaithapp
//
//  Created by Raed Alharbi on 15/10/1443 AH.
//

import Foundation
import Firebase


enum FCollectionRefernce: String {
      case User
      case Chat
      case Message
      case Typing
      case Channel
}



func FirestoreReference(_ collectionReference: FCollectionRefernce) -> CollectionReference {
    
    return Firestore.firestore().collection(collectionReference.rawValue)
    
}
