//
//  OpenWeatherAllWeatherRequest.swift
//  LetsKite
//
//  Created by Stephen Brundage on 8/29/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import Foundation

struct OpenWeatherAllWeatherRequest: ApiResource {
    typealias ModelType = OpenWeatherAllWeatherResponse
    
    var method: HTTPMethod = .get
    var parameters: [String : Any]?
    
    init(lat: String, lon: String, apiKey: String, units: OpenWeatherMapUnits, exclude: ForecastIncrement) {
        parameters = [
            "lat": lat,
            "lon": lon,
            "exclude": exclude,
            "appid": apiKey
        ]
    }
}
