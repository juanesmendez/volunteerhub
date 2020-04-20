//
//  MedalsList.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 27/02/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import SwiftUI

struct MedalsList: View {
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Medals")
                .font(.title)
                .bold()
                .padding(.leading, 10)
            
            
            List() {
                MedalRow(name: "Longest dog adoption spree", ranking: "First place")
                MedalRow(name: "Built a home in one day", ranking: "Third place")
            }.frame(height: 130)
            
        }
        
    }
}

struct MedalsList_Previews: PreviewProvider {
    static var previews: some View {
        MedalsList()
    }
}
