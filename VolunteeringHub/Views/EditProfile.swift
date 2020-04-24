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
    
    @ObservedObject var profileModel = ProfileViewModel()
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var birthDate = Date()
    @State var birthDateString = ""
    @State var username: String = ""
    @State var description: String = ""
    
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
                
            }
            Spacer()
        }
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
        
        self.username = self.profileModel.userData?["username"] as! String
        self.firstName = self.profileModel.userData?["firstName"] as! String
        self.lastName = self.profileModel.userData?["lastName"] as! String
        self.description = self.profileModel.userData?["description"] as! String
        self.birthDateString = self.profileModel.userData?["birthDate"] as! String
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.birthDate = dateFormatter.date(from: self.profileModel.userData?["birthDate"] as! String) ?? Date()
        
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
            db.collection("users").document(userId).setData([
                "firstName": self.firstName,
                "lastName": self.lastName,
                "birthDate": formatter.string(from: self.birthDate),
                "username": self.username,
                "description": self.description
            ]){ err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document added")
                }
            }
            self.message = "You have updated your profile successfully! 🎉"
            self.shown.toggle()
        }
    }
    
}

struct EditProfile_Previews: PreviewProvider {
    static var previews: some View {
        EditProfile()
    }
}
