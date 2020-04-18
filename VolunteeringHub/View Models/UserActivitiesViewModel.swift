//
//  UserActivitiesViewModel.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 18/04/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import Foundation
import SwiftUI
// For a reactive way of doing things
import Combine

class UserActivitiesViewModel: ObservableObject {
    
    //@Published var activities = [ActivityViewModel]()
    @Published var userActivities = [Activity]()
    @Published var reachable = false
    
    init() {
        //loadUserActivities()
    }
    
    func loadUserActivities() {
        // Check connectivity
        self.reachable = ActivitiesWebService().isReachable()
        
        if self.reachable {
            print("Starting to load user's activities...")
            ActivitiesWebService().getActivities { actvs in
                //print($0)
                if let actvs = actvs {
                    // Filter the array by the activities the user is attending
                    UsersDB().getUserData() { data in
                        if let userData = data {
                            
                            if userData["activities"] != nil {
                                let activitiesToFind = userData["activities"] as! [String]
                                
                                // Instantiate a new empty userActivities array
                                self.userActivities = [Activity]()
                                
                                for activityId in activitiesToFind {
                                    for activity in actvs {
                                        if activity.id == activityId {
                                            self.userActivities.append(activity)
                                            
                                            continue
                                        }
                                    }
                                    
                                    
                                }
                                
                            }
                            
                           
                        }
                        
                        
                    }
                    
                }
            }
        }
        // If not reachable, query cache
        
    }
}
