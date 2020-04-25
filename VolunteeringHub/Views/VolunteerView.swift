//
//  Volunteer.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 21/04/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import SwiftUI

struct VolunteerView: View {
    
    var model: VolunteerViewModel
    
    init(volunteer: Volunteer) {
        self.model = VolunteerViewModel(volunteer: volunteer)
        self.model.loadVolunteerActivities()
    }
    
    private var date: Date {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            print("La fechaaaa \(self.model.volunteer.birthDate)")
            let dateString = self.model.volunteer.birthDate
            let aux = dateString.components(separatedBy: "T")
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
    
    var body: some View {
            List {
                Section (header:
                    VStack {
                        HStack {
                            Text("\(self.model.volunteer.firstName) \(self.model.volunteer.lastName)")
                                .font(.title)
                            
                            Spacer()
                            /*
                            ProfileInfo()
                            .padding(.bottom, 10)
                            */
                        }
                        HStack {
                            Image(systemName: "person")
                            Text("Basic information").font(.headline)
                            Spacer()
                        }
                    }
                ){
                    Text("Username: \(self.model.volunteer.username)")
                    Text("Birth date: \(self.date, formatter: Self.taskDateFormat)")
                }
//                    Section(header: Text("Basic information").font(.headline)){
//
//
//                    }
                
                Section(header:
                    HStack {
                        Image(systemName: "briefcase")
                        Text("Experience").font(.headline)
                    }
                ){
                    Text(self.model.volunteer.description)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Section(header:
                    HStack {
                        Image(systemName: "rosette")
                        Text("Medals").font(.headline)
                    }
                ){
                    MedalsList()
                }
                
                Section(header:
                    HStack {
                        Image(systemName: "tag")
                        Text("Interests").font(.headline)
                    }
                ){
                    if self.model.volunteer.categories.count > 0 {
                        ForEach(self.model.volunteer.categories) { category in
                            HStack {
                                Image(category)
                                    .resizable()
                                    .frame(width: 25.0, height: 25.0)
                                Text(category.capitalizingFirstLetter())
                            }
                        }
                    } else {
                        Text("\(self.model.volunteer.firstName) hasn't added any interests yet.")
                    }
//                    HStack {
//                        Spacer()
//                        InterestsList()
//                        Spacer()
//                    }
//                    .padding(.top, 20)
//                    .padding(.bottom, 20)
                }
                
                Section(header:
                    HStack {
                        Image(systemName: "calendar")
                        Text("Activities \(self.model.volunteer.firstName) will attend").font(.headline)
                    }
                ){
                    if self.model.volunteerActivities.count > 0 {
                        ForEach(self.model.volunteerActivities) { activity in
                            NavigationLink(destination: ActivityDetail(activity: activity)) {
                                Image(activity.category)
                                    .resizable()
                                    .frame(width: 25.0, height: 25.0)
                                Text(activity.name)
                            }
                        }
                    } else {
                        Text("\(self.model.volunteer.firstName) is not planning to attend any activities yet.")
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Volunteer info")
        
    }
}
/*
struct Volunteer_Previews: PreviewProvider {
    static var previews: some View {
        Volunteer()
    }
}
 */
