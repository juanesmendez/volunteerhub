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
                ScrollView {
                        
                        VStack {
                            HStack {
                                Spacer()
                                VStack(alignment: .trailing) {
                                    Text("Hello ")
                                        .font(.headline)
                                    Text("\(self.profileModel.userData?["firstName"] as! String) \(self.profileModel.userData?["lastName"] as! String)")
                                        .font(.title)
                                    
                                }
                                .padding(.horizontal, 10)
                            }
                            
                            ProfileInfo()
                                .padding(.bottom, 10)
                            
                            VStack(alignment: .leading) {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text("Basic information")
                                            .font(.title)
                                            .bold()
                                        Spacer()
                                    }
                                    .padding(.bottom, 5)
                                    Text("Username: \(self.profileModel.userData?["username"] as! String)")
                                    Divider()
                                    Text("Birth date: \(self.profileModel.userData?["birthDate"] as! String)")
                                }
                                .padding(.horizontal, 10)
                                .padding(.bottom, 10)
                                
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text("Your experience")
                                            .font(.title)
                                            .bold()
                                        Spacer()
                                    }
                                    .padding(.bottom, 5)
                                    Text(self.profileModel.userData?["description"] as! String)
                                        .lineLimit(4)
                                    
                                }
                                .padding(.horizontal, 10)
                                .padding(.bottom, 10)
                                
                                MedalsList()
                                    
                                Text("Interests")
                                    .font(.title)
                                    .bold()
                                    .padding(.horizontal, 10)
                                        
                                    
                                HStack {
                                    Spacer()
                                    InterestsList()
                                    Spacer()
                                }
                            }
                            
                            VStack{
                                Button(action: {
                                    do {
                                        try Auth.auth().signOut()
                                        //For the app delegate to know (It redirects to the login page):
                                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                        appDelegate.userId = ""
                                    } catch let signOutError as NSError {
                                        print ("Error signing out: %@", signOutError)
                                    }
                                }){
                                    Text("Sign out")
                                        .padding(.all, 8.0)
                                        .background(Color.red)
                                        .foregroundColor(Color.white)
                                        .cornerRadius(20)
                                }
                            }
                            .padding(.top, 20)
                            
                            
                        }
                }
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
     
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
