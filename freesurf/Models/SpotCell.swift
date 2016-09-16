//
//  SpotCell.swift
//  thewaves
//
//  Created by Sahand Nayebaziz on 1/30/15.
//  Copyright (c) 2014 Sahand Nayebaziz. All rights reserved.
//

import UIKit
import QuartzCore

protocol SpotDataDelegate {
    func didUpdate(forSpot spot: SpotData, county: CountyData)
}

class SpotCell: UITableViewCell, SpotDataDelegate {
    
    var representedSpot: SpotData? = nil

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var tempAndSwellLabel: UILabel!
    var gradient:CAGradientLayer = CAGradientLayer()
    
    func set(forSpot spot: SpotData) {
        representedSpot = spot
    }
    
    func didUpdate(forSpot spot: SpotData, county: CountyData) {
        guard representedSpot != nil else {
            return
        }
        
        guard spot.id == representedSpot!.id else {
            NSLog("saw update for spot that's not for this cell")
            return
        }
        
        NSLog("saw update for spot that is for this cell")
        
        dispatch_to_main_queue {
            self.clipsToBounds = true
            self.backgroundColor = UIColor.clear
            
            self.nameLabel.text = spot.name
            self.tempAndSwellLabel.text = county.temperatureAndSwellSummary
            self.gradient.colors = spot.gradientColorsForHeight
            
            self.gradient.frame = self.bounds
            self.layer.insertSublayer(self.gradient, at: 0)
        }
    }
}
