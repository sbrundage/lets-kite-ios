//
//  DayOutlookTableViewCell.swift
//  LetsKite
//
//  Created by Stephen Brundage on 9/6/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import UIKit
import SwiftUI

class DayOutlookTableViewCell: UITableViewCell {
    
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var borderView: UIView!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var dayTempLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
	@IBOutlet weak var windGraphView: UIView!
	
	static let identifier = "DayOutlookTableViewCell"
	static let nib = UINib(nibName: identifier, bundle: nil)
    
    var dayOutlookModel: DayOutlookModel? {
        didSet {
            setupCell()
        }
    }
	
	var hourlyWindForecast: [WeatherOutlook]? {
		didSet {
			computeWindData()
		}
	}

    override func awakeFromNib() {
        super.awakeFromNib()

		setupCell()
    }
    
    private func setupCell() {
		guard let outlookModel = dayOutlookModel else { return }
		
		borderView.layer.cornerRadius = 15
		weatherImage.image = UIImage(systemName: outlookModel.weatherSystemImageString)
		dayTempLabel.text = String(format: "%.0f", outlookModel.temp_day)
		highTempLabel.text = String(format: "%.0f", outlookModel.temp_max) + " °"
		lowTempLabel.text = String(format: "%.0f", outlookModel.temp_min) + " °"
		dateLabel.text = outlookModel.dt.toDateStringFrom1970()
    }
	
	private func addSwiftUIView(windData: [WeatherOutlook]) {
		let hourlyWind = windData.isEmpty ? HourlyWind.getHourlyWindArrayZero() : HourlyWind.getHourlyWindArray()
		let barGraphView = BarGraph(hourlyWindForecast: hourlyWind)
		let hostingController = UIHostingController(rootView: barGraphView)
		hostingController.view.backgroundColor = .clear
		
		windGraphView.addSubview(hostingController.view)
		
		hostingController.view.translatesAutoresizingMaskIntoConstraints = false
		let constraints = [
			hostingController.view.topAnchor.constraint(equalTo: windGraphView.topAnchor),
			hostingController.view.leftAnchor.constraint(equalTo: windGraphView.leftAnchor),
			windGraphView.bottomAnchor.constraint(equalTo: hostingController.view.bottomAnchor),
			windGraphView.rightAnchor.constraint(equalTo: hostingController.view.rightAnchor)
		]
		NSLayoutConstraint.activate(constraints)
	}
	
	private func computeWindData() {
		guard let hourlyWeatherData = hourlyWindForecast else { return }
		
		// Here we want to run through the array of wind data we have, and filter out any hours of the data we don't want to show
		// One thing to note, we may not have the full day of data here due to the restrictions of the api call
		
		// We only want to display wind data for every 2 hours?
		let windHourSet: Set<String> = ["07:00", "09:00", "11:00", "13:00", "15:00", "17:00", "19:00"]
		var windDataArray: [WeatherOutlook] = []
		for windData in hourlyWeatherData {
			let hourString = windData.dt.toTimeOfDayString()
			windHourSet.contains(hourString) ? windDataArray.append(windData) : nil
		}
		addSwiftUIView(windData: windDataArray)
		// If we don't have full day of wind data, maybe we want to show everything we have (every hour)
	}
	
	func stubbedHourlyWindView() {
		addSwiftUIView(windData: [])
	}
	
	override func prepareForReuse() {
		dayOutlookModel = nil
		dayTempLabel.text = ""
		highTempLabel.text = ""
		lowTempLabel.text = ""
		
		for view in windGraphView.subviews {
			view.removeFromSuperview()
		}
	}
}
