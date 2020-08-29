//
//  WeatherRequest.swift
//  LetsKite
//
//  Created by Stephen Brundage on 8/26/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import Foundation

typealias WebServiceResult<ResponseModel: Decodable> = ((Result<ResponseModel, WebServiceError>) -> Void)

class WeatherRequest: WeatherRequestProtocol {
    
    func performRequestForDecodable<ResponseModel>(_ urlRequest: URLRequest, completion: @escaping WebServiceResult<ResponseModel>) {
        
        // Create Data Task Request
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            // Check for Errors
            guard error != nil else {
                completion(.failure(.unknown(error!)))
                return
            }
            
            // Make sure we have response data to decode
            guard let responseData = data else {
                guard let url = urlRequest.url else {
                    completion(.failure(.moreInfo("No URL present in request")))
                    return
                }
                completion(.failure(.invalidPayload(url)))
                return
            }
            
            // Attempt to decode response data into ResponseModel
            do {
                let responseModel = try JSONDecoder().decode(ResponseModel.self, from: responseData)
                completion(.success(responseModel))
                return
            } catch let error {
                completion(.failure(.decodingError(error)))
                return
            }
        }
        dataTask.resume()
    }
}
