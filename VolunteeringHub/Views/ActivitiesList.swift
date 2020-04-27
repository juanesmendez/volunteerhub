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
import GoogleMaps
import GooglePlaces

struct ActivitiesList: View {
    
    @State private var searchText : String = ""
    @State private var showingAlert = false
    @ObservedObject var model = ActivitiesListViewModel()
    var reachable = false
    
    @State var manager = CLLocationManager()
    @State var alert = false
    @State var coordinate = CLLocationCoordinate2D()
    
    @State var address = String()
    
    init() {
        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack {
                    
                    SearchBar(text: $searchText)
                    /*
                    MapView(coordinate: CLLocationCoordinate2D(latitude: 4.6527513, longitude: -74.0597535))
                        .frame(height: 150)
                    */
                    if self.model.reachable {
                        GoogleMapView(manager: $manager, alert: $alert, coordinate: $coordinate, address: $address, activities: self.model.activities)
                        .frame(height: 200)
                            .alert(isPresented: $alert){
                                Alert(title: Text("Please enable location access in settings."))
                        }
                        HStack() {
                            Image(systemName: "location.fill")
                                .foregroundColor(Color.purple)
                            Text("\(self.address)")
                                .font(.subheadline)
                            Spacer()
                        }
                        .padding(.leading, 18)
                        
                        if self.model.activities.count > 0 {
                            ForEach(self.model.activities, id: \.id) { activity in
                                ActivityCard(activity: activity)
                                    .padding(.top, 5)
                                    .padding(.horizontal, 20)
                            }
                        } else {
                            Text("We couldn't find any activity that matches your interests ☹️. \n\nTry experiencing something new. Go edit your interests in the profile tab! 😉")
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 20)
                                .padding(.top, 60)
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
                .onAppear(perform: self.loadModelData) // refreshes the activities everytime the view looses focus and appears again
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
    
    func loadModelData() {
        self.model.loadModel()
    }
}

struct ActivitiesList_Previews: PreviewProvider {
    static var previews: some View {
        ActivitiesList()
    }
}
