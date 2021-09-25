//
//  Router.swift
//  Cafewheria
//
//  Created by Marwan Elwaraki on 25/09/2021.
//

import Foundation
import Combine

class Router {
    let clientSecret = "EJ01NG5ALPRC4VMITXXDKEM4AGMPIR5U414V4TTJJP1Y5DT5"
    let clientID = "1BQJUKFMHWZAIHZSKE5MTLECNHXMALRS0Y254UZPRGM5K4RW"
    
    let baseURL = "https://api.foursquare.com/"
    
    var userlessAuthentication: [URLQueryItem] {
        return [
            URLQueryItem(name: "client_secret", value: clientSecret),
            URLQueryItem(name: "client_id", value: clientID),
            URLQueryItem(name: "v", value: "20180323")
        ]
    }
    
    func buildURL(path: String, queryItems: [URLQueryItem]) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.foursquare.com"
        components.path = "/v2/\(path)" // /venues/search?
        components.queryItems = queryItems + userlessAuthentication
        
        return components.url
    }
    
    func get<T: Decodable>(_ type: T.Type, path: String, queryItems: [URLQueryItem], completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = buildURL(path: path, queryItems: queryItems) else {
            completion(.failure(URLError.invalidURL))
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in

            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(URLError.noData))
                return
            }
            
            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                completion(Result.success(decodedObject))
            } catch let decodingError {
                completion(.failure(decodingError))
            }
        })

        task.resume()
    }
}

enum URLError: Error {
    case invalidURL
    case noData
    case invalidData
}
