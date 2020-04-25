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
    
    func removeActivityFromUser(userId:String, activity: Activity){
        let db = Firestore.firestore()
        
        db.collection("users").document(userId).updateData([
            "activities": FieldValue.arrayRemove([activity.id])
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
                let source = document.metadata.isFromCache ? "local cache" : "server"
                print("Metadata: Data fetched from \(source)")
                DispatchQueue.main.async {
                    completion(document.data())
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func addInterestActivityToUser(userId: String, activity: Activity) {
        let db = Firestore.firestore()
        
        db.collection("users").document(userId).updateData([
            "interested": FieldValue.arrayUnion([activity.id])
        ]){ err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document updated")
            }
        }
    }
    
    func deleteInterestActivityOfUser(userId: String, interestedList: [String]) {
        let db = Firestore.firestore()
        
        db.collection("users").document(userId).updateData([
            "interested": interestedList
        ]){ err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document updated")
            }
        }
    }
    
    func getVolunteersInActivity(volunteersIds: [String], completion: @escaping ([Volunteer]) -> ()) {
        print("Querying volunteers belonging to activity...")
        let db = Firestore.firestore()
        
        let usersRef = db.collection("users")
        
        usersRef.whereField(FieldPath.documentID(), in: volunteersIds).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    //var users = [Dictionary<String, Any>?]()
                    var volunteers = [Volunteer]()
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        let id = document.documentID
                        let username = document.data()["username"] as! String
                        let firstname = document.data()["firstName"] as! String
                        let lastname = document.data()["lastName"] as! String
                        let description = document.data()["description"] as! String
                        let birthDate = document.data()["birthDate"] as! String
                        let interested = document.data()["interested"] as? [String] ?? [String]()
                        let activities = document.data()["activities"] as? [String] ?? [String]()
                        let categories = document.data()["categories"] as? [String] ?? [String]()
                        
                        volunteers.append(Volunteer(id: id, username: username, firstName: firstname, lastName: lastname, description: description, birthDate: birthDate, interested: interested, activities: activities, categories: categories))
                    }
                    DispatchQueue.main.async {
                        completion(volunteers)
                    }
                }
        }
        
    }
    
    /*
    func getUserInterestedList(userId: String, completion: @escaping ([String]) -> ([String])){
        let db = Firestore.firestore()
        let userId = Auth.auth().currentUser?.uid ?? ""
        
        let docRef = db.collection("users").document(userId)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let source = document.metadata.isFromCache ? "local cache" : "server"
                print("Metadata: Data fetched from \(source)")
                let interested = document.data()?["interested"] as! [String]
                print("INTERESTED LIST: ")
                print(interested)
                DispatchQueue.main.async {
                    completion(interested)
                }
            } else {
                print("Document does not exist")
            }
        }
    }*/
    
}

