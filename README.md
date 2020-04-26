# VolunteerHub iOS App 📱🌎

This repository contains the swift code of the VolunteerHub iOS App. VolunteerHub is an app for iOS and Android, that offers volunteers a platform in which they can easily find volunteer activities around their area, making it possible for them to start helping others right way!

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

### ❗️Note:
In case you encounter yourself with any errors  when trying to execute the project in XCode, do the following:
- Delete the `/Pods` directory as well as the `VolunteeringHub.xcworkspace`.
- Go to the `root` directory of the project and run `pod install`. (This command will download all of the third-party dependencies and will create the `/Pods`, the `VolunteeringHub.xcworkspace` file, and will update the `Podfile.lock`)
