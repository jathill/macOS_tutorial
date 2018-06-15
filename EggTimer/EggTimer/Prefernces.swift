//
//  Prefernces.swift
//  EggTimer
//
//  Created by Justin Athill on 6/15/18.
//  Copyright © 2018 Justin_Athill. All rights reserved.
//

import Foundation

struct Preferences {
    
    // 1
    var selectedTime: NSTimeInterval {
        get {
            // 2
            let savedTime = NSUserDefaults.standardUserDefaults().doubleForKey("selectedTime")
            if savedTime > 0 {
                return savedTime
            }
            // 3
            return 360
        }
        set {
            // 4
            NSUserDefaults.standardUserDefaults().setDouble(newValue, forKey: "selectedTime")
        }
    }
    
}