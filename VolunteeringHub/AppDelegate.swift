//
//  AppDelegate.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 27/02/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import UIKit
import SwiftUI
import Firebase
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate, ObservableObject {
    
    // For connecting to Firebase
    //var window: UIWindow?
    @Published var userId: String = ""
    // Variable for knowing if its the first time a user signs in with Google
    @Published var firstGoogleSignIn = false
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
      // ...
      if let error = error {
        // ...
        print(error.localizedDescription)
        return
      }

      guard let authentication = user.authentication else { return }
      let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                        accessToken: authentication.accessToken)
      // ...
        Auth.auth().signIn(with: credential) { (res, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            // Check if user already signed in, if not, register ID in Firestore 'users' collection
            
            let newUser = res?.additionalUserInfo?.isNewUser
            
            if newUser == true {
                self.firstGoogleSignIn = true
                
                print("New Google user.")
                let db = Firestore.firestore()
                //var ref: DocumentReference? = nil
                //ref = db.collection("users").document((res?.user.uid)!)
                
                db.collection("users").document((res?.user.uid)!).setData([
                    "name": (res?.user.displayName)!
                ]){ err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added")
                    }
                }
            }
            print("user=" + (res?.user.email)!)
            //print((res?.user.phoneNumber)!)
            print((res?.user.displayName)!)
            print((res?.user.photoURL)!)
            print((res?.user.providerData)!)
            print((res?.user.providerID)!)
            print((res?.user.uid)!)
            print(type(of: res?.user))
            self.userId = res?.user.uid ?? ""
            //self.userData.signInSuccess.toggle()
        }
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

