//
//  RestWeatherService.swift
//  LetsKite
//
//  Created by Stephen Brundage on 8/29/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import Foundation

class RestWeatherService: WeatherRequest {
	
	func performRequest<RequestModel: ApiResource>(with requestModel: RequestModel, completion: @escaping WebServiceResult<RequestModel.ModelType>) {

		guard let urlRequest = requestModel.createURLRequest() else { return }

		performRequestForDecodable(urlRequest) { (result) in
			completion(result)
		}
	}
}
