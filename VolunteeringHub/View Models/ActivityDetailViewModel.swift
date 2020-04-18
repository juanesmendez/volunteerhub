//
//  ActivityDetailViewModel.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 17/04/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class ActivityDetailViewModel: ObservableObject {
    
    @Published var imageData = Data()
    let imageBaseURL = "http://3.228.168.162:3000/photos/image/"
    
    init() {
    }
    
    func loadImage(urlString: String) {
        ImageLoader().loadImage(urlString: imageBaseURL + urlString) { data in
            if let data = data {
                self.imageData = data
            }
        }
    }
    
}
