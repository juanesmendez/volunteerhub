//
//  ProfileView.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 27/02/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseUI
import GoogleSignIn

struct ProfileView: View {
    
    @ObservedObject var profileModel = ProfileViewModel()
    
    var body: some View {
        NavigationView{
            if self.profileModel.userData != nil {
                List {
                    Section (header:
                        HStack {
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text("Hello ")
                                    .font(.headline)
                                Text("\(self.profileModel.userData?["firstName"] as! String) \(self.profileModel.userData?["lastName"] as! String)")
                                    .font(.title)
                                
                            }
                            .padding(.horizontal, 10)
                        }){
                          ProfileInfo()
                           .padding(.bottom, 10)
                    }
                    Section(header: Text("Basic information").font(.headline)){
                        
                        Text("Username: \(self.profileModel.userData?["username"] as! String)")
                        Text("Birth date: \(self.profileModel.userData?["birthDate"] as! String)")
                    }
                    
                    Section(header: Text("Your experience").font(.headline)){
                        
                        Text(self.profileModel.userData?["description"] as! String)
                        .lineLimit(4)
                    }
                    
                    Section(header: Text("Medals").font(.headline)){
                        MedalsList()
                    }
                    
                    Section(header: Text("Interests").font(.headline)
                    , footer:
                        HStack{
                           Spacer()
                            Button(action: {
                                self.signOut()
                            }){
                                Text("Sign out")
                                    .padding(.all, 8.0)
                                    .background(Color.red)
                                    .foregroundColor(Color.white)
                                    .cornerRadius(20)
                            }
                           Spacer()
                        }
                    ){
                        HStack {
                            Spacer()
                            InterestsList()
                            Spacer()
                        }
                        .padding(.top, 20)
                        .padding(.bottom, 20)
                    }
                }
                .listStyle(GroupedListStyle())
                .navigationBarTitle("Your profile")
            } else {
                Text("Loading profile data...")
                    .navigationBarTitle("Your profile")
                
            }
            
        
        }
        .onAppear(perform: {
            self.getProfileData()
        })
            
    }
    
    func getProfileData() {
        self.profileModel.getProfileData()
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            //For the app delegate to know (It redirects to the login page):
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.userId = ""
            // When user signs out, all of its data is erased from the cache
            UserDefaults.standard.removeObject(forKey: "userActivities")
            UserDefaults.standard.synchronize()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
    }
     
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
