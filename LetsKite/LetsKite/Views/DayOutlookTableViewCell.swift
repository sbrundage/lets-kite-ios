//
//  DayOutlookTableViewCell.swift
//  LetsKite
//
//  Created by Stephen Brundage on 9/6/20.
//  Copyright © 2020 Stephen Brundage. All rights reserved.
//

import UIKit

class DayOutlookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var dayTempLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    
    var dayOutlookModel: DayOutlookModel? {
        didSet {
            setupCell()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
//        dayWindOutlookView.contentMode = .scaleAspectFit
    }
    
    private func setupCell() {
        borderView.layer.cornerRadius = 15
        
        guard let dayTemp = dayOutlookModel?.temp_day,
            let minTemp = dayOutlookModel?.temp_min,
            let maxTemp = dayOutlookModel?.temp_max else { return }
        dayTempLabel.text = String(format: "%.0f", dayTemp)
        highTempLabel.text = String(format: "%.0f", maxTemp) + " °"
        lowTempLabel.text = String(format: "%.0f", minTemp) + " °"
    }
    
    override func prepareForReuse() {
        dayOutlookModel = nil
        dayTempLabel.text = ""
        highTempLabel.text = ""
        lowTempLabel.text = ""
        DispatchQueue.main.async {
            self.layoutIfNeeded()
        }
    }
}
