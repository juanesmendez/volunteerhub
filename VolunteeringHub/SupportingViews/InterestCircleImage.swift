//
//  InterestCircleImage.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 27/02/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import SwiftUI

struct InterestCircleImage: View {
    
    var image: Image
    
    var body: some View {
        image
            .resizable()
            .padding(.all, 10)
            .frame(width: 80.0, height: 80.0)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.gray, lineWidth: 2))
            .shadow(radius: 1)
    }
}

struct InterestCircleImage_Previews: PreviewProvider {
    static var previews: some View {
        InterestCircleImage(image: Image("bike"))
    }
}
