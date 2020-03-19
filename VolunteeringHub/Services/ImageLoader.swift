//
//  ImageLoader.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 19/03/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import Foundation
import Combine

class ImageLoader: ObservableObject {
    @Published var data = Data()
    /*
    init(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
     */
    
    func loadImage(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                print("DATOS TRAIDOS DE LA IMAGEN")
                print(data)
                self.data = data
            }
        }
        task.resume()
    }
}
