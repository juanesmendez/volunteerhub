//
//  ActivityCircleImage.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 27/02/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import SwiftUI

struct ActivityCircleImage: View {
    
    var image: Image
    
    var body: some View {
        image
            .resizable()
            .frame(width: 50.0, height: 50.0)
            .padding(.all, 10)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 2)
    }
}

struct ActivityCircleImage_Previews: PreviewProvider {
    static var previews: some View {
        ActivityCircleImage(image: Image("puppie"))
    }
}
