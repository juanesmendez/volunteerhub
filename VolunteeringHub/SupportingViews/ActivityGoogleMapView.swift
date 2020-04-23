//
//  ActivityGoogleMapView.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 22/04/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import SwiftUI
import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation
import Foundation

struct ActivityGoogleMapView: UIViewRepresentable {
    
    var location: Activity.Location
    @Binding var address: String
    @Binding var coordinate: CLLocationCoordinate2D
    
    var marker : GMSMarker = GMSMarker()
    
    /// Creates a `UIView` instance to be presented.
    func makeUIView(context: Self.Context) -> GMSMapView {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        //marker.map = mapView
        
        return mapView
    }

    /// Updates the presented `UIView` (and coordinator) to the latest
    /// configuration.
    func updateUIView(_ mapView: GMSMapView, context: Self.Context) {
        // Creates a marker in the center of the map.
        
        let latitude = location.latitude
        let longitude = location.longitude
        mapView.camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 17.0)
        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        marker.title = "Your location"
        marker.snippet = "Local"
        marker.map = mapView
        
    }

}
/*
struct ActivityGoogleMapView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityGoogleMapView()
    }
}
 */
