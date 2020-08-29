//
//  ApiResourceProtocol.swift
//  LetsKite
//
//  Created by Stephen Brundage on 8/29/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import Foundation

protocol ApiResource {
    associatedtype ModelType: Decodable
    
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
}

extension ApiResource {
    var baseURL: String {
        return WeatherEndpoint.openWeatherMapAll.rawValue
    }
    
    func createURLRequest() -> URLRequest? {
        guard let url = URL(string: baseURL) else { return nil }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = self.method.rawValue
        
        guard let requestBody = parameters else { return request }
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: .prettyPrinted)
        } catch let error {
            print("Error creating URL Request: \(error.localizedDescription)")
            return nil
        }
        return request
    }
}
