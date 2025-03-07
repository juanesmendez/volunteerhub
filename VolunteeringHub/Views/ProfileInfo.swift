//
//  ProfileInfo.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 27/02/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import SystemConfiguration
import SwiftUI
import Firebase
import GoogleSignIn

struct ProfileInfo: View {
    
    @State var profileImage:UIImage = UIImage()
    @State var reviews: [Review]
    var score: Double {
        var prom:Double = 0
        if self.reviews.count > 0 {
            for review in self.reviews {
                prom = prom + review.score
            }
            prom = prom/Double(reviews.count)
        }
        
        return prom
    }
    
    
    
    var body: some View {
        HStack {
            VStack {
                
                if Auth.auth().currentUser?.photoURL != nil {
                    // If the user does have a profile picture
                    Image(uiImage: self.profileImage)
                    .clipShape(Circle())
                } else {
                    // If the user doesnt have a profile picture, a default image is shown
                    Image(uiImage: self.profileImage)
                        .resizable()
                        .frame(width: 100.0, height: 100.0)
                        .padding(.all, 10)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 0.3))
                    
                }
                
                Button(action: {
                    
                }) {
                    Text("Edit profile picture")
                }
            }
            
            Spacer()
            
            VStack {
                Text("Your score")
                    .font(.title)
                    
                Text(String(self.score))
                    .bold()
                    .padding()
                    .font(.title)
                .clipShape(Circle())
                    .overlay(Circle().stroke(Color.green, lineWidth: 4)
                )
            }
        }
        .padding(.top, 20)
        .padding(.bottom, 20)
        .padding(.horizontal, 55)
        .onAppear(perform: {
            guard let photoUrl = Auth.auth().currentUser?.photoURL else {
                print("The user does not have a profile picture")
                self.profileImage = UIImage(named: "user") ?? UIImage()
                return
            }
            
            let imageUrl = photoUrl.absoluteString
            let url  = NSURL(string: imageUrl)! as URL
            if Reachable.checkReachable(url: imageUrl) {
                let data = NSData(contentsOf: url)
                if data != nil {
                    self.profileImage = UIImage(data: data! as Data) ?? UIImage()
                }
            }
            
        })
    }
    
}

//struct ProfileInfo_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileInfo()
//    }
//}
