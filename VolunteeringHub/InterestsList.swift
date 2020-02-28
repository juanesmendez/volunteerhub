//
//  InterestsList.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 27/02/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import SwiftUI

struct InterestsList: View {
    
    var interestsImages = [Image]()
    
    init() {
        interestsImages.append(Image("bike"))
        interestsImages.append(Image("mountain"))
        interestsImages.append(Image("rescue_dog"))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                ForEach(0..<interestsImages.count) { i in
                    InterestCircleImage(image: self.interestsImages[i])
                        .padding(.horizontal)
                }
            }
        }
        
    }
}

struct InterestsList_Previews: PreviewProvider {
    static var previews: some View {
        InterestsList()
    }
}
