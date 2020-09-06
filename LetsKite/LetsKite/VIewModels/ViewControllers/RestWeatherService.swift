//
//  RestWeatherService.swift
//  LetsKite
//
//  Created by Stephen Brundage on 8/29/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import Foundation

class RestWeatherService: WeatherRequest {
    func openWeatherMapOneCall(with requestModel: OpenWeatherAllWeatherRequest, completion: @escaping WebServiceResult<OpenWeatherAllWeatherRequest.ModelType>) {
        guard let urlRequest = requestModel.createURLRequest() else {
            completion(.failure(.moreInfo("Failed to create URL request for open weather map one call")))
            return
        }
        
        performRequestForDecodable(urlRequest) { (result) in
            completion(result)
        }
    }
    
}
