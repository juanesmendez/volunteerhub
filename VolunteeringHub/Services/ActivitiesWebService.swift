//
//  ActivitiesWebService.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 18/03/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import Foundation

class ActivitiesWebService {
    
    func getActivities(completion: @escaping ([Activity]?) -> ()){
        
        guard let url = URL(string: "http://localhost:3000/activities")
            else{
               fatalError("Invalid URL")
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            let activities = try? JSONDecoder().decode([Activity].self, from: data)
            
            DispatchQueue.main.async {
                completion(activities)
            }
        }.resume()
    }
    
}
