//
//  UserActivities.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 18/04/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import SwiftUI

struct UserActivities: View {
    
    @ObservedObject var model = UserActivitiesViewModel()
    @State private var showingAlert = false
    
    @State private var selectorIndex = 0
    @State private var sections = ["Attending","Interested"]
    
    init() {
        print("Initializing user activities tab")
        self.model.loadUserActivities()
        self.model.loadUserInterestedActivities()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // 2
                Picker("Sections", selection: $selectorIndex) {
                    ForEach(0 ..< sections.count) { index in
                        Text(self.sections[index]).tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                // 3.
                //Text("Selected value is: \(numbers[selectorIndex])").padding()
                if selectorIndex == 0 {
                    if model.userActivities.count > 0 {
                        List {
                            Section(header: Text("Activities you are attending")) {
                                ForEach(model.userActivities) { activity in
                                    NavigationLink(destination: ActivityDetail(activity: activity)){
                                        HStack{
                                            Image(activity.category)
                                                .resizable()
                                                .frame(width: 25.0, height: 25.0)
                                            Text(activity.name)
                                            Spacer()
                                        }
                                    }
                                }
                            }
                        }
                        .listStyle(GroupedListStyle())
                        .navigationBarTitle("Your activities")
                    } else {
                        if !model.hasActivities {
                            Text("You haven't hit attend to any activity 🗺 yet. Please go to your home screen 🏠 and search for an activity you would like to join! 😉")
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 20)
                                .padding(.top, 60)
                                .navigationBarTitle("Your activities")
                            
                            Spacer()
                        } else {
                            // The case when the user does have attending activities but there occurred an error while retrieving from server when the user just logged in
                            Text("We are having trouble showing your activities 😢. You may not be connected to the internet. Please try again.")
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 20)
                                .navigationBarTitle("Your activities")
                            Button(action: {
                                if self.model.isActivitiesServiceReachable() {
                                    self.model.loadUserActivities()
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
                } else if selectorIndex == 1 {
                    if model.interestedActivities.count > 0 {
                        List {
                            Section(header: Text("Activities you are interested in")) {
                                ForEach(model.interestedActivities) { activity in
                                    NavigationLink(destination: ActivityDetail(activity: activity)){
                                        HStack{
                                            Image(activity.category)
                                                .resizable()
                                                .frame(width: 25.0, height: 25.0)
                                            Text(activity.name)
                                            Spacer()
                                        }
                                    }
                                }
                            }
                        }
                        .listStyle(GroupedListStyle())
                        .navigationBarTitle("Your activities")
                    } else {
                        if !model.hasInterestedActivities {
                            Text("You aren't interested in any activity 🗺 yet. Please go to your home screen 🏠 and search for an activity you find interesting! 😉")
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 20)
                                .padding(.top, 60)
                                .navigationBarTitle("Your activities")
                                
                            Spacer()
                        } else {
                            // The case when the user does have attending activities but there occurred an error while retrieving from server when the user just logged in
                            Text("We are having trouble showing the activities you are interested in 😢. You may not be connected to the internet. Please try again.")
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 20)
                                .navigationBarTitle("Your activities")
                            Button(action: {
                                if self.model.isActivitiesServiceReachable() {
                                    self.model.loadUserInterestedActivities()
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
            }
            .onAppear(perform: self.refreshLists)
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Connection error"), message: Text("You don't have an active internet connection"), dismissButton: .default(Text("Ok")))
        }
        //.onAppear(perform: self.refreshLists)
            
    }
    
    func refreshLists() {
        self.model.loadUserActivities()
        self.model.loadUserInterestedActivities()
    }
}

struct UserActivities_Previews: PreviewProvider {
    static var previews: some View {
        UserActivities()
    }
}
