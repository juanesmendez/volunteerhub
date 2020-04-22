//
//  UsersList.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 20/04/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import SwiftUI
import Firebase

struct UsersList: View {
    
    var usersListModel: UsersListViewModel
    
    init(volunteersIds: [String]) {
        self.usersListModel = UsersListViewModel(volunteers: volunteersIds)
        if volunteersIds.count > 0 {
            self.usersListModel.getVolunteers()
        }
    }
    
    var body: some View {
        List {
            Section(header: Text("Volunteer's planning to attend")) {
                ForEach(self.usersListModel.volunteersObjects) { volunteer in
                    NavigationLink(destination: VolunteerView(volunteer: volunteer)) {
                        Image(systemName: "person.fill")
                        if volunteer.id != Auth.auth().currentUser!.uid {
                            Text(volunteer.username)
                        } else {
                            Text("Me")
                        }
                        
                    }
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Volunteers attending")
        //.onAppear(perform: self.usersListModel.getVolunteers)
    }
}
/*
struct UsersList_Previews: PreviewProvider {
    static var previews: some View {
        UsersList()
    }
}
*/
