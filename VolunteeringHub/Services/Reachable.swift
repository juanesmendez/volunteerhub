//
//  Reachable.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 17/04/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import Foundation
import SystemConfiguration

class Reachable {
    // Function for checking internet connectivity
    static func checkReachable(url: String?) -> Bool {
        guard let url = url else {
            return false
        }
        let reachability = SCNetworkReachabilityCreateWithName(nil, url)
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(reachability!, &flags)
        
        let isConnected = isNetworkReachable(with: flags)
        
        if isConnected {
            print(flags)
            print("You have internet connection")
        } else if !isConnected {
            print("Sorry no connection")
            print(flags)
        }
        return isConnected
    }
    
    // Helper function for checking internet connectivity
    static func isNetworkReachable(with flags: SCNetworkReachabilityFlags) -> Bool {
        let isReachable = flags.contains(.reachable)
        let needsConnection =  flags.contains(.connectionRequired)
        let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        let canConnectWithoutUserInteraction = canConnectAutomatically && !flags.contains(.interventionRequired)
        return isReachable && (!needsConnection || canConnectWithoutUserInteraction)
    }
}
