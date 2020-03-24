//
//  ActivitiesList.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 27/02/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import SwiftUI
import MapKit
import Firebase
import FirebaseUI
import GoogleSignIn

struct ActivitiesList: View {
    
    @State private var searchText : String = ""
    @ObservedObject var model = ActivitiesListViewModel()
    //@State private var activities = [ActivityViewModel]()
    //@State var model = ActivitiesListViewModel()
    
    init() {
        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
        /*
        var user = Auth.auth().currentUser
        if (user != nil) {
            print(user?.displayName);
            print(user?.email);
            print(user?.photoURL)
            print(user?.isEmailVerified)
            print(user?.uid)  // The user's ID, unique to the Firebase project. Do NOT use
                           // this value to authenticate with your backend server, if
                           // you have one. Use User.getToken() instead.
        }
        */
    }
    
    var body: some View {
        NavigationView{
            ScrollView{
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
                    
                    //ScrollView{
                    ForEach(self.model.activities, id: \.id) { activity in
                        ActivityCard(activity: activity)
                            .padding(.top, 5)
                            .padding(.horizontal, 20)
                    }
                    //}
                    //.padding(.top, 2)
                    Spacer()
                }
                .navigationBarTitle("Activities")
                .accentColor(Color.green)
                .onAppear(perform: model.loadActivities) // refreshes the activities everytime the view looses focus and appears again
                //.onAppear(perform: getActivities)
                //.onAppear(perform: model.loadActivities)
            }
        }
        
    }
    
    func getActivities(){
        print("In get activities function...")
        print(self.model.activities)
    }
 
}

struct ActivitiesList_Previews: PreviewProvider {
    static var previews: some View {
        ActivitiesList()
    }
}
