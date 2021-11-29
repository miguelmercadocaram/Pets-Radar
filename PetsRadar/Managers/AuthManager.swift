//
//  AuthManager.swift
//  PetsRadar
//
//  Created by Pelayo Mercado on 11/28/21.
//



import Foundation

final class AuthManager {
    static let shared = AuthManager()
    
    private var refreshingToken = false
    
    private var accessToken: String? {
        return UserDefaults.standard.string(forKey: "access_token")
    }
    
    private var tokenExpirationDate: Date? {
        return UserDefaults.standard.object(forKey: "expirationDate") as? Date
    }
    
    private var shouldRefreshToken: Bool {
        guard let expirationDate = tokenExpirationDate else {
            return false
        }
        let currentDate = Date()
        let fiveMinutes: TimeInterval = 300
        return currentDate.addingTimeInterval(fiveMinutes) >= expirationDate
    }

    
    private init() {}
    
    struct Constants {
        static let tokenAPIURL = "https://api.petfinder.com/v2/oauth2/token"

    }
    
    private func getKeys() -> NSDictionary {
        var keys: NSDictionary?
        guard let path = Bundle.main.path(forResource: "Keys", ofType: "plist") else {
            return NSDictionary()
        }
        keys = NSDictionary(contentsOfFile: path)
        return keys!
    }
    
    public func exchangeCodeForToken(completion: @escaping (Bool) -> Void) {
        // Get token
        
        guard let url = URL(string: Constants.tokenAPIURL) else {
            return
        }
        //getKeys().value(forKey: "clientID") as? String)
        var components = URLComponents()
        components.queryItems = [
        URLQueryItem(name: "grant_type", value: "client_credentials"),
        URLQueryItem(name: "client_id", value: getKeys().value(forKey: "clientID") as? String),
        URLQueryItem(name: "client_secret", value: getKeys().value(forKey: "clientSecret") as? String),
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = components.query?.data(using: .utf8)
        
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                self?.cacheToken(result: result)
                completion(true)
            }
            catch {
                print(error)
                completion(false)
            }
        }
        task.resume()
        
    }

    public func withValidToken(completion: @escaping (String) -> Void) {
        if let token = accessToken {
            print(token)
            completion(token)
        }
    }
    
    private func cacheToken(result: AuthResponse) {
        UserDefaults.standard.setValue(result.access_token, forKey: "access_token")
        UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(result.expires_in)), forKey: "expirationDate")
        
    }


}
