//
//  DayView.swift
//  LetsKite
//
//  Created by Stephen Brundage on 3/21/21.
//  Copyright © 2021 Stephen Brundage. All rights reserved.
//

import SwiftUI

struct DayView: View {
	
	let dayOutlookModel: DayOutlookModel
	
	init(dayOutlookModel: DayOutlookModel) {
		self.dayOutlookModel = dayOutlookModel
	}
	
    var body: some View {
		DailyInfoView(model: dayOutlookModel)
			.padding()
			.background(Color.white.opacity(0.0))
			.foregroundColor(.white)
	}
}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
		Group {
			DayView(dayOutlookModel: DayOutlookModel.stubbedModel())
		}
	}
}

struct DailyInfoView: View {
	
	var model: DayOutlookModel
	
	var body: some View {
		VStack {
			Text(model.dateString)
				.font(.headline)
			HStack {
				Image(systemName: "sun.max.fill")
					.resizable()
					.scaledToFit()
					.frame(width: 70, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
				HStack {
					Text("\(model.temp_day, specifier: "%.0f")")
						.font(.system(size: 40)).fontWeight(.semibold)
						.offset(x: 5)
						.lineLimit(1)
					Text("°")
						.font(.system(size: 28))
						.frame(height: 20, alignment: .bottomTrailing)
					Text("F")
						.font(.headline)
				}
				.offset(x: 15)
				.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
				VStack(alignment: .trailing) {
					Text("High:   \(model.temp_max, specifier: "%.0f")° F")
					Text("Low:    \(model.temp_min, specifier: "%.0f")° F")
				}
				.padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 0))
			}
			.padding(EdgeInsets(top: 0, leading: 30, bottom: 20, trailing: 30))
			// Insert Bar Chart
			BarGraph(hourlyWindForecast: HourlyWind.getHourlyWindArray())
		}
		.padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
		.background(Color.gray.opacity(0.8))
		.mask(RoundedRectangle(cornerRadius: 25))
	}
}
