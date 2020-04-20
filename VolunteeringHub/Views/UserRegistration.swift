//
//  UserRegistration.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 3/04/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseUI
import GoogleSignIn

struct UserRegistration: View {
    
    @EnvironmentObject var userData:UserData
    @ObservedObject var appDelegate = UIApplication.shared.delegate as! AppDelegate
    @State var pushActive = false
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var birthDate = Date()
    @State var email: String = ""
    @State var username: String = ""
    @State var password: String = ""
    @State var description: String = ""
    
    // For handling user feedback
    @State var shown:Bool = false
    @State var message:String = ""
    
    var body: some View {
        NavigationView{
        VStack {
            //NavigationView{
                Form {
                    Section(header: Text("Your basic information")){
                        TextField("First name", text: $firstName)
                        TextField("Last name", text: $lastName)
                        DatePicker(
                            selection: $birthDate,
                            //in: dateClosedRange,
                            displayedComponents: .date,
                            label: { Text("Select your birthdate") }
                        )
                    }
                    
                    Section(header: Text("Other information")){
                        TextField("Username", text: $username)
                        TextField("Email", text: $email)
                        SecureField("Password", text: $password)
                    }
                    
                    Section(header: Text("Tell us more about yourself")){
                        TextField("Your description", text: $description)
                            .padding(.bottom, 120)
                            .frame(height: 150)
                    }
                    
                }
            /*
            NavigationLink(destination: ContentView(), isActive: $pushActive) {
              Text("")
            }.hidden()
            */
            //}
            //.navigationBarTitle("Registration")
                
        }
            .navigationBarTitle("Registration")
            .navigationBarItems(leading:
                Button(action: {
                    self.userData.register = false
                    self.appDelegate.firstGoogleSignIn = false
                }) {
                    Text("Cancel")
                }
            , trailing:
            Button(action: {
                self.signUp()
            }) {
                Text("Submit")
            })
            
            /*
        .alert(isPresented: $shown, content: {
            return Alert(title: Text(self.message))
        })*/
        }
        
    }
    
    func signUp() {
        if self.email == "" || self.password == "" || self.firstName == "" || self.lastName == "" || self.username == "" || self.description == "" {
            self.message = "Please fill all of the fields"
            self.shown.toggle()
        }
        
        if self.userData.register == true {
            Auth.auth().createUser(withEmail: self.email, password: self.password) { (res, err) in
                
                if err != nil {
                    print((err!.localizedDescription))
                    self.message = err!.localizedDescription
                    self.shown.toggle()
                    return
                }
                // Insert document in Firestore database with the user ID
                let db = Firestore.firestore()
                //var ref: DocumentReference? = nil
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
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added")
                    }
                }
                /*
                ref = db.collection("users").addDocument(data: [
                    "userId": userId
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                    }
                }
                */
                self.message = "You signed up successfully! Welcome to VolunteerHub :)"
                self.shown.toggle()
                
                print("Signed in with user ID: \(Auth.auth().currentUser?.uid)")

                self.userData.register = false
                /*
                self.pushActive = true
                print("handleSuccessfullLogin")
                */
            }
        } else if self.appDelegate.firstGoogleSignIn == true {
            // Insert document in Firestore database with the user ID
            let db = Firestore.firestore()
            //var ref: DocumentReference? = nil
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
                    print("Error adding document: \(err)")
                } else {
                    print("Document added")
                }
            }
            
            self.message = "You signed up successfully! Welcome to VolunteerHub :)"
            self.shown.toggle()
            
            print("Signed in with user ID: \(Auth.auth().currentUser?.uid)")
            
            self.appDelegate.firstGoogleSignIn = false
        }
        
        
        
        
        
    }
    
}

struct UserRegistration_Previews: PreviewProvider {
    static var previews: some View {
        UserRegistration()
    }
}
