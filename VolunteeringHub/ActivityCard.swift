//
//  ActivityCardView.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 27/02/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import SwiftUI

struct ActivityCard: View {
    var body: some View {
        VStack {
            HStack {
                Text("Dog care for a day")
                    .font(.title)
                    .bold()
                
                Spacer()
            }.padding(.leading, 10.0)
            
            HStack {
                ActivityCircleImage(image: Image("puppie"))
                Text("We are looking for dog loving volunteers, who have spare time on a Sunday morning. We have around 20 puppies looking for a new home that need to be supervised.")
                .allowsTightening(true)
            }.padding(.all, 10.0)
            
            HStack {
                Image(systemName: "location")
                    .foregroundColor(Color.gray)
                Text("Usaquen")
                
                Spacer()
                
                Button(action: {
                    
                }) {
                    Text("Learn more")
                        .padding(.all, 8.0)
                        .background(Color.green)
                        .foregroundColor(Color.black)
                    .cornerRadius(20)
                    
                    
                }
            }.padding(.all, 10.0)
        }
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10)
        .stroke(Color.gray, lineWidth: 1)
        .shadow(radius: 15)
        )
        
    }
}

struct ActivityCard_Previews: PreviewProvider {
    static var previews: some View {
        ActivityCard()
    }
}
