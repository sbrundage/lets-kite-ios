//
//  Observer.swift
//  LetsKite
//
//  Created by Stephen Brundage on 9/6/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import Foundation

protocol Observer {
    var id: String { get }
    
    func update<T>(with newValue: T)
}
