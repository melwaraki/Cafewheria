//
//  VenuesRouter.swift
//  Cafewheria
//
//  Created by Marwan Elwaraki on 25/09/2021.
//

import Foundation

class VenuesRouter {
    
    static var coffeeShopCategoryId = "+4bf58dd8d48988d1e0931735"
    
    static func getNearbyCoffeeShops(latitude: String, longitude: String, completion: @escaping (Result<[Venue], Error>) -> Void) {
        Router().get(VenuesRequestResponse.self, path: "venues/search", queryItems: [
            URLQueryItem(name: "ll", value: "\(latitude),\(longitude)"),
            URLQueryItem(name: "categoryId", value: coffeeShopCategoryId)]) { result in
            
            switch result {
            case .success(let requestResponse):
                completion(.success(requestResponse.response.venues.sorted()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
