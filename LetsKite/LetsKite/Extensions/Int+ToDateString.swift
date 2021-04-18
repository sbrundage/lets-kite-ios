//
//  Int+ToDateString.swift
//  LetsKite
//
//  Created by Stephen Brundage on 3/21/21.
//  Copyright © 2021 Stephen Brundage. All rights reserved.
//

import Foundation

extension Int {
	func toDateStringFrom1970() -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "E, MMM dd"
		let date = Date(timeIntervalSince1970: TimeInterval(self))
		return dateFormatter.string(from: date)
	}
	
	func toDateFrom1970() -> Date {
		Date(timeIntervalSince1970: TimeInterval(self))
	}
	
	func toTimeOfDayString() -> String {
		let hourFormatter = DateFormatter()
		hourFormatter.dateFormat = "HH:mm"
		let date = Date(timeIntervalSince1970: TimeInterval(self))
		return hourFormatter.string(from: date)
	}
}
