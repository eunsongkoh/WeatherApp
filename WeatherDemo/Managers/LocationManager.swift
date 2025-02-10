//
//  LocationManager.swift
//  WeatherDemo
//
//  Created by Eunsong Koh on 2025-02-08.
//

import Foundation
import CoreLocation

//NSObjectProtocol: This allows the class to conform to certain standards expected by the Objective-C runtime.
// ObservableObject: This is a SwiftUI protocol, allowing this class to be observed by a SwiftUI view. Any changes to properties marked with @Published will trigger a re-render of the UI that’s observing this class.
//CLLocationManagerDelegate: This is a delegate protocol from the CoreLocation framework. By conforming to this protocol, the LocationManager class can handle location-related events like when the location changes or when there’s an error retrieving the location.
// allows us to manager location
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate{
    let manager = CLLocationManager()
    
    // might not get location, if user refuses access to location
    // the @Published tells it that it will notify any observing views when its value changes
    @Published var location: CLLocationCoordinate2D?
    @Published var isLoading = false
    
    // when we first initialize our class we need to call this
    override init(){
        //calls the initializer of the superclass (in this case, NSObjectProtocol), which is required since LocationManager inherits from NSObject
        super.init()
        
        //manager.delegate = self assigns the LocationManager instance as the delegate of CLLocationManager. This means that LocationManager will handle the events triggered by CLLocationManager
        manager.delegate = self
    }
    
    func requestLocation() {
        isLoading = true
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
        isLoading = false
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Error getting location", error)
        isLoading = false
    }
}
