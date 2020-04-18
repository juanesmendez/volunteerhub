//
//  UserActivities.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 18/04/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import SwiftUI

struct UserActivities: View {
    
    @ObservedObject var model = UserActivitiesViewModel()
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Activities you are attending")) {
                    ForEach(model.userActivities) { activity in
                        NavigationLink(destination: ActivityDetail(activity: activity)){
                            HStack{
                                Image(activity.category)
                                    .resizable()
                                    .frame(width: 25.0, height: 25.0)
                                Text(activity.name)
                                Spacer()
                            }
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Your activities")
        }
        .onAppear(perform: model.loadUserActivities)
            
    }
}

struct UserActivities_Previews: PreviewProvider {
    static var previews: some View {
        UserActivities()
    }
}
