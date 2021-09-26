//
//  Venue.swift
//  Cafewheria
//
//  Created by Marwan Elwaraki on 25/09/2021.
//

import Foundation
import CoreLocation
import MapKit

struct Venue: Decodable, Identifiable {
    let id: String
    let name: String
    let location: Location
}

extension Venue: Equatable {
    static func == (lhs: Venue, rhs: Venue) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Venue {
    
    var isNearby: Bool {
        return location.distance < 1000
    }
    
    var kmDistanceString: String {
        let kmDistance = Double(location.distance)/1000
        return String(format: "%.2fkm", kmDistance)
    }
    
    func openInMaps() {
        let coordinates = CLLocationCoordinate2DMake(location.lat, location.lng)
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = name
        
        let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking]
        mapItem.openInMaps(launchOptions: options)
    }
}

extension Array where Element == Venue {
    func sorted() -> [Venue] {
        return sorted(by: {$0.location.distance < $1.location.distance})
    }
    
    func filterToNearby() -> [Venue] {
        return filter({$0.isNearby})
    }
    
    func filterToFar() -> [Venue] {
        filter({!$0.isNearby})
    }
}
