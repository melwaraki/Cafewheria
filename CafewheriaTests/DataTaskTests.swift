//
//  DataTaskTests.swift
//  CafewheriaTests
//
//  Created by Marwan Elwaraki on 26/09/2021.
//

import XCTest
@testable import Cafewheria

class DataTaskTests: XCTestCase {
    
    func testDataTaskWithInvalidURLError() {
        let data = Data()
        let response = URLResponse()
        let error = CustomError.invalidURL
        
        Router().handleDataTask(data: data, response: response, error: error) { (result: Result<Venue, Error>) in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error as! CustomError, CustomError.invalidURL)
            }
        }
    }
    
    func testDataTaskWithNoData() {
        let response = URLResponse()
        
        Router().handleDataTask(data: nil, response: response, error: nil) { (result: Result<Venue, Error>) in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, CustomError.noData.localizedDescription)
            }
        }
    }
    
    func testDataTaskWithInvalidData() {
        //generate random invalid data
        let bytes = [UInt32](repeating: 0, count: 8).map { _ in arc4random() }
        let data = Data(bytes: bytes, count: 8)
        let response = URLResponse()
        
        Router().handleDataTask(data: data, response: response, error: nil) { (result: Result<Venue, Error>) in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, CustomError.invalidData.localizedDescription)
            }
        }
    }
    
    func testDataTaskWithValidVenue() {
        let venue = Venue(id: "2359", name: "Open Till Latte", location: Location(distance: 38495, lat: 0, lng: 0))
        let data = try! JSONEncoder().encode(venue)
        let response = URLResponse()
        
        Router().handleDataTask(data: data, response: response, error: nil) { (result: Result<Venue, Error>) in
            switch result {
            case .success(let decodedVenue):
                XCTAssertEqual(decodedVenue, venue)
            case .failure(let error):
                XCTAssertEqual(error as! CustomError, CustomError.noData)
            }
        }
    }

}
