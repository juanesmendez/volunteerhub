//
//  ActivitiesListViewModel.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 18/03/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import Foundation
import SwiftUI
// For a reactive way of doing things
import Combine

class ActivitiesListViewModel: ObservableObject {
    
    //@Published var activities = [ActivityViewModel]()
    // Activities list that has the activities filtered by the categories the user likes
    @Published var activities = [Activity]()
    @Published var userCategories = [String]()
    @Published var reachable = false
    
    init() {
//        loadUserCategories()
//        loadActivities()
        loadModel()
    }
    
    func loadModel() {
        self.reachable = NetworkState.isConnected()
        if self.reachable {
            UsersDB().getUserCategories() { categories in
                self.userCategories = categories
                self.reachable = ActivitiesWebService().isReachable()
                print("Starting to load activities...")
                ActivitiesWebService().getActivities { actvs in
                    //print($0)
                    if let actvs = actvs {
                        //let aux = actvs.map(ActivityViewModel.init)
                        //self.activities = aux
                        self.filterActivities(activities: actvs)
    //                    self.activities = actvs
    //                    print(self.activities)
                        //self.objectWillChange.send()
                    }
                }
                print(self.activities)
                print("Finished loading activities...")
                        
            }
        }
        
    }
    
    func loadActivities() {
        // Check connectivity
        self.reachable = ActivitiesWebService().isReachable()
        
        if self.reachable {
            print("Starting to load activities...")
            ActivitiesWebService().getActivities { actvs in
                //print($0)
                if let actvs = actvs {
                    //let aux = actvs.map(ActivityViewModel.init)
                    //self.activities = aux
                    self.filterActivities(activities: actvs)
//                    self.activities = actvs
//                    print(self.activities)
                    //self.objectWillChange.send()
                }
            }
            print(self.activities)
            print("Finished loading activities...")
        }
        
    }
    
    func loadUserCategories(){
        UsersDB().getUserCategories() { categories in
            self.userCategories = categories
        }
    }
    
    func filterActivities(activities: [Activity]) {
        if self.userCategories.count > 0 {
            var filteredActivities = [Activity]()
            for activity in activities {
                if self.userCategories.contains(activity.category) {
                    filteredActivities.append(activity)
                }
            }
            self.activities = filteredActivities
            
        } else {
            self.activities = activities
        }
    }
    
    func isActivitiesServiceReachable() -> Bool {
        // Check connectivity
        self.reachable = ActivitiesWebService().isReachable()
        return self.reachable
    }
}
/*
struct ActivityViewModel {
    var activity: Activity
    
    init(activity: Activity) {
        self.activity = activity
    }
    
    var id: String {
        return self.activity.id
    }
    
    var name: String {
        return self.activity.name
    }
    
    var description: String {
        return self.activity.description
    }
    
    var volunteersNeeded: Int {
        return self.activity.volunteersNeeded
    }
    
    var date: String {
        return self.activity.date
    }
    /*
    var images: [ImageInfo]? {
        return self.activity.images
    }*/
}*/
