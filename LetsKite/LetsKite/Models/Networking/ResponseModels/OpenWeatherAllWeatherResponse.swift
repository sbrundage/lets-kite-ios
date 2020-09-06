//
//  OpenWeatherAllWeatherResponse.swift
//  LetsKite
//
//  Created by Stephen Brundage on 8/29/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import Foundation

struct OpenWeatherAllWeatherResponse: Decodable {
    let lat: Double
    let lon: Double
    let timezone: String
    let timezone_offset: Int
    let current: WeatherOutlookResponseModel
    let hourly: [WeatherOutlookResponseModel]
    let daily: [DailyOutlookModel]
}

struct WeatherOutlookResponseModel: Codable {
    let dt: Int
    let sunrise: Int?
    let sunset: Int?
    let temp: Float
    let feels_like: Float
    let pressure: Int
    let humidity: Int
    let clouds: Int
    let visibility: Int
    let wind_speed: Float
    let wind_deg: Int
    let weather: [WeatherResponseModel]
}

struct WeatherResponseModel: Codable {
    let id: Int
    let main: String
    let description: String
}

struct DailyOutlookModel: Codable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let temp: Temp
    let feels_like: FeelsModel
    let pressure: Int
    let humidity: Int
    let dew_point: Float
    let wind_speed: Float
    let wind_deg: Int
    let weather: [WeatherResponseModel]
    let clouds: Int
    let pop: Float
    let uvi: Float
}

struct Temp: Codable {
    let day: Float
    let min: Float
    let max: Float
    let night: Float
    let eve: Float
    let morn: Float
}

struct FeelsModel: Codable {
    let day: Float
    let night: Float
    let eve: Float
    let morn: Float
}
