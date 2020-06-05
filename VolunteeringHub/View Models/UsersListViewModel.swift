//
//  UsersListViewModel.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 20/04/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class UsersListViewModel: ObservableObject {
    
    @Published var volunteers: [String]
    @Published var volunteersObjects = [Volunteer]()
    @Published var userCalculatedScores = Dictionary<String, Double>()
    
    init(volunteers: [String]) {
        self.volunteers = volunteers
    }
    
    func getVolunteers() {
        UsersDB().getVolunteersInActivity(volunteersIds: self.volunteers) { volunteers in
            self.volunteersObjects = volunteers
            // Calculate scores average for every volunteer
            self.calculateUsersRatings()
        }
    }
    
    func calculateUsersRatings() {
        print("Calculating user score averages")
        var scoresAverage = Dictionary<String, Double>()
        for volunteer in self.volunteersObjects {
            if volunteer.reviews.count > 0 {
                var prom: Double = 0
                for review in volunteer.reviews {
                    print("Review with score \(review.score) of: \(volunteer.username)")
                    prom = prom + review.score
                }
                // Store the score average as the value of the key (user's id)
                scoresAverage[volunteer.id] = prom / Double(volunteer.reviews.count)
                
            } else {
                print("\(volunteer.username) has no reviews")
                scoresAverage[volunteer.id] = Double(0)
            }
        }
        self.userCalculatedScores = scoresAverage
    }
    
}
