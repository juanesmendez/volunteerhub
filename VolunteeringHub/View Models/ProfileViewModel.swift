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
    @Published var categories = [String]()
    @Published var reviews = [Review]()
    
    init() {
        getProfileData()
    }
    
    
    func getProfileData() {
        UsersDB().getUserData() { data in
            self.userData = data ?? nil
            self.categories = data?["categories"] as? [String] ?? []
            let reviews = data?["reviews"] as? [Dictionary<String, Any>] ?? []
            
            var revObjects = [Review]()
            
            var foundation:String
            var score: Double
            var comment:String
            var revObject: Review
            for review in reviews {
                foundation = review["foundation"] as? String ?? ""
                score = Double(review["score"] as? String ?? "")!
                comment = review["comment"] as? String ?? ""
                revObject = Review(foundation: foundation, score: score, comment: comment)
                revObjects.append(revObject)
            }
            self.reviews = revObjects
        }
    }
    
}
