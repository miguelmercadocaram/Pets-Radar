//
//  APICaller.swift
//  PetsRadar
//
//  Created by Pelayo Mercado on 11/28/21.
//

import Foundation


final class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
    
    struct Constants {
        static let baseAPIURL = "https://api.petfinder.com/v2"
        
    }
    
    enum APIError: Error {
        case failedToGetData
    }
    
    enum HTTPMethod: String {
        case GET
        case POST
    }
    
    private func createRequest(with url: URL?, type: HTTPMethod, completion: @escaping (URLRequest) -> Void) {
        AuthManager.shared.withValidToken { token in
            guard let apiURL = url else {
                return
            }
            var request = URLRequest(url: apiURL)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            print(request)
            completion(request)
            
        }
    }
    
    public func getAnimals(completion: @escaping (Result<[Animal],Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/animals?type=dog&page=2&limit=1"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
          //let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    
                   let result = try JSONDecoder().decode(AnimalsResponse.self, from: data)
                    print(result)
                    completion(.success(result.animals.compactMap({$0.animals})))
                }
                catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
}
