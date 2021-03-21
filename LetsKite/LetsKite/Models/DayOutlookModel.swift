//
//  DayOutlookModel.swift
//  LetsKite
//
//  Created by Stephen Brundage on 9/6/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import Foundation

struct DayOutlookModel {
	let dt: Int
    let sunrise: Int
    let sunset: Int
    let temp_day: Float
    let temp_min: Float
    let temp_max: Float
    let humidity: Int
    let wind_speed: Float
    let weather_main: String?
    let weather_description: String?
    let clouds: Int
    
    init(dailyOutlookModel: DailyOutlookModel) {
		self.dt = dailyOutlookModel.dt
        self.sunrise = dailyOutlookModel.sunrise
        self.sunset = dailyOutlookModel.sunset
        self.temp_day = dailyOutlookModel.temp.day
        self.temp_min = dailyOutlookModel.temp.min
        self.temp_max = dailyOutlookModel.temp.max
        self.humidity = dailyOutlookModel.humidity
        self.wind_speed = dailyOutlookModel.wind_speed
        self.weather_main = dailyOutlookModel.weather.first?.main
        self.weather_description = dailyOutlookModel.weather.first?.description
        self.clouds = dailyOutlookModel.clouds
    }
}
