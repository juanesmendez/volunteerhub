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
        /*
        db.collection("users").document(userId).collection("activities").document(activity.id).setData([
            "id": activity.id
        ]){ err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added")
            }
        }
        */
    }
    
}

