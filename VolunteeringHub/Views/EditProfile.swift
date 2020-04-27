//
//  EditProfile.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 23/04/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import SwiftUI
import Firebase

struct EditProfile: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var profileModel = ProfileViewModel()
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var birthDate = Date()
    @State var birthDateString = ""
    @State var username: String = ""
    @State var description: String = ""
    
    // Categories
    @State var environment = false
    @State var disabilities = false
    @State var animals = false
    @State var poor = false
    @State var tutoring = false
    @State var elders = false
    
    // For handling user feedback
    @State var shown:Bool = false
    @State var message:String = ""
    
    var body: some View {
        VStack {
            
            Form {
                Section(header: Text("Your basic information")){
                    HStack {
                        Text("First name").bold()
                        TextField("First name", text: $firstName)
                    }
                    HStack {
                        Text("Last name").bold()
                        TextField("Last name", text: $lastName)
                    }
                    
                    DatePicker(
                        selection: $birthDate,
                        //in: dateClosedRange,
                        displayedComponents: .date,
                        label: { Text("Select your birthdate").bold() }
                    )
                }
                
                Section(header: Text("Other information")){
                    HStack {
                        Text("Username").bold()
                        Spacer()
                        TextField("Username", text: $username)
                    }
                    
                }
                
                Section(header: Text("Tell us more about yourself")){
                    TextField("Your description", text: $description)
                        .padding(.bottom, 120)
                        .frame(height: 150)
                        
                }
                
                Section(header: Text("Update the categories you are interested in")){
                    Toggle(isOn: $environment) {
                        Image("environment")
                            .resizable()
                            .frame(width: 25.0, height: 25.0)
                        Text("Environment") // Environment
                    }
                    Toggle(isOn: $poor) {
                        Image("poor")
                            .resizable()
                            .frame(width: 25.0, height: 25.0)
                        Text("Vulnerable populations") // Poor
                    }
                    Toggle(isOn: $disabilities) {
                        Image("handicap")
                            .resizable()
                            .frame(width: 25.0, height: 25.0)
                        Text("Helping handicap people") // Handicap
                    }
                    Toggle(isOn: $animals) {
                        Image("animals")
                            .resizable()
                            .frame(width: 25.0, height: 25.0)
                        Text("Animals") // Animals
                    }
                    Toggle(isOn: $tutoring) {
                        Image("tutoring")
                            .resizable()
                            .frame(width: 25.0, height: 25.0)
                        Text("Tutoring") // Tutoring
                    }
                    Toggle(isOn: $elders) {
                        Image("elder")
                            .resizable()
                            .frame(width: 25.0, height: 25.0)
                        Text("Helping the elder ones") // Elder
                    }
                }
                
            }
            Spacer()
        }
        .navigationBarTitle("Edit profile")
        .navigationBarItems(trailing:
            Button(action: self.updateProfile) {
                Text("Done")
            }
            )
        .alert(isPresented: $shown, content: {
                return Alert(title: Text(self.message))
        })
        .onAppear(perform: self.loadData)
    }
    
    func loadData() {
        if !NetworkState.isConnected() {
            self.message = "In order to edit your profile you need to have an internet connection."
            self.shown.toggle()
            presentationMode.wrappedValue.dismiss()
        } else {
            self.username = self.profileModel.userData?["username"] as! String
            self.firstName = self.profileModel.userData?["firstName"] as! String
            self.lastName = self.profileModel.userData?["lastName"] as! String
            self.description = self.profileModel.userData?["description"] as! String
            self.birthDateString = self.profileModel.userData?["birthDate"] as! String
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            self.birthDate = dateFormatter.date(from: self.profileModel.userData?["birthDate"] as! String) ?? Date()
            
            let categories = self.profileModel.userData?["categories"] as? [String] ?? []

            for category in categories {
                if category == "environment" {
                    self.environment.toggle()
                } else if category == "handicap" {
                    self.disabilities.toggle()
                } else if category == "animals" {
                    self.animals.toggle()
                } else if category == "poor" {
                    self.poor.toggle()
                } else if category == "tutoring" {
                    self.tutoring.toggle()
                } else if category == "elder" {
                    self.elders.toggle()
                }
            }
        }
    }
    
    func updateProfile() {
        if self.firstName == "" || self.lastName == "" || self.username == "" || self.description == "" {
            self.message = "Please fill all of the fields"
            self.shown.toggle()
        } else {
            // Update document in Firestore database with the user ID
            let db = Firestore.firestore()
            let userId:String = Auth.auth().currentUser!.uid
            // For writing the date:
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            
            // Update categories:
            let categories = self.updateCategories()
            
            db.collection("users").document(userId).updateData([
                "firstName": self.firstName,
                "lastName": self.lastName,
                "birthDate": formatter.string(from: self.birthDate),
                "username": self.username,
                "description": self.description,
                "categories": categories
            ]){ err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document added")
                }
            }
            self.message = "You have updated your profile successfully! 🎉"
            self.shown.toggle()
            
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func updateCategories() -> [String] {
        var categories: [String] = []
        if self.environment {
            categories.append("environment")
        }
        if self.disabilities {
            categories.append("handicap")
        }
        if self.animals {
            categories.append("animals")
        }
        if self.poor {
            categories.append("poor")
        }
        if self.tutoring {
            categories.append("tutoring")
        }
        if self.elders {
            categories.append("elder")
        }
        
        return categories
    }
    
}

struct EditProfile_Previews: PreviewProvider {
    static var previews: some View {
        EditProfile()
    }
}
