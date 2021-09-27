//
//  VenueTests.swift
//  CafewheriaTests
//
//  Created by Marwan Elwaraki on 26/09/2021.
//

import XCTest
@testable import Cafewheria

class VenueTests: XCTestCase {
    
    var venues = [
        Venue(id: "0001", name: "One Coffee", location: Location(distance: 0, lat: 0, lng: 0)),
        Venue(id: "0002", name: "Second Coffee", location: Location(distance: 999, lat: 0, lng: 0)),
        Venue(id: "0003", name: "Coffee Tree", location: Location(distance: 1000, lat: 0, lng: 0)),
        Venue(id: "0004", name: "Coffee For Me", location: Location(distance: 1001, lat: 0, lng: 0)),
        Venue(id: "0005", name: "High Five Cafe", location: Location(distance: 1500, lat: 0, lng: 0))
    ]
    
    func testVenuesAreCorrectlySorted() {
        XCTAssertEqual(venues.sorted(), venues.sorted(by: {$0.location.distance < $1.location.distance}))
    }
    
    func testCorrectVenueIsFetched() {
        testVenue(at: IndexPath(item: 0, section: 0), is: venues[0])
        testVenue(at: IndexPath(item: 1, section: 0), is: venues[1])
        testVenue(at: IndexPath(item: 0, section: 1), is: venues[2])
        testVenue(at: IndexPath(item: 1, section: 1), is: venues[3])
        testVenue(at: IndexPath(item: 2, section: 1), is: venues[4])
    }
    
    func testVenue(at indexPath: IndexPath, is expectedVenue: Venue) {
        let venue = VenuesViewController().getVenue(at: indexPath, in: venues)
        XCTAssertEqual(venue, expectedVenue)
    }

}
