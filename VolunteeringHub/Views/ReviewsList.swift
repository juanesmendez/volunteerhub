//
//  ReviewsList.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 4/06/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import SwiftUI

struct ReviewsList: View {
    
    var reviews: [Review]
    
    var body: some View {
        List {
            Section(header:
                HStack{
                    Image(systemName: "star")
                    Text("Reviews list")
                }
                
            ) {
                ForEach(self.reviews, id: \.self) { review in
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "house.fill")
                                .foregroundColor(.black)
                            Text("Foundation: \(review.foundation)")
                        }
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text("Score: \(String(review.score))")
                        }
                        HStack {
                            Image(systemName: "text.bubble.fill")
                                .foregroundColor(.blue)
                            Text("Comment: \(review.comment)")
                        }
                        Divider()
                    }
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Reviews")
    }
}

//struct ReviewsList_Previews: PreviewProvider {
//    static var previews: some View {
//        ReviewsList()
//    }
//}
