//
//  ProfileView.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 27/02/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView{
            ScrollView {
                    VStack {
                        HStack {
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text("Hello ")
                                    .font(.headline)
                                Text("Juan Mendez")
                                    .font(.title)
                                
                            }
                            .padding(.horizontal, 10)
                        }
                        
                        ProfileInfo()
                            .padding(.bottom, 10)
                        
                        VStack(alignment: .leading) {
                            VStack {
                                HStack {
                                    Text("Your experience")
                                        .font(.title)
                                        .bold()
                                    Spacer()
                                }
                                
                                Text("Three years doing volunteer work. I have participated in more than 50 activities organized around Colombia. I am a truly empathetic person.")
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
                        
                        
                    }
            }
        .navigationBarTitle("Your profile")
        }
            
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
