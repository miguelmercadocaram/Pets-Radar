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
        createRequest(with: URL(string: Constants.baseAPIURL + "/animals?location=33126&type=dog"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                   // let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    
                let result = try JSONDecoder().decode(Animals.self, from: data)
                    //print(result)
                completion(.success(result.animals))
                }
                catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getAnimalsID(animalId: Animal, completion: @escaping (Result<[Animal],Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/animals/\(animalId.id)"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
        let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    
                // let result = try JSONDecoder().decode(Animals.self, from: data)
                    //print(result)
                //completion(.success(result.animals))
                }
                catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getAnimalsNextPage(page: Int, completion: @escaping (Result<[Animal],Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/animals?location=33126&type=dog&page=\(page)"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
         // let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    
                 let result = try JSONDecoder().decode(Animals.self, from: data)
                   //print(result)
                    completion(.success(result.animals))
                }
                catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getAnimalsTypes(animalType: String, completion: @escaping (Result<[Animal],Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/animals?location=33126&type=dog&breed=\(animalType)"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
         let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    
                 //let result = try JSONDecoder().decode(Animals.self, from: data)
                   print("Animals Types: \(result)")
                    //completion(.success(result.animals))
                }
                catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
}
