//
//  LoginView.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 28/02/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseUI
import GoogleSignIn

struct LoginView: View {
    
    //@Binding var signInSuccess: Bool
    @EnvironmentObject var userData: UserData

    @State var email: String = ""
    @State var password: String = ""
    @State var shown:Bool = false
    @State var message:String = ""
    
    @State var showNetworkMessage: Bool = false
    @State var networkMessage:String = ""

    var body: some View {
        ScrollView {
            VStack {
                Text("Volunteering Hub")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 50)
                
                Image("green")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .padding()
                
                VStack {
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .cornerRadius(5.0)
                    
                    HStack {
                        /*
                        Button(action: {
                            self.signUp()
                        }){
                            Text("Sign up")
                                .padding(.horizontal, 10.0)
                                .padding(.vertical, 9.0)
                                .cornerRadius(10)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 2))
                        }
                        .buttonStyle(PlainButtonStyle())
                        */
                        Button(action: {
                            self.signIn()
                        }){
                            Text("Sign in")
                                .padding(.horizontal, 10.0)
                                .padding(.vertical, 9.0)
                                .cornerRadius(10)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 2))
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    Button(action: {
                        if NetworkState.isConnected(){
                            print("Internet is available")
                            self.userData.register = true
                        } else {
                            print("Internet is NOT available")
                            self.networkMessage = "You do not have an internet connection, please sign up later."
                            self.showNetworkMessage.toggle()
                        }
                        
                    }, label: {
                        Text("Register with us")
                    })
                        .padding(.top, 10)
                    /*
                    NavigationLink(destination: UserRegistration(), isActive: $register){
                        Text("Register with us")
                    }
                    .padding(.top, 10)
                      */
                }
                .padding(.horizontal, 45)
                .padding(.bottom, 50)
                        
                VStack(alignment: .leading) {
                    
                    Google().frame(width: 260, height: 50)
                    
//                    Button(action: {
//                        //self.userData.signInSuccess.toggle()
//                    }){
//                        SignInRectangle(image: Image("google-icon"), text: "Sign in with Google")
//                    }
//                    .buttonStyle(PlainButtonStyle())
                    
                    
                    SignInRectangle(image: Image("facebook-icon"), text: "Sign in with Facebook")
                    
//                    SignInRectangle(image: Image("green"), text: "Register with us")
                        
                }
            }
            .alert(isPresented: $shown, content: {
                return Alert(title: Text("Error signing in"), message: Text(self.message))
            })
            .alert(isPresented: $showNetworkMessage, content: {
                return Alert(title: Text("Network error"), message: Text(self.networkMessage))
            })
        }
    }
    
    func signIn() {
        print("Email:\(self.email)")
        print("Password:\(self.password)")
        
        if self.email.isEmpty || self.password.isEmpty {
            self.message = "Please fill up email and password fields"
            self.shown.toggle()
        } else {
            Auth.auth().signIn(withEmail: self.email, password: self.password) { (res, err) in
                
                if err != nil {
                    print((err!.localizedDescription))
                    self.message = "Email or password may be incorrect"
                    self.shown.toggle()
                    return
                }
                //self.userData.user = res?.user
                self.message = "Success"
                self.shown.toggle()
                
                //For the app delegate to know:
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.userId = res?.user.uid ?? ""
            }
        }
    }
    
    /*
    func signUp() {
        if self.email == "" || self.password == "" {
            self.message = "Please fill all of the fields"
            self.shown.toggle()
        }
        
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
            db.collection("users").document(userId).setData([
                "name": ""
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
        }
        //self.userData.signInSuccess.toggle()
    }
    */
    
}

struct Google: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<Google>) -> GIDSignInButton {
        let button = GIDSignInButton()
        button.colorScheme = .dark
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.last?.rootViewController
        return button
    }
    
    func updateUIView(_ uiView: GIDSignInButton, context: UIViewRepresentableContext<Google>) {
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
        .environmentObject(UserData())
    }
}
