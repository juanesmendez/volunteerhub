//
//  Review.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 2/06/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import Foundation

import SwiftUI

struct Review: Codable, Hashable {
    // I may have to add Hashable protocol
    
    var hash: Int {
        return comment.hashValue
    }
    var foundation: String
    var score: Double
    var comment: String
    
    init(foundation:String, score:Double, comment:String) {
        self.foundation = foundation
        self.score = score
        self.comment = comment
    }
}
