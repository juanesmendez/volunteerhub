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
    
    private var date: Date {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            print("La fechaaaa \(self.profileModel.userData?["birthDate"] as! String)")
            let dateString = profileModel.userData?["birthDate"] as! String
            let aux = dateString.components(separatedBy: "T")
            let date = dateFormatter.date(from: aux[0]) ?? Date()
            return date
        }
        
    }
    
    //@State var attending = false
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    
    var body: some View {
        NavigationView{
            if self.profileModel.userData != nil {
                List {
                    Section (header:
                        VStack {
                            VStack(alignment: .trailing) {
                                Text("Hello ")
                                    .font(.headline)
                                Text("\(self.profileModel.userData?["firstName"] as! String) \(self.profileModel.userData?["lastName"] as! String)")
                                    .font(.title)
                                ProfileInfo()
                                .padding(.bottom, 10)
                                
                            }
                            HStack {
                                Image(systemName: "person")
                                Text("Basic information").font(.headline)
                                Spacer()
                            }
                        }
                    ){
                        HStack {
                            Text("Username ").bold()
                            Text(self.profileModel.userData?["username"] as! String)
                        }
                        HStack {
                            Text("Email ").bold()
                            Text(Auth.auth().currentUser?.email ?? "johnappleseed@apple.com")
                        }
                        HStack {
                            Text("Birth date ").bold()
                            Text("\(self.date, formatter: Self.taskDateFormat)")
                        }
                    }
//                    Section(header: Text("Basic information").font(.headline)){
//
//
//                    }
                    
                    Section(header:
                        HStack {
                            Image(systemName: "briefcase")
                            Text("Your experience").font(.headline)
                        }
                    ){
                        Text(self.profileModel.userData?["description"] as! String)
                        .lineLimit(4)
                    }
                    
                    Section(header:
                        HStack {
                            Image(systemName: "rosette")
                            Text("Medals").font(.headline)
                        }
                    ){
                        MedalsList()
                    }
                    
                    Section(header:
                        HStack {
                            Image(systemName: "tag")
                            Text("Interests").font(.headline)
                        }
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
                .onAppear(perform: {
                        self.getProfileData()
                    })
                .navigationBarTitle("Your profile")
                .navigationBarItems(trailing:
                    NavigationLink(destination: EditProfile()){
                        Text("Edit")
                    }
                )
            } else {
                Text("Loading profile data...")
                    .navigationBarTitle("Your profile")
                
            }
            
        
        }
            
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
