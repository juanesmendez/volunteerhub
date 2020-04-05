//
//  UsersDB.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 30/03/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import Foundation
import Firebase

class UsersDB {
    
    func addActivityToUser(userId:String, activity: Activity){
        let db = Firestore.firestore()
        
        db.collection("users").document(userId).updateData([
            "activities": FieldValue.arrayUnion([activity.id])
        ]){ err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document updated")
            }
        }
    }
    
    func getUserData(completion: @escaping (Dictionary<String, Any>?) -> ()) {
        let db = Firestore.firestore()
        let userId = Auth.auth().currentUser?.uid ?? ""
        
        let docRef = db.collection("users").document(userId)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                DispatchQueue.main.async {
                    completion(document.data())
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    
}

