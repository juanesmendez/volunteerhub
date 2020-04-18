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
    @Published var activities = [Activity]()
    @Published var reachable = false
    
    init() {
        loadActivities()
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
                    self.activities = actvs
                    print(self.activities)
                    //self.objectWillChange.send()
                }
            }
            print(self.activities)
            print("Finished loading activities...")
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
