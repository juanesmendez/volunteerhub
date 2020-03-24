//
//  ActivityDetail.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 27/02/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import SwiftUI
import MapKit

struct ActivityDetail: View {
    
    var activity: Activity
    @ObservedObject var imageLoader = ImageLoader()
    @State var image:UIImage = UIImage()
    private var url = ""
    
    init(activity:Activity) {
        self.activity = activity
        if(activity.images.count > 0) {
            // Always getting the first image in the array
            self.url = "http://localhost:3000/photos/image/" + activity.images[0].fileName
            print(self.url)
            //self.imageLoader.loadImage(urlString: self.url)
        }
        
    }
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text(activity.name)
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                }
                .padding(.leading)
                
                if(activity.images.count == 0) {
                    Text("No photos of the activity have been added.")
                } else{
                    if(imageLoader.data.isEmpty){
                        Text("Loading image...")
                    } else {
                        Image(uiImage: (imageLoader.data.isEmpty) ? UIImage(imageLiteralResourceName: "Event image") : UIImage(data: imageLoader.data)!)
                        .resizable()
                        //.frame(height: 150)
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                        .shadow(radius: 15)
                        )
                        .padding(.horizontal, 40)
                    }
                }
                
                VStack {
                    HStack {
                        Text("Description")
                            .font(.title)
                            .bold()
                        Spacer()
                    }
                    .padding(.leading)
                    Text(activity.description)
                    .padding(.leading)
                }
                
                VStack {
                    HStack {
                        Text("Location")
                            .font(.title)
                            .bold()
                        Spacer()
                    }
                    .padding(.leading)
                    
                    MapView(coordinate: CLLocationCoordinate2D(latitude: 4.6527513, longitude: -74.0597535))
                        .frame(height: 150)
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                        .shadow(radius: 15)
                    )
                        .padding(.horizontal, 10)
                }
                
                
                VStack {
                    HStack {
                        Text("Details")
                            .font(.title)
                            .bold()
                        Spacer()
                    }
                    .padding(.leading)
                    
                    HStack {
                        Spacer()
                        VStack {
                            Text(String(activity.volunteersNeeded))
                                .bold()
                                .foregroundColor(Color.green)
                                .padding()
                                .font(.title)
                                .overlay(Circle().stroke(Color.gray, lineWidth: 1)
                                    )
                                    .shadow(radius: 5)
                            Text("Volunteers\nneeded")
                            .multilineTextAlignment(.center)
                        }
                        Spacer()
                        VStack {
                            Text(String(activity.volunteersNeeded - (activity.volunteersAttending ?? 0)))
                                .bold()
                                .foregroundColor(Color.red)
                                .padding()
                                .font(.title)
                                .overlay(Circle()
                                    .stroke(Color.gray, lineWidth: 1)
                                )
                                .shadow(radius: 5)
                            Text("Spots\nleft")
                            .multilineTextAlignment(.center)
                        }
                        Spacer()
                    }
                    .frame(height: 110)
                }
                
                
            }
            .navigationBarTitle(Text("Activity Information"), displayMode: .inline)
            .onAppear(perform: {
                // For loading the image related to the activity. It is loaded only when the view appears, 
                // or else it will load when the activity list shows (causing an overload in the back-end service)
                if(self.activity.images.count > 0) {
                    self.imageLoader.loadImage(urlString: self.url)
                }
            })
        }
        .padding(.top, 52)
    }
}

/*
struct ActivityDetail_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDetail()
    }
}
 */
