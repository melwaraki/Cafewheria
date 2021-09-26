//
//  LocationTests.swift
//  CafewheriaTests
//
//  Created by Marwan Elwaraki on 26/09/2021.
//

import XCTest
@testable import Cafewheria

class LocationTests: XCTestCase {
    
    var venues = [
        Venue(id: "0001", name: "One Coffee", location: Location(distance: 0, lat: 0, lng: 0)),
        Venue(id: "0002", name: "Second Coffee", location: Location(distance: 999, lat: 0, lng: 0)),
        Venue(id: "0003", name: "Coffee Tree", location: Location(distance: 1000, lat: 0, lng: 0)),
        Venue(id: "0004", name: "Coffee For Me", location: Location(distance: 1001, lat: 0, lng: 0)),
        Venue(id: "0005", name: "High Five Cafe", location: Location(distance: 1500, lat: 0, lng: 0))
    ]
    
    func testNearbyLocationsAreWithinOneKm() {
        XCTAssert(venues.filterToNearby().filter({$0.location.distance >= 1000}).isEmpty)
    }
    
    func testFarLocationsAreNotWithinOneKm() {
        XCTAssert(venues.filterToFar().filter({$0.location.distance < 1000}).isEmpty)
    }
    
    func testKmDistanceString() {
        let venue = Venue(id: "1234", name: "Mocka Venue", location: Location(distance: 38495, lat: 0, lng: 0))
        XCTAssertEqual(venue.kmDistanceString, "38.49km")
    }
    
    func testVenuesAreCorrectlySorted() {
        XCTAssertEqual(venues.sorted(), venues.sorted(by: {$0.location.distance < $1.location.distance}))
    }

}
