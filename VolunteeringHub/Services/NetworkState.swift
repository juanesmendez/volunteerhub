//
//  NetworkState.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 26/04/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import Foundation
import Alamofire

class NetworkState {
    class func isConnected() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
