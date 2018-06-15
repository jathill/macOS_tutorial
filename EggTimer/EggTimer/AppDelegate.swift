//
//  AppDelegate.swift
//  EggTimer
//
//  Created by Justin Athill on 6/12/18.
//  Copyright © 2018 Justin_Athill. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var startTimerMenuItem: NSMenuItem!
    @IBOutlet weak var stopTimerMenuItem: NSMenuItem!
    @IBOutlet weak var resetTimerMenuItem: NSMenuItem!


    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        enableMenus(true, stop: false, reset: false)
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    func enableMenus(start: Bool, stop: Bool, reset: Bool) {
        startTimerMenuItem.enabled = start
        stopTimerMenuItem.enabled = stop
        resetTimerMenuItem.enabled = reset
    }

}

