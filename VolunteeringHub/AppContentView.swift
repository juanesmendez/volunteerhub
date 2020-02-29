//
//  AppContentView.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 28/02/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import SwiftUI

struct AppContentView: View {
    
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        return Group {
            if !self.userData.signInSuccess {
                LoginView()
                    .environmentObject(userData)
            } else {
                ContentView()
            }
        }
    }
}

struct AppContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppContentView()
            .environmentObject(UserData())
    }
}
