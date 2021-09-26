//
//  URLTests.swift
//  CafewheriaTests
//
//  Created by Marwan Elwaraki on 26/09/2021.
//

import XCTest
@testable import Cafewheria

class URLTests: XCTestCase {

    func testBuildURL() {
        
        let url = Router().buildURL(path: "venues/search", queryItems: [
            URLQueryItem(name: "ll", value: "\(12.34),\(56.78)"),
            URLQueryItem(name: "categoryId", value: "1234"),
        ])
        
        let expectedURL = URL(string: "https://api.foursquare.com/v2/venues/search?ll=12.34,56.78&categoryId=1234&client_secret=\(Router().clientSecret)&client_id=\(Router().clientID)&v=\(Router().versionNumber)")
        
        XCTAssertEqual(url, expectedURL)
    }
}
