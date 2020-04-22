//
//  Activity.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 18/03/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import Foundation
import SwiftUI



struct Activity: Codable, Identifiable {
    // I may have to add Hashable protocol
    
    var id: String
    var name: String
    var description: String
    var category: String
    var volunteersNeeded: Int
    var volunteersAttending: Int?
    // Check the date type. Date type throws an error, that is why we are using String
    var date: String
    
    var images: [ImageInfo]
    
    var volunteers: [String]
    
    var location: Location
    
    struct Location: Codable {
        var latitude: Double
        var longitude: Double
    }
    
    struct ImageInfo: Codable {
        var fileName: String
    }
    
    // For readind _id key and changing it to id
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, description, category, volunteersNeeded, volunteersAttending, date, images, volunteers, location
    }
}
