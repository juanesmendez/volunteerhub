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
        ScrollView {
            VStack {
                HStack {
                    Text("Dog care for a day")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                }
                .padding(.leading)
                
                Image("puppie2")
                .resizable()
                
                VStack {
                    HStack {
                        Text("Description")
                            .font(.title)
                            .bold()
                        Spacer()
                    }
                    .padding(.leading)
                    Text("We are looking for dog loving volunteers, who have spare time on a Sunday morning. We have around 20 puppies looking for a new home that need to be supervised.")
                    .padding(.leading)
                }
                
                VStack {
                    HStack {
                        Text("Location")
                            .font(.title)
                            .bold()
                        Spacer()
                    }
                    .padding(.leading)
                    
                    MapView(coordinate: CLLocationCoordinate2D(latitude: 4.6527513, longitude: -74.0597535))
                        .frame(height: 150)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                        .shadow(radius: 15)
                    )
                        .padding(.horizontal, 10)
                }
                
                
                VStack {
                    HStack {
                        Text("Details")
                            .font(.title)
                            .bold()
                        Spacer()
                    }
                    .padding(.leading)
                    
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
                            .multilineTextAlignment(.center)
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
                            .multilineTextAlignment(.center)
                        }
                        Spacer()
                    }
                    .frame(height: 110)
                }
                
                
            }
            .navigationBarTitle(Text("Activity Information"), displayMode: .inline)
        }
        .padding(.top, 52)
    }
}

struct ActivityDetail_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDetail()
    }
}
