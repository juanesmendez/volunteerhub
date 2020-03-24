//
//  AppContentView.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 28/02/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseUI
import GoogleSignIn

struct AppContentView: View {
    
    @EnvironmentObject var userData: UserData
    @ObservedObject var appDelegate = UIApplication.shared.delegate as! AppDelegate
    @State var user = Auth.auth().currentUser
    /*
    @State var handle = Auth.auth().addStateDidChangeListener { (auth, user) in
      // ...
        return user?.uid
    }
    */
    
    init() {
        print("DESDE APP CONTENT IMPRIMIENDO USUARIO")
        print(Auth.auth().currentUser?.uid)
    }
    
    var body: some View {
        return Group {
            /*
            if !self.userData.signInSuccess {
                LoginView()
                    .environmentObject(userData)
            } else {
                ContentView()
            }
             */
            if appDelegate.userId == "" {
                LoginView()
                .environmentObject(userData)
            } else {
                ContentView()
            }
            /*
            if user == nil {
                LoginView()
                    .environmentObject(userData)
            } else {
                //print("DESDE APP CONTENT IMPRIMIENDO USUARIO")
                //print(Auth.auth().currentUser)
                ContentView()
            }*/
        }
    }
}

struct AppContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppContentView()
            .environmentObject(UserData())
    }
}
