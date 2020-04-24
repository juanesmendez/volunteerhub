//
//  GoogleMapView.swift
//  VolunteeringHub
//
//  Created by Juan Esteban Méndez Roys on 21/04/20.
//  Copyright © 2020 Universidad de los Andes. All rights reserved.
//

import SwiftUI
import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation
import Foundation


struct GoogleMapView: UIViewRepresentable {
    
    @Binding var manager: CLLocationManager
    @Binding var alert: Bool
    @Binding var coordinate: CLLocationCoordinate2D
    @Binding var address: String
    var activities: [Activity]
    
    var marker : GMSMarker = GMSMarker()
    
    func makeCoordinator() -> GoogleMapView.Coordinator {
        return Coordinator(parent1: self)
    }
    
    /// Creates a `UIView` instance to be presented.
    func makeUIView(context: Self.Context) -> GMSMapView {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        
        manager.requestWhenInUseAuthorization()
        manager.delegate = context.coordinator
        manager.startUpdatingLocation()
        
        //marker.map = mapView
        
        return mapView
    }

    /// Updates the presented `UIView` (and coordinator) to the latest
    /// configuration.
    func updateUIView(_ mapView: GMSMapView, context: Self.Context) {
        // Creates a marker in the center of the map.
        mapView.camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 14.0)
        marker.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        marker.title = "Your location"
        marker.snippet = "Local"
        marker.map = mapView
        
        if self.activities.count > 0 {
            for activity in self.activities {
                let actMarker = GMSMarker()
                actMarker.position = CLLocationCoordinate2D(latitude: activity.location.latitude, longitude: activity.location.longitude)
                actMarker.icon = GMSMarker.markerImage(with: .brown)
                actMarker.map = mapView
            }
        }
        
    }

    class Coordinator: NSObject, CLLocationManagerDelegate {
        
        var parent: GoogleMapView
        
        init(parent1: GoogleMapView) {
            parent = parent1
        }
        
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            
            if status == .denied {
                parent.alert.toggle()
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            
            let location = locations.last
            //print("Coordinate in location manager: \(location?.coordinate)")
            parent.coordinate = location!.coordinate
            GMSGeocoder().reverseGeocodeCoordinate(location!.coordinate) { response, error in
                print("Reverse geocoding...")
                guard let response = response else {
                    return
                }
                self.parent.address = response.firstResult()?.lines?[0] ?? "Finding location"
            }
        }
    }
}

/*
struct GoogleMapView_Previews: PreviewProvider {
    static var previews: some View {
        GoogleMapView()
    }
}
 */
