//
//  SignInRectangle.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 28/02/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import SwiftUI

struct SignInRectangle: View {
    
    var image: Image
    
    var text: String
    
    var body: some View {
        
        HStack {
            self.image
            .resizable()
            .frame(width: 30.0, height: 30.0)

            Text(self.text)
            
            Spacer()
        }
        .padding()
        .frame(width: 260, height: 40)
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10)
        .stroke(Color.gray, lineWidth: 2)
        )
    }
}

struct SignInRectangle_Previews: PreviewProvider {
    static var previews: some View {
        SignInRectangle(image: Image("google-icon"), text: "Sign in with Google")
    }
}
