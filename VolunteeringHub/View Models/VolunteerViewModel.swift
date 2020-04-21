//
//  VolunteerViewModel.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 21/04/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class VolunteerViewModel: ObservableObject {
    
    @Published var volunteer: Volunteer
    @Published var volunteerActivities = [Activity]()
    var reachable = false
    
    init(volunteer: Volunteer) {
        self.volunteer = volunteer
    }
    
    func loadVolunteerActivities() {
        // Check connectivity
        self.reachable = ActivitiesWebService().isReachable()
        
        if self.reachable {
            print("Starting to load user's activities...")
            // Do it only if the volunteer is attending an activity
            if self.volunteer.activities.count > 0 {
                // Instantiate a new empty userActivities array
                var userActivities = [Activity]()
                ActivitiesWebService().getActivities { actvs in
                    if let actvs = actvs {
                        for activityId in self.volunteer.activities {
                            for activity in actvs {
                                if activity.id == activityId {
                                    userActivities.append(activity)
                                    continue
                                }
                            }
                        }
                        self.volunteerActivities = userActivities
                    }
                }
            }
        }
    }
    
}
