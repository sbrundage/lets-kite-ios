//
//  WeatherEndpoints.swift
//  LetsKite
//
//  Created by Stephen Brundage on 8/26/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import Foundation

enum WeatherEndpoint: String {
    case openWeatherMapAll = "https://api.openweathermap.org/data/2.5/onecall"
}

enum HTTPMethod: String {
    case get = "GET"
}

enum OpenWeatherMapUnits: String {
    case metric = "metric" // Celcius
    case imperial = "imperial" // Fahrenheit
    case none = "default" // Kelvin
}

// Weather Increments that can be returned
enum ForecastIncrement: String {
    case current = "current"
    case minutely = "minutely"
    case hourly = "hourly"
    case daily = "daily"
}
