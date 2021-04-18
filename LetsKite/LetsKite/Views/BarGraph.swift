//
//  BarGraph.swift
//  LetsKite
//
//  Created by Stephen Brundage on 3/28/21.
//  Copyright © 2021 Stephen Brundage. All rights reserved.
//

import Foundation
import SwiftUI

struct BarGraph: View {

	var hourlyWindForecast: [HourlyWind]
	var maxWindSpeed: CGFloat = 50
	var barCornerRadius: CGFloat = 12
	var barWidth: CGFloat = 30
	var barGraphHeight: CGFloat = 200
	var barGraphWidth: CGFloat = 300
	
	var body: some View {
		
		VStack {
			HStack {
				Text("Wind Outlook")
					.font(.title).fontWeight(.semibold)
				Spacer()
				Image(systemName: "wind")
					.resizable()
					.frame(width: 25, height: 25)
			}
			.padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
			VStack {
				HStack(alignment: .bottom) {
					ForEach(hourlyWindForecast, id: \.time) { hourlyWind in
						BarView(hourlyWind: hourlyWind, maxWindSpeed: maxWindSpeed, superViewHeight: barGraphHeight, barWidth: barWidth, cornerRadius: barCornerRadius)
						// Insert spacing between the bars
						.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5))
					}
				}
			}
		}
		.frame(width: barGraphWidth, height: barGraphHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
		.padding()
	}
}

struct BarView: View {
	
	@State private var showGraph: Bool = true
	
	let hourlyWind: HourlyWind
	let maxWindSpeed: CGFloat
	let superViewHeight: CGFloat
	let barWidth: CGFloat
	let cornerRadius: CGFloat
	
	var barHeight: CGFloat {
		(CGFloat(hourlyWind.windSpeed) / maxWindSpeed) * superViewHeight
	}
	
	var body: some View {
		
		return VStack {
			Spacer()
			Text("\(hourlyWind.windSpeed)")
			RoundedRectangle(cornerRadius: cornerRadius)
				.fill(Color(hourlyWind.color))
				.frame(width: barWidth, height: self.showGraph ? barHeight : 0.0)
				.onAppear {
					// Animation needs improving
//					withAnimation(.easeOut(duration: 1.5)) {
//						self.showGraph = true
//					}
				}
			Text("\(hourlyWind.time)")
				.fontWeight(.semibold)
		}
	}
}

struct BarGraph_Previews: PreviewProvider {
	
	static var previews: some View {
		BarGraph(hourlyWindForecast: HourlyWind.getHourlyWindArray())
			.previewLayout(.fixed(width: 400, height: 300))
	}
}
