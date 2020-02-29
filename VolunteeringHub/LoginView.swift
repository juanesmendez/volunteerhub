//
//  LoginView.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 28/02/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    //@Binding var signInSuccess: Bool
    @EnvironmentObject var userData: UserData
    
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        
        VStack {
                Text("Volunteering Hub")
                    .font(.largeTitle)
                    .bold()
                
                Image("green")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .padding()
                
                VStack {
                    TextField("Username", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .cornerRadius(5.0)
                    
                    HStack {
                        Text("Sign in")
                            .padding(.horizontal, 10.0)
                            .padding(.vertical, 9.0)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 2))
                    }
                    
                        
                }
                .padding(.horizontal, 45)
                .padding(.bottom, 50)
                        
                VStack(alignment: .leading) {
                    /*
                    NavigationLink(destination: ContentView()) {
                        SignInRectangle(image: Image("google-icon"), text: "Sign in with Google")
                    }
                    .buttonStyle(PlainButtonStyle())
                    */
                    
                    Button(action: {
                        self.userData.signInSuccess.toggle()
                    }){
                        SignInRectangle(image: Image("google-icon"), text: "Sign in with Google")
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    
                    SignInRectangle(image: Image("facebook-icon"), text: "Sign in with Facebook")
                    
                    SignInRectangle(image: Image("green"), text: "Register with us")
                        
                }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
        .environmentObject(UserData())
    }
}
