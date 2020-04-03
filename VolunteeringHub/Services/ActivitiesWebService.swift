//
//  ActivitiesWebService.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 18/03/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import Foundation

class ActivitiesWebService {
    
    let baseUrl: String  = "http://3.228.168.162:3000"
    
    func getActivities(completion: @escaping ([Activity]?) -> ()){
        
        guard let url = URL(string: "\(self.baseUrl)/activities")
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
    
    func getActivity(activityId:String, completion: @escaping (Activity?) -> ()) {
        print("IN GET REQUEST ACTIVITY")
        guard let url = URL(string: "\(self.baseUrl)/activities/\(activityId)")
            else{
               fatalError("Invalid URL")
        }
        print("URL for GET request: \(url)")
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            let activity = try? JSONDecoder().decode(Activity.self, from: data)
            
            //print("Printing activity from Web Service GET: \(activity)")
            
            DispatchQueue.main.async {
                completion(activity)
            }
        }
        .resume()
    }
    
    //func addVolunteerToActivity(activityId:String, volunteers: [String], completion: @escaping () -> ()){
    func addVolunteerToActivity(activityId:String, volunteers: [String], completion: @escaping (Activity?) -> ()){
        let url = URL(string: "\(self.baseUrl)/activities/" + activityId)!

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        // Check how i can send an array of object and not of Strings
        let jsonDictionary: [String: [String]] = [
            "volunteers": volunteers
        ]

        let data = try! JSONSerialization.data(withJSONObject: jsonDictionary, options: .prettyPrinted)
        
        URLSession.shared.uploadTask(with: request, from: data) { (responseData, response, error) in
            if let error = error {
                print("Error making PUT request: \(error.localizedDescription)")
                return
            }
            
            if let responseCode = (response as? HTTPURLResponse)?.statusCode, let responseData = responseData {
                guard responseCode == 200 else {
                    print("Invalid response code: \(responseCode)")
                    return
                }
                print("Response data!!")
                print(responseData)
                // This doesn't return an Activity object, it returns a response to the PUT request
                // The following line needs to be changed
                let activity = try? JSONDecoder().decode(Activity.self, from: responseData)
                // Uncomment the following line
                /*
                if let responseJSONData = try? JSONSerialization.jsonObject(with: responseData, options: .allowFragments) {
                    print("Response JSON data = \(responseJSONData)")
                }
                */
                DispatchQueue.main.async {
                    completion(activity)
                    // completion()
                }
            }
        }.resume()
        
    }
    
}
