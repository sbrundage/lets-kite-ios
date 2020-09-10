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
    var parameters: [String: String]? { get }
}

extension ApiResource {
    var baseURL: String {
        return WeatherEndpoint.openWeatherMapAll.rawValue
    }
    
    func createURLRequest() -> URLRequest? {
        guard let url = URL(string: baseURL) else { return nil }
        
        guard var components = URLComponents(string: baseURL) else { return nil }
        
        if let parameters = parameters {
            components.queryItems = parameters.map { parameter in URLQueryItem(name: parameter.key, value: parameter.value) }
        }
        
        var request = URLRequest(url: components.url?.absoluteURL ?? url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = self.method.rawValue
        
        return request
    }
}
