//
//  User.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 20/04/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import Foundation
import SwiftUI

struct Volunteer: Codable, Identifiable {
    // I may have to add Hashable protocol
    
    var id: String
    var username: String
    var firstName: String
    var lastName: String
    var description: String
    var birthDate: String
    var interested: [String]
    var activities: [String]
}

