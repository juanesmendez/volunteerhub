//
//  NewActivity.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 28/02/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import SwiftUI
import MapKit

struct SubmitActivity: View {
    
    @State var location: String
    @State var date = Date()
    @State var description: String
    @State var numberOfVolunteers: String
    @State var selection: String
    
    var body: some View {
        VStack {
            HStack {
                
                Text("New activity")
                    .font(.title)
                    .bold()
                    .padding(.leading, 15)
                
                Spacer()
                Button(action: {
                    
                }) {
                    Text("Next")
                }
                .padding(.trailing, 15)
                
            }
            Form {
                TextField("Search for a location", text: $location)
        
                MapView(coordinate: CLLocationCoordinate2D(latitude: 4.6527513, longitude: -74.0597535))
                    .frame(height: 150)
                
                Section {
                    DatePicker(
                        selection: $date,
                        //in: dateClosedRange,
                        displayedComponents: .date,
                        label: { Text("Select a date") }
                    )
                    DatePicker(
                        selection: $date,
                        displayedComponents: .hourAndMinute,
                        label: { Text("Select a time") }
                    )
                }
                
                Section {
                    TextField("Number of volunteers", text: $numberOfVolunteers)
                    Picker(selection: $selection, label:
                        Text("Activity type")
                        , content: {
                            Text("Environment").tag(0)
                            Text("Adoption spree").tag(1)
                            Text("Building houses").tag(2)
                            Text("Helping the poor").tag(3)
                    })
                }
                
                Section {
                    TextField("Description of your activity", text: $description)
                        .padding(.bottom, 120)
                    .frame(height: 150)
                        
                }
            }
            
            
        }
        
    }
}

struct SubmitActivity_Previews: PreviewProvider {
    static var previews: some View {
        SubmitActivity(location: "", description: "", numberOfVolunteers: "", selection: "")
    }
}
