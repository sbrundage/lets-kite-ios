//
//  WebServiceError.swift
//  LetsKite
//
//  Created by Stephen Brundage on 8/26/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import Foundation

enum WebServiceError: Error {
    case invalidURL(String)
    case invalidPayload(URL)
    case decodingError(Error)
    case unknown(Error)
    case moreInfo(String)
}
