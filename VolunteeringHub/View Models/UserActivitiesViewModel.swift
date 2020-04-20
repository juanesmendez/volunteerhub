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
    @Published var interestedActivities = [Activity]()
    @Published var reachable = false
    @Published var hasActivities = false
    @Published var hasInterestedActivities = false
    
    func loadUserActivities() {
        // Check connectivity
        self.reachable = ActivitiesWebService().isReachable()
        
        if self.reachable {
            print("Starting to load user's activities...")
            
            UsersDB().getUserData() { data in
                if let userData = data {
                    if userData["activities"] != nil {
                        let activitiesToFind = userData["activities"] as! [String]
                        // Instantiate a new empty userActivities array
                        var userActivities = [Activity]()
                        // If the user has activities
                        if activitiesToFind.count > 0{
                            self.hasActivities = true
                            
                            ActivitiesWebService().getActivities { actvs in
                                if let actvs = actvs {
                                    for activityId in activitiesToFind {
                                        for activity in actvs {
                                            if activity.id == activityId {
                                                userActivities.append(activity)
                                                continue
                                            }
                                        }
                                    }
                                    self.userActivities = userActivities
                                    // Cache array of activities in Users Default
                                    self.saveUserActivities()
                                }
                            }
                            
                        } else {
                            self.hasActivities = false
                            self.userActivities = userActivities
                            // Cache array of activities in Users Default
                            self.saveUserActivities()
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
    
    func loadUserInterestedActivities() {
        self.reachable = ActivitiesWebService().isReachable()
        
        if self.reachable {
            print("Starting to load user's interested activities...")
            
            UsersDB().getUserData() { data in
                if let userData = data {
                    if userData["interested"] != nil {
                        let activitiesToFind = userData["interested"] as! [String]
                        // Instantiate a new empty userActivities array
                        var userInterestedActivities = [Activity]()
                        // If the user has activities
                        if activitiesToFind.count > 0{
                            self.hasInterestedActivities = true
                            
                            ActivitiesWebService().getActivities { actvs in
                                if let actvs = actvs {
                                    for activityId in activitiesToFind {
                                        for activity in actvs {
                                            if activity.id == activityId {
                                                userInterestedActivities.append(activity)
                                                continue
                                            }
                                        }
                                    }
                                    self.interestedActivities = userInterestedActivities
                                    // Cache array of activities in Users Default
                                    self.saveUserInterestedActivities()
                                }
                            }
                            
                        } else {
                            self.hasInterestedActivities = false
                            self.interestedActivities = userInterestedActivities
                            // Cache array of activities in Users Default
                            self.saveUserInterestedActivities()
                        }
                        
                    }
                    
                    
                }
            }
        }else {
            // If not reachable, query cache
            self.getUserInterestedActivitiesFromCache()
        }
    }
    
    func saveUserInterestedActivities() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(self.interestedActivities) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "interestedActivities")
        } else {
            print("Failed to save user interested activities list in cache.")
        }
    }
    
    func getUserInterestedActivitiesFromCache() {
        print("Getting user interested activities from cache...")
        let defaults = UserDefaults.standard

        if let savedInterestedActivities = defaults.object(forKey: "interestedActivities") as? Data {
            let jsonDecoder = JSONDecoder()

            do {
                self.interestedActivities = try jsonDecoder.decode([Activity].self, from: savedInterestedActivities)
            } catch {
                print("Failed to load user interested activities list from cache.")
            }
        }
    }
    
    func isActivitiesServiceReachable() -> Bool {
        // Check connectivity
        self.reachable = ActivitiesWebService().isReachable()
        return self.reachable
    }
    
}
