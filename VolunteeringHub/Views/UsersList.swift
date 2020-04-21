//
//  UsersList.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 20/04/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import SwiftUI

struct UsersList: View {
    
    var usersListModel: UsersListViewModel
    
    init(volunteersIds: [String]) {
        self.usersListModel = UsersListViewModel(volunteers: volunteersIds)
        self.usersListModel.getVolunteers()
    }
    
    var body: some View {
        List {
            Section(header: Text("Volunteer's planning to attend")) {
                ForEach(self.usersListModel.volunteersObjects) { volunteer in
                    Text(volunteer.username)
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Volunteers attending")
        .onAppear(perform: self.usersListModel.getVolunteers)
    }
}
/*
struct UsersList_Previews: PreviewProvider {
    static var previews: some View {
        UsersList()
    }
}
*/
