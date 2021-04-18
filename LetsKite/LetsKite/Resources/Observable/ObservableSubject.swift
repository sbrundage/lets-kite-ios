//
//  ObservableSubject.swift
//  LetsKite
//
//  Created by Stephen Brundage on 9/6/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import Foundation

protocol ObservableSubject {
    var observers: [Observer] { get }
    
    func addObserver(_ observer: Observer)
    func removeObserver(_ observer: Observer)
    func notifyAll<T>(with newValue: T)
}

