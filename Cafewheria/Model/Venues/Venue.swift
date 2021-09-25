//
//  Venue.swift
//  Cafewheria
//
//  Created by Marwan Elwaraki on 25/09/2021.
//

import Foundation

struct Venue: Decodable, Identifiable {
    let id: String
    let name: String
    let location: Location
    
    var distance: String {
        return "\(location.distance)m"
    }
}

struct Location: Decodable {
    let distance: Int
}

extension Array where Element == Venue {
    func sorted() -> [Venue] {
        return sorted(by: {$0.location.distance < $1.location.distance})
    }
}
