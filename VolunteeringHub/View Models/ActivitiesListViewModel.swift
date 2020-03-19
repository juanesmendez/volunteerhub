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
    var activities = [ActivityViewModel](){
        willSet{
            print("Activities list changed!!!!!")
            print(activities, "will set modifier")
            print("Finished will set")
            objectWillChange.send()
        }
    }
    
    init() {
        loadActivities()
    }
    
    func loadActivities() {
        print("Starting to load activities...")
        ActivitiesWebService().getActivities { actvs in
            //print($0)
            if let actvs = actvs {
                let aux = actvs.map(ActivityViewModel.init)
                self.activities = aux
                print(self.activities)
                //self.objectWillChange.send()
            }
        }
        print(self.activities)
        print("Finished loading activities...")
    }
}

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
}
