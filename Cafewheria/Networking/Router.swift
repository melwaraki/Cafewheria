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
    let versionNumber = "20180323"
    
    let baseURL = "https://api.foursquare.com/"
    
    var userlessAuthentication: [URLQueryItem] {
        return [
            URLQueryItem(name: "client_secret", value: clientSecret),
            URLQueryItem(name: "client_id", value: clientID),
            URLQueryItem(name: "v", value: versionNumber)
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
            completion(.failure(CustomError.invalidURL))
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            self.handleDataTask(data: data, response: response, error: error) { result in
                completion(result)
            }
        })

        task.resume()
    }
    
    func handleDataTask<T: Decodable>(data: Data?, response: URLResponse?, error: Error?, completion: @escaping (Result<T, Error>) -> Void) {
        if let error = error {
            completion(.failure(error))
            return
        }
        
        guard let data = data else {
            completion(.failure(CustomError.noData))
            return
        }
        
        do {
            let decodedObject = try JSONDecoder().decode(T.self, from: data)
            completion(Result.success(decodedObject))
        } catch {
            completion(.failure(CustomError.invalidData))
        }
    }
}

enum CustomError: Error {
    case invalidURL
    case noData
    case invalidData
}
