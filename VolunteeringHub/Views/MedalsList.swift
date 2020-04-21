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
        
        VStack {
            
            MedalRow(name: "Longest dog adoption spree", ranking: "First place")
            MedalRow(name: "Built a home in one day", ranking: "Third place")
            
            
        }
        
    }
}

struct MedalsList_Previews: PreviewProvider {
    static var previews: some View {
        MedalsList()
    }
}
