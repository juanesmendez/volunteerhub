//
//  ActivityViewModel.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 30/03/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class ActivityViewModel: ObservableObject {
    
    var activity: Activity {
        willSet{
            print("Activity changed")
            print(activity, "will set modifier")
            print("Finished will set")
            objectWillChange.send()
        }
    }
    
    @Published var interested = [String]()
    
    init(activity: Activity) {
        self.activity = activity
    }
    
    func getActivity(activityId:String) {
        ActivitiesWebService().getActivity(activityId: activityId) { activity in
            if let activity = activity {
                //let aux = actvs.map(ActivityViewModel.init)
                //self.activities = aux
                
                print("Activity: \(activity)")
                self.activity = activity
        
            }
        }
    }
    
    func addVolunteer(volunteerId: String){
        // Calls ActivitiesWebService and modifies the activity to add a volunteer to the attending list
        // Make a PUT request to /activities/:idActivity sending the array of volunteers modified
        
//        var volunteers = self.activity.volunteers
        
        // To convert from VolunteerInfo object to simple Strings
        //var volunteers = [String]()
        
        // Add the new volunteer to the array
        self.activity.volunteers.append(volunteerId)
        
        
        ActivitiesWebService().updateVolunteerListOfActivity(activityId: self.activity.id, volunteers: self.activity.volunteers) { res in
            if let res = res {
                //let aux = actvs.map(ActivityViewModel.init)
                //self.activities = aux
                
                print("Response: \(res)")
                
                // Esto esta mal!! El JSON no m devuelve una Activity sino una respuesta al PUT!!!!!
                //self.activity = act
                //print(self.activity)
                //self.objectWillChange.send()
            }
        }
    }
    
    func removeVolunteerFromActivity(volunteerId: String) {
        // Calls ActivitiesWebService and modifies the activity to remove a volunteer from the attending list
        // Make a PUT request to /activities/:idActivity sending the array of volunteers modified
        
//        var volunteers = self.activity.volunteers
        
        // To convert from VolunteerInfo object to simple Strings
        //var volunteers = [String]()
        
        // Add the new volunteer to the array
        self.activity.volunteers.removeAll { $0 == volunteerId }
        
        
        ActivitiesWebService().updateVolunteerListOfActivity(activityId: self.activity.id, volunteers: self.activity.volunteers) { res in
            if let res = res {
                //let aux = actvs.map(ActivityViewModel.init)
                //self.activities = aux
                
                print("Response: \(res)")
                
                // Esto esta mal!! El JSON no m devuelve una Activity sino una respuesta al PUT!!!!!
                //self.activity = act
                //print(self.activity)
                //self.objectWillChange.send()
            }
        }
    }
    
    func deleteInterestActivityOfUser(userId: String, activity: Activity) {
        // removes the activity from the interest list of the user
        self.interested.removeAll { $0 == activity.id }
        UsersDB().deleteInterestActivityOfUser(userId: userId, interestedList: self.interested)
    }
    
    func addActivityToUser(userId: String, activity: Activity) {
        UsersDB().addActivityToUser(userId: userId, activity: activity)
    }
    
    func removeActivityFromUser(userId: String, activity: Activity) {
        UsersDB().removeActivityFromUser(userId: userId, activity: activity)
    }
    
    func addInterestActivityToUser(userId: String, activity: Activity) {
        UsersDB().addInterestActivityToUser(userId: userId, activity: activity)
    }
    
    func getUserInterestedList(userId: String) {
        UsersDB().getUserData() { userData in
            if let userData = userData {
                if let interestedList = userData["interested"] {
                    let interested = interestedList as! [String]
                    self.interested = interested
                } else {
                    self.interested = []
                }
                
            }
        }
    }
    
}
