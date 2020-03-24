//
//  ProfileInfo.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 27/02/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import SwiftUI

struct ProfileInfo: View {
    
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        HStack {
            VStack {
                ActivityCircleImage(image: Image("profile"))
                Button(action: {
                    
                }) {
                    Text("Edit profile picture")
                }
            }
            
            Spacer()
            
            VStack {
                Text("Your score")
                    .font(.title)
                    
                Text("5.0")
                    .bold()
                    .padding()
                    .font(.title)
                .clipShape(Circle())
                    .overlay(Circle().stroke(Color.green, lineWidth: 4)
                )
            }
        }
        .padding(.horizontal, 55)
    }
}

struct ProfileInfo_Previews: PreviewProvider {
    static var previews: some View {
        ProfileInfo()
    }
}
