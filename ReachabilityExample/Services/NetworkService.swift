//
//  NetworkService.swift
//  ReachabilityExample
//
//  Created by Станислав Шияновский on 9/25/19.
//  Copyright © 2019 Станислав Шияновский. All rights reserved.
//

import Foundation

public protocol Networking {
    func request(path: String, params: [String: String], completion: @escaping (Data?, Error?) -> ())
}

public class NetworkService: NSObject, Networking {
    
    public override init() {
        super.init()
    }
    
    // построение запроса данных по URL
    public func request(path: String, params: [String : String], completion: @escaping (Data?, Error?) -> Void) {
        let url = self.url(from: path, params: params)
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
        print(url)
    }
    
    private func createDataTask(from requst: URLRequest, completion: @escaping (Data?, Error?) -> ()) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: requst, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        })
    }
    
    private func url(from path: String, params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = path
        components.queryItems = params.map {  URLQueryItem(name: $0, value: $1) }
        return components.url!
    }
}
