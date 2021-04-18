//
//  WindOutlookViewController.swift
//  LetsKite
//
//  Created by Stephen Brundage on 9/6/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import UIKit

class WindOutlookViewController: UIViewController {
    
    @IBOutlet weak var windOutlookTableView: UITableView!
	
	static let storyboardID = "WindOutlookViewController"
    
    private let wind = Array<Int>()
    private var dayOutlookArray: [DailyOutlookModel] = [] {
        didSet {
            reloadData()
        }
    }
	
	var hourlyForecastDict: [String: [WeatherOutlook]] = [:]
    
    var weatherServicePublisher = WeatherServicePublisher()
	let lat: String = "33.441792"
	let lon: String = "-94.037689"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
		weatherServicePublisher.addObserver(self)
		weatherServicePublisher.fetchAllWeatherForecast(lat, lon)
        setupTableView()
    }
    
    private func setupTableView() {
        windOutlookTableView.delegate = self
        windOutlookTableView.dataSource = self
		windOutlookTableView.register(DayOutlookTableViewCell.nib, forCellReuseIdentifier: DayOutlookTableViewCell.identifier)
		windOutlookTableView.register(HostingCell<DayView>.self, forCellReuseIdentifier: "HostingCell<DayView>")
		windOutlookTableView.backgroundColor = .black
    }
    
    private func reloadData() {
        DispatchQueue.main.async {
			self.windOutlookTableView.reloadData()
        }
    }
	
	private func handleHourlyForecastResponse(_ hourlyForecast: [WeatherOutlook]) {
		var hourlyForecastDict: [String: [WeatherOutlook]] = [:]
		
		for forecast in hourlyForecast {
			let dateKey = forecast.dt.toDateStringFrom1970()
			hourlyForecastDict.keys.contains(dateKey) ?
				hourlyForecastDict[dateKey]?.append(forecast) : (hourlyForecastDict[dateKey] = [forecast])
		}
		// At this point we will have a dictionary of wind outlook forecast arrays
		// ["April 6, 2021": [forecast]]
		self.hourlyForecastDict = hourlyForecastDict
	}
}

extension WindOutlookViewController: UITableViewDelegate {}

extension WindOutlookViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dayOutlookArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		let dailyOutlookModel = DayOutlookModel(dailyOutlookModel: dayOutlookArray[indexPath.row])
		let dateString = dailyOutlookModel.dt.toDateStringFrom1970()
		// Check dictionary for the date string
		// If present, then we pass in the wind data
		let hourlyWindData = hourlyForecastDict[dateString]
		let cell = windOutlookTableView.dequeueReusableCell(withIdentifier: DayOutlookTableViewCell.identifier, for: indexPath) as! DayOutlookTableViewCell

        cell.dayOutlookModel = dailyOutlookModel
		hourlyWindData != nil ? cell.hourlyWindForecast = hourlyWindData : cell.stubbedHourlyWindView()
        return cell
		
		// For using SwiftUI
		//		let cell = windOutlookTableView.dequeueReusableCell(withIdentifier: "HostingCell<DayView>", for: indexPath) as! HostingCell<DayView>
		//		cell.set(rootView: DayView(dayOutlookModel: dailyOutlookModel), parentController: self)
		//		return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0.05 * Double(indexPath.row),
            animations: {
                cell.alpha = 1
            }
        )
    }
}

extension WindOutlookViewController: Observer {
    var id: String {
        return "WindOutlookViewController"
    }
    
    func update<T>(with newValue: T) {
        if let weatherResponse = newValue as? OpenWeatherAllWeatherResponse {
			// We get back two days worth of hourly forecasts
			// Create a DS to hold both of these days
			handleHourlyForecastResponse(weatherResponse.hourly)
			self.dayOutlookArray = weatherResponse.daily
		}
    }
}
