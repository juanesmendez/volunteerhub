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
    
    init(volunteers: [String]) {
        self.volunteers = volunteers
    }
    
    func getVolunteers() {
        UsersDB().getVolunteersInActivity(volunteersIds: self.volunteers) { volunteers in
            self.volunteersObjects = volunteers
        }
    }
    
}
