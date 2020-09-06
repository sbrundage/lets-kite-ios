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
    
    private let wind = Array<Int>()
    private var dayOutlookArray: [DailyOutlookModel] = [] {
        didSet {
            reloadData()
        }
    }
    
    var weatherServicePublisher: WeatherServicePublisher!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherServicePublisher.addObserver(self)
        setupTableView()
    }
    
    private func setupTableView() {
        windOutlookTableView.delegate = self
        windOutlookTableView.dataSource = self
        windOutlookTableView.register(UINib(nibName: "DayOutlookTableViewCell", bundle: nil), forCellReuseIdentifier: "DayOutlookCell")
        windOutlookTableView.backgroundColor = .black
    }
    
    private func reloadData() {
        DispatchQueue.main.async {
            // Reload table view
        }
    }
}

extension WindOutlookViewController: UITableViewDelegate {}

extension WindOutlookViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = windOutlookTableView.dequeueReusableCell(withIdentifier: "DayOutlookCell", for: indexPath) as! DayOutlookTableViewCell
        
//        cell.dayOutlookModel = dayOutlookArray[indexPath.row]
//        cell.dayWindOutlookView.createWindBars(windSpeeds: wind)
        
        return cell
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
        if let dayOutlookArray = newValue as? [DailyOutlookModel] {
            self.dayOutlookArray = dayOutlookArray
        }
    }
}
