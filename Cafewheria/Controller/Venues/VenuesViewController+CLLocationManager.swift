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
                  return
              }
        
        VenuesRouter.getNearbyCoffeeShops(latitude: latitude, longitude: longitude) { result in
            switch result {
            case .success(let venues):
                self.venues = venues
                manager.stopUpdatingLocation()
                self.state = .success
            case .failure(let error):
                self.state = .error
                self.presentErrorAlert(message: error.localizedDescription)
            }
        }
    }
}

