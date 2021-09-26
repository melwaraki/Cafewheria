//
//  VenuesViewController+CLLocationManager.swift
//  Cafewheria
//
//  Created by Marwan Elwaraki on 25/09/2021.
//

import CoreLocation

extension VenuesViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation :CLLocation = locations[0] as CLLocation
        
        guard let latitude = userLocation.coordinate.latitude.toString(),
              let longitude = userLocation.coordinate.longitude.toString() else {
                  presentErrorAlert(message: "Couldn't access location services")
                  return
              }
        
        VenuesRouter.getNearbyCoffeeShops(latitude: latitude, longitude: longitude) { result in
            switch result {
            case .success(let venues):
                self.venues = venues
                manager.stopUpdatingLocation()
                self.state = .success
            case .failure(let error):
                self.state = .error(message: error.localizedDescription)
                self.presentErrorAlert(message: error.localizedDescription)
            }
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .denied {
            state = .error(message: "Location services not authorised")
        } else {
            checkLocation()
        }
    }
    
    func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        checkLocation()
    }
    
    func checkLocation() {
        state = .loading
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
}

