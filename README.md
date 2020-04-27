# VolunteerHub iOS App 📱🌎

This repository contains the swift code of the VolunteerHub iOS App. VolunteerHub is an app for iOS and Android, that offers volunteers a platform in which they can easily find volunteer activities around their area, making it possible for them to start helping others right way!

### Third-party libraries used
- Firebase Analytics 📊
- Firebase Auth 🔑
- Firestore 🔥
- FirebaseUI Auth 🔐
- FirebaseUI Google 
- FirebaseFirestoreSwift
- ReachabilitySwift
- Google Maps 🗺
- Google Places 📍🍔
- Alamofire 🔥

## How to run the project? 💻

For running the app in a simulator, please follow the steps shown below:

1. Clone the repository. 
    - Cloning the repository may take a long time given that all of the third-party libraries 📚 files are contained in the repo.
    - This project uses Cocoa Pods 🍫 dependencies manager, so if you don't have it on your computer please download it. 
    - Configure the 'pod' terminal command as well.
2. Open the terminal and go to the `root` 📁 directory of the project. 
3. Run the following command: `open VolunteeringHub.xcworkspace`. (This command will open XCode project)
    - The `/Pods` directory contains all of the third-party libraries 📚, so you won't need to execute any additional commands.
4. Having XCode open, run the project in the simulator of the iPhone device you desire. (Most of the testing was done using an iPhone 11 simulator).

### Minor things to keep in mind

- OS version: iOS 13 📱
- Please simulate the location 📍 of the device in XCode, in order for the map that is shown in the Home 🏠 screen to render the 'current' location 📍 of the user.
    - If you simulate the location to be in Sydney, Australia 🇦🇺, you will notice the brown markers in the map 🗺 showing the location 📍 of some of the activities near the user. (This is only in the case of the Sydney's location, given that no other activities were created in the other cities that can be simulated using XCode).
- The app supports sign in 🔑 with `email` and `password`.
- The app supports sign in 🔑 with `Google`.

### ❗️Note:
In case you encounter yourself with any errors  when trying to execute the project in XCode, do the following:
- Delete the `/Pods` directory as well as the `VolunteeringHub.xcworkspace`.
- Go to the `root` directory of the project and run `pod install`. (This command will download all of the third-party dependencies and will create the `/Pods`, the `VolunteeringHub.xcworkspace` file, and will update the `Podfile.lock`)
