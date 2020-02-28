//
//  ContentView.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 27/02/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        TabView {
            ActivitiesList()
                .tabItem() {
                    Image(systemName: "house.fill")
                    Text("Home")
            }
            
            ProfileView()
                .tabItem() {
                    Image(systemName: "person.crop.circle.fill")
                    Text("Profile")
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
