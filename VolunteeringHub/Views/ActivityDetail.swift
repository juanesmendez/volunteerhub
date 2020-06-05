//
//  ActivityDetail.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 27/02/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import SwiftUI
import MapKit
import Firebase
import GoogleMaps
import GooglePlaces

struct ActivityDetail: View {
    
    //var activity: Activity
    @ObservedObject var model = ActivityDetailViewModel()
    @State var image:UIImage = UIImage()
    private var url = ""
    
    @ObservedObject var activityModel: ActivityViewModel
    
    @State var coordinate = CLLocationCoordinate2D()
    @State var address = String()
    //@State var location: Activity.Location
    
    private var date: Date {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            print("La fechaaaa \(self.activityModel.activity.date)")
            let aux = self.activityModel.activity.date.components(separatedBy: "T")
            let date = dateFormatter.date(from: aux[0]) ?? Date()
            return date
        }
        
    }
    
    //@State var attending = false
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    
    init(activity:Activity) {
        //self.activity = activity
        print("Initializing activity with id \(activity.id)")
        self.activityModel = ActivityViewModel(activity: activity)
        /*
        if(activityModel.activity.volunteers.contains(Auth.auth().currentUser!.uid)) {
            self.attending = true
        }else {
            self.attending = false
        }
        */
        if(activity.images.count > 0) {
            // Always getting the first image in the array
            self.url = activity.images[0].fileName
            print(self.url)
            //self.imageLoader.loadImage(urlString: self.url)
        }
        
    }
    
    var body: some View {
        List {
            
            Section (header:
                VStack(alignment: .leading) {
                    if self.date < Date() {
                        Text(self.activityModel.activity.name).font(.title).bold()
                            .padding(.bottom, 5)

                        HStack {
                            Text("Expired event")
                            .padding(.all, 5.0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.red, lineWidth: 3)
                            )
                        }.padding(.bottom, 20)
                      
                    } else {
                        Text(self.activityModel.activity.name).font(.title).bold()
                        .padding(.bottom, 20)
                    }
                    HStack {
                        Image(systemName: "calendar")
                        Text("Date").font(.headline)
                    }
                    
                }){
                Text("\(self.date, formatter: Self.taskDateFormat)")
            }
            
            Section(header:
                HStack {
                    Image(systemName: "tag")
                    Text("Category").font(.headline)
                }
            ) {
                HStack{
                    Image(self.activityModel.activity.category)
                        .resizable()
                        .frame(width: 25.0, height: 25.0)
                    Text(self.activityModel.activity.category.capitalizingFirstLetter())
                    Spacer()
                }
            }

            Section(header:
                HStack {
                    Image(systemName: "house")
                    Text("Foundation").font(.headline)
                }
            ) {
                HStack{
                    Text(self.activityModel.activity.foundation)
                    Spacer()
                }
            }
            
            Section(header:
                HStack {
                    Image(systemName: "bookmark")
                    Text("Description").font(.headline)
                }
            , footer:
                HStack {
                    if !NetworkState.isConnected() {
                        Text("⚠️ You can't attend or unattend this activity, neither add it to your interest list because you don't have an internet connection.")
                    } else {
                        Spacer()
                        if(self.activityModel.activity.volunteers.contains(Auth.auth().currentUser!.uid)) {
                            Button(action: {
                                // Deletes the volunteer from the ACTIVITY doc in the ACTIVITIES DB (PUT)
                                self.activityModel.removeVolunteerFromActivity(volunteerId: Auth.auth().currentUser!.uid)
                                // Removes the activity from the USER doc in the USERS DB (UPDATE)
                                self.activityModel.removeActivityFromUser(userId: Auth.auth().currentUser!.uid, activity: self.activityModel.activity)
                                // GET request for the new Activity updated after the PUT request
    //                            self.activityModel.getActivity(activityId: self.activityModel.activity.id)
                            }){
                                Text("Attending 😁")
                                    .padding(.all, 8.0)
                                    .background(Color.red)
                                    .foregroundColor(Color.white)
                                    .cornerRadius(20)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }else {
                            Button(action: {
                                // Adds the volunteer to the ACTIVITY doc in the ACTIVITIES DB (PUT)
                                self.activityModel.addVolunteer(volunteerId: Auth.auth().currentUser!.uid)
                                // Adds the activity to the USER doc in the USERS DB (UPDATE)
                                self.activityModel.addActivityToUser(userId: Auth.auth().currentUser!.uid, activity: self.activityModel.activity)
                                // GET request for the new Activity updated after the PUT request
    //                            self.activityModel.getActivity(activityId: self.activityModel.activity.id)
                            }){
                                Text("Attend 👍")
                                    .padding(.all, 8.0)
                                    .background(Color.green)
                                    .foregroundColor(Color.black)
                                    .cornerRadius(20)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        
                        if self.activityModel.interested.contains(self.activityModel.activity.id) {
                            Button(action: {
                                // Removes the activity from the volunteer's interested list
                                self.activityModel.deleteInterestActivityOfUser(userId: Auth.auth().currentUser!.uid, activity: self.activityModel.activity)
                                self.activityModel.getUserInterestedList(userId: Auth.auth().currentUser!.uid)
                                
                            }){
                                Text("Watching 🧐")
                                    .padding(.all, 8.0)
                                    .background(Color.red)
                                    .foregroundColor(Color.white)
                                    .cornerRadius(20)
                            }
                            .buttonStyle(PlainButtonStyle())
                        } else{
                            Button(action: {
                                // Adds the activity to the volunteer's interested list
                                self.activityModel.addInterestActivityToUser(userId: Auth.auth().currentUser!.uid, activity: self.activityModel.activity)
                                self.activityModel.getUserInterestedList(userId: Auth.auth().currentUser!.uid)
                            }){
                                Text("Watch 👓")
                                    .padding(.all, 8.0)
                                    .background(Color.blue)
                                    .foregroundColor(Color.white)
                                    .cornerRadius(20)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            ) {
            
                Text(self.activityModel.activity.description)
                    .fixedSize(horizontal: false, vertical: true)
                
            }
            
        
        
            Section(header:
                HStack {
                    Image(systemName: "camera")
                    Text("Photos").font(.headline)
                }
            ) {
                if(self.activityModel.activity.images.count == 0) {
                    Text("No photos of the activity have been added.")
                } else{
                    if(model.imageData.isEmpty){
                        Text("Loading image...")
                    } else {
                        Image(uiImage: ((model.imageData.isEmpty) ? UIImage(imageLiteralResourceName: "Event image") : UIImage(data: model.imageData)) ?? UIImage(imageLiteralResourceName: "Event image"))
                        .resizable()
                            .aspectRatio(contentMode: .fit)
                        //.frame(height: 150)
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                        .shadow(radius: 15)
                        )
                    }
                }
            }
            
            Section(header:
                HStack {
                    Image(systemName: "map")
                    Text("Location").font(.headline)
                }
                
            ) {
                /*
                ActivityGoogleMapView(location: $location, address: $address, coordinate: $coordinate)
                    Text(String(format: "%2f", self.activityModel.activity.location?.latitude ?? 0.0))
                  */
                NavigationLink(destination: ActivityGoogleMapView(location: self.activityModel.activity.location, address: $address, coordinate: $coordinate)){
                    Text(self.address)
                }
                
            }
                
            Section(header:
                HStack {
                    Image(systemName: "briefcase")
                    Text("Details").font(.headline)
                }
                
            ) {
                    HStack {
                        Spacer()
                        VStack {
                            Text(String(self.activityModel.activity.volunteersNeeded))
                                .bold()
                                .foregroundColor(Color.green)
                                .padding()
                                .font(.title)
                                .overlay(Circle().stroke(Color.gray, lineWidth: 1)
                                    )
                                    
                            Text("Volunteers\nneeded")
                                .multilineTextAlignment(.center)
                        }
                        Spacer()
                        VStack {
                            Text(String(self.activityModel.activity.volunteersNeeded - (self.activityModel.activity.volunteersAttending)))
                                .bold()
                                .foregroundColor(Color.red)
                                .padding()
                                .font(.title)
                                .overlay(Circle()
                                    .stroke(Color.gray, lineWidth: 1)
                                )

                            Text("Spots\nleft")
                                .multilineTextAlignment(.center)
                        }
                        Spacer()
                    }
                    .frame(height: 110)
                    
                    Divider()
                
                    NavigationLink(destination: UsersList(volunteersIds: self.activityModel.activity.volunteers)) {
                        HStack {
                            Image(systemName: "person.3.fill")
                            Text("Volunteers attending")
                        }
                    }
                }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle(Text("Activity Information"), displayMode: .inline)
        .onAppear(perform: {
            // Get the interests list of the user
            self.activityModel.getUserInterestedList(userId: Auth.auth().currentUser!.uid)
            // For loading the image related to the activity. It is loaded only when the view appears,
            // or else it will load when the activity list shows (causing an overload in the back-end service)
            if(self.activityModel.activity.images.count > 0) {
                print("INSIDE onAppear for loading activity image")
                self.model.loadImage(urlString: self.url)
            }
            self.loadAddress()
        })
    }

    func loadAddress() {
        GMSGeocoder().reverseGeocodeCoordinate(CLLocationCoordinate2D(latitude: self.activityModel.activity.location.latitude, longitude: self.activityModel.activity.location.longitude)) { response, error in
            print("Reverse geocoding...")
            guard let response = response else {
                return
            }
            self.address = response.firstResult()?.lines?[0] ?? "Finding location"
        }
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

/*
struct ActivityDetail_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDetail()
    }
}
 */
