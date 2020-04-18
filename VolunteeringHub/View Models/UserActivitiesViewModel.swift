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
    
    func loadUserActivities() {
        // Check connectivity
        self.reachable = ActivitiesWebService().isReachable()
        
        if self.reachable {
            print("Starting to load user's activities...")
            ActivitiesWebService().getActivities { actvs in
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
                                // Cache array of activities in Users Default
                                self.saveUserActivities()
                            }
                        }
                    }
                }
            }
        }else {
            // If not reachable, query cache
            self.getUserActivitiesFromCache()
        }
    }
    
    func saveUserActivities() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(self.userActivities) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "userActivities")
        } else {
            print("Failed to save user attending activities list in cache.")
        }
    }
    
    func getUserActivitiesFromCache() {
        print("Getting user activities from cache...")
        let defaults = UserDefaults.standard

        if let savedUserActivities = defaults.object(forKey: "userActivities") as? Data {
            let jsonDecoder = JSONDecoder()

            do {
                self.userActivities = try jsonDecoder.decode([Activity].self, from: savedUserActivities)
            } catch {
                print("Failed to load user attending activities list from cache.")
            }
        }
    }
    
    func isActivitiesServiceReachable() -> Bool {
        // Check connectivity
        self.reachable = ActivitiesWebService().isReachable()
        return self.reachable
    }
    
}
