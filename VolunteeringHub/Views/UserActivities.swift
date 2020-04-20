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
    
    init() {
        print("Initializing user activities tab")
        self.model.loadUserActivities()
    }
    
    var body: some View {
        NavigationView {
            
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
                        .navigationBarTitle("Your activities")
                
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
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Connection error"), message: Text("You don't have an active internet connection"), dismissButton: .default(Text("Ok")))
        }
        .onAppear(perform: model.loadUserActivities)
            
    }
}

struct UserActivities_Previews: PreviewProvider {
    static var previews: some View {
        UserActivities()
    }
}
