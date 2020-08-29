//
//  WeatherRequestProtocol.swift
//  LetsKite
//
//  Created by Stephen Brundage on 8/26/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import Foundation

protocol WeatherRequestProtocol {
    func performRequestForDecodable<ResponseModel: Decodable>(_ urlRequest: URLRequest, completion: @escaping WebServiceResult<ResponseModel>)
}
