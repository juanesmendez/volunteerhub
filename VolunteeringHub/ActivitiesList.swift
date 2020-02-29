//
//  ActivitiesList.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 27/02/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import SwiftUI
import MapKit

struct ActivitiesList: View {
    
    @State private var searchText : String = ""
    
    init() {
        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        NavigationView{
            VStack {
                
                SearchBar(text: $searchText)
                
                MapView(coordinate: CLLocationCoordinate2D(latitude: 4.6527513, longitude: -74.0597535))
                    .frame(height: 150)
                HStack() {
                    Image(systemName: "location.fill")
                        .foregroundColor(Color.purple)
                    Text("Current location: Chapinero, Bogota")
                        .font(.headline)
                    Spacer()
                }
                .padding(.leading, 18)
                
                ScrollView{
                    ForEach(0..<2) { i in
                        ActivityCard()
                            .padding(.top, 5)
                            .padding(.horizontal, 10)
                    }
                }
                .padding(.top, 2)
                
                Spacer()
                
                
            }.navigationBarTitle("Activities")
        }
        
        
    }
}

struct ActivitiesList_Previews: PreviewProvider {
    static var previews: some View {
        ActivitiesList()
    }
}
