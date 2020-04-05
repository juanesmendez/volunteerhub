//
//  ProfileViewModel.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 3/04/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class ProfileViewModel: ObservableObject {
    
    @Published var userData: Dictionary<String, Any>?
    
    init() {
        getProfileData()
    }
    
    
    func getProfileData() {
        UsersDB().getUserData() { data in
            self.userData = data ?? nil
        }
    }
    
}
