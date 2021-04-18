//
//  File.swift
//  LetsKite
//
//  Created by Stephen Brundage on 3/28/21.
//  Copyright © 2021 Stephen Brundage. All rights reserved.
//

import Foundation
import UIKit

struct HourlyWind: Hashable {
	let windSpeed: Int
	let time: Int
	let color: UIColor = .systemOrange
}

extension HourlyWind {
	static func getHourlyWindArray() -> [HourlyWind] {
		[
			HourlyWind(windSpeed: 12, time: 7),
			HourlyWind(windSpeed: 13, time: 9),
			HourlyWind(windSpeed: 16, time: 11),
			HourlyWind(windSpeed: 17, time: 13),
			HourlyWind(windSpeed: 7, time: 15),
			HourlyWind(windSpeed: 30, time: 17),
			HourlyWind(windSpeed: 35, time: 19)
		]
	}
	
	static func getHourlyWindArrayZero() -> [HourlyWind] {
		[
			HourlyWind(windSpeed: 0, time: 7),
			HourlyWind(windSpeed: 0, time: 9),
			HourlyWind(windSpeed: 0, time: 11),
			HourlyWind(windSpeed: 0, time: 13),
			HourlyWind(windSpeed: 0, time: 15),
			HourlyWind(windSpeed: 0, time: 17),
			HourlyWind(windSpeed: 0, time: 19)
		]
	}
}
