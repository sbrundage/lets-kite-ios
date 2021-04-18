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
	
	var dateString: String { dt.toDateStringFrom1970() }
	var weatherSystemImageString: String {
		switch self.weather_main {
			case "Clear":
				return "sun.max.fill"
			case "Clouds":
				return "cloud.fill"
			case "Rain":
				return "cloud.rain.fill"
			default:
				return "sun.max.fill"
		}
	}
    
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

extension DayOutlookModel {
	static func stubbedModel() -> DayOutlookModel {
		let dailyOutlookModel = DailyOutlookModel(
			dt: 1595268000,
			sunrise: 1608124431,
			sunset: 1608160224,
			temp: Temp(
				day: 70,
				min: 60,
				max: 90,
				night: 65,
				eve: 68,
				morn: 65
			),
			feels_like: FeelsModel(
				day: 70,
				night: 65,
				eve: 68,
				morn: 65),
			pressure: 1021,
			humidity: 70,
			dew_point: 5,
			wind_speed: 12,
			wind_deg: 56,
			weather: [],
			clouds: 2,
			pop: 5,
			uvi: 6)
		return DayOutlookModel(dailyOutlookModel: dailyOutlookModel)
	}
}
