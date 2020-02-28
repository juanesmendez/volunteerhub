//
//  ActivityDetail.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 27/02/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import SwiftUI
import MapKit

struct ActivityDetail: View {
    var body: some View {
        VStack {
            HStack {
                Text("Dog care for a day")
                    .font(.largeTitle)
                    .bold()
                Spacer()
            }
            
            HStack {
                Text("Description")
                    .font(.title)
                    .bold()
                Spacer()
            }
            Text("We are looking for dog loving volunteers, who have spare time on a Sunday morning. We have around 20 puppies looking for a new home that need to be supervised.")
            HStack {
                Text("Location")
                    .font(.title)
                    .bold()
                Spacer()
            }
            MapView(coordinate: CLLocationCoordinate2D(latitude: 4.6527513, longitude: -74.0597535))
                .frame(height: 150)
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 1)
                .shadow(radius: 15)
            )
                .padding(.horizontal, 10)
            
            HStack {
                Text("Details")
                    .font(.title)
                    .bold()
                Spacer()
            }
            
            HStack {
                Spacer()
                VStack {
                    Text("28")
                        .bold()
                        .foregroundColor(Color.green)
                        .padding()
                        .font(.title)
                        .overlay(Circle().stroke(Color.gray, lineWidth: 1)
                            )
                            .shadow(radius: 5)
                    Text("Volunteers\nneeded")
                }
                Spacer()
                VStack {
                    Text("19")
                        .bold()
                        .foregroundColor(Color.red)
                        .padding()
                        .font(.title)
                        .overlay(Circle()
                            .stroke(Color.gray, lineWidth: 1)
                        )
                        .shadow(radius: 5)
                    Text("Volunteers\nneeded")
                }
                Spacer()
            }
            .frame(height: 110)
        }
        .navigationBarTitle(Text("Activity Information"), displayMode: .inline)
    }
}

struct ActivityDetail_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDetail()
    }
}
