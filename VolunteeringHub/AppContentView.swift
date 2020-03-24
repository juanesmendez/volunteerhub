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
    
    init() {
        print("Printing user from AppContentView:")
        print(self.user)
    }
    
    var body: some View {
        return Group {
            if Auth.auth().currentUser == nil {
                LoginView()
                    .environmentObject(userData)
            } else if Auth.auth().currentUser != nil || self.appDelegate.userId != "" {
                ContentView()
            }
            /*
            if appDelegate.userId == "" {
                LoginView()
                    .environmentObject(userData)
            } else {
                ContentView()
            }
            */
        }
    }
}

struct AppContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppContentView()
            .environmentObject(UserData())
    }
}
