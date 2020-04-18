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
    @State private var showingAlert = false
    @ObservedObject var model = ActivitiesListViewModel()
    var reachable = false
    
    init() {
        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
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
                    
                    if self.model.reachable {
                        ForEach(self.model.activities, id: \.id) { activity in
                            ActivityCard(activity: activity)
                                .padding(.top, 5)
                                .padding(.horizontal, 20)
                        }
                    } else {
                        VStack {
                            Text("It seems like you are not connected to the internet 😢. Please try again.")
                                .multilineTextAlignment(.center)
                                .padding(.top, 40)
                                .padding(.bottom, 20)
                                
                            Button(action: {
                                if self.model.isActivitiesServiceReachable() {
                                    self.model.loadActivities()
                                } else {
                                    self.showingAlert = true
                                    
                                }
                                
                            }) {
                                Text("Refresh")
                                    .padding(.horizontal, 10.0)
                                    .padding(.vertical, 9.0)
                                    .cornerRadius(10)
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 2))
                            }
                             .buttonStyle(PlainButtonStyle())
                        }
                        
                    }
                }
                .navigationBarTitle("Activities")
                .accentColor(Color.green)
                .onAppear(perform: model.loadActivities) // refreshes the activities everytime the view looses focus and appears again
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Connection error"), message: Text("You don't have an active internet connection"), dismissButton: .default(Text("Ok")))
                }
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
