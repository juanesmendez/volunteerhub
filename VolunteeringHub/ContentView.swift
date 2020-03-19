//
//  ContentView.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 27/02/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        //UITabBar.appearance().backgroundColor = UIColor(red: 188/255, green: 217/255, blue: 121/255, alpha: 1)
    }
    
    var body: some View {
        
        TabView {
            ActivitiesList()
                .tabItem() {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                //.navigationBarTitle("Activities")
            
            ProfileView()
                .tabItem() {
                    Image(systemName: "person.crop.circle.fill")
                    Text("Profile")
                }
                //.navigationBarTitle("Your profile")
        }
        //.navigationBarTitle("Home")
        //.navigationBarBackButtonHidden(true)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
