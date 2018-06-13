//
//  ViewController.swift
//  EggTimer
//
//  Created by Justin Athill on 6/12/18.
//  Copyright © 2018 Justin_Athill. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var timeleftField: NSTextField!
    @IBOutlet weak var eggImageView: NSImageView!
    @IBOutlet weak var startButton: NSButton!
    @IBOutlet weak var stopButton: NSButton!
    @IBOutlet weak var resetButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func startButtonClicked(sender: AnyObject) {
    }
    @IBAction func stopButtonClicked(sender: AnyObject) {
    }
    @IBAction func resetButtonClicked(sender: AnyObject) {
    }
    
    @IBAction func startTimerMenuItemSelected(sender: AnyObject) {
        startButtonClicked(sender)
    }
    @IBAction func stopTimerMenuItemSelected(sender: AnyObject) {
        stopButtonClicked(sender)
    }
    @IBAction func resetTimerMenuItemSelected(sender: AnyObject) {
        resetButtonClicked(sender)
    }
    

}

