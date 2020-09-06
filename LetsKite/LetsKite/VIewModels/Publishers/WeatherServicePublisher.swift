//
//  WeatherServicePublisher.swift
//  LetsKite
//
//  Created by Stephen Brundage on 9/6/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import Foundation

class WeatherServicePublisher {
    
    private var weatherService = RestWeatherService()
    var observers: [Observer] = []
    
    func fetchAllWeatherForecast(_ lat: String, _ lon: String) {
        
        let lat = "33.441792"
        let lon = "-94.037689"
        
        let weatherRequest =
            OpenWeatherAllWeatherRequest(
                lat: lat,
                lon: lon,
                apiKey: APIKey.openWeatherMap.rawValue,
                units: .imperial,
                exclude: .minutely
            )
        
        weatherService.openWeatherMapOneCall(with: weatherRequest) { (result) in
            switch result {
            case .success(let responseModel):
                print("Success: \(responseModel)")
                self.notifyAll(with: responseModel)
            case .failure(let error):
                print("Error fetching all weather: \(error)")
            }
        }
    }
}

extension WeatherServicePublisher: ObservableSubject {
    func addObserver(_ observer: Observer) {
        observers.append(observer)
    }
    
    func removeObserver(_ observer: Observer) {
        observers = observers.filter { $0.id != observer.id }
    }
    
    func notifyAll<T>(with newValue: T) {
        for observer in observers {
            observer.update(with: newValue)
        }
    }
}
