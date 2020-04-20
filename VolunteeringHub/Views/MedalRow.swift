//
//  MedalRow.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 27/02/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import SwiftUI

struct MedalRow: View {
    
    var name: String
    
    var ranking: String
    
    var body: some View {
        HStack {
            Image("medal")
            .resizable()
                .frame(width: 50.0, height: 50.0)
            
            VStack(alignment: .leading) {
                Text(name)
                Text(ranking)
                    .font(.subheadline)
            }
            
            Spacer()
        }
    }
}

struct MedalRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MedalRow(name: "Longest dog adoption spree", ranking: "First place")
        }
        .previewLayout(.fixed(width: 300, height: 70))
        
    }
}
