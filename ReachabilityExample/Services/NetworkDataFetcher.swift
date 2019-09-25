//
//  NetworkDataFetcher.swift
//  ReachabilityExample
//
//  Created by Станислав Шияновский on 9/25/19.
//  Copyright © 2019 Станислав Шияновский. All rights reserved.
//

import Foundation

public protocol DataFetcher {
    func getUser(response: @escaping (UserResponse?) -> Void)
}

public class NetworkDataFetcher: DataFetcher {
    
    private var networking: Networking
    
    public init(networking: Networking = NetworkService()) {
        self.networking = networking
    }
    
    public func getUser(response: @escaping (UserResponse?) -> Void) {
        networking.request(path: API.user, params: [:]) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
            
            let decoded = self.decodeJSON(type: UserResponse.self, from: data)
            response(decoded)
        }
    }
    
    public func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }
}
