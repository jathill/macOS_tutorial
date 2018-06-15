//
//  PrefsViewController.swift
//  EggTimer
//
//  Created by Justin Athill on 6/13/18.
//  Copyright © 2018 Justin_Athill. All rights reserved.
//

import Cocoa

class PrefsViewController: NSViewController {

    @IBOutlet weak var presetsPopup: NSPopUpButton!
    @IBOutlet weak var customSlider: NSSlider!
    @IBOutlet weak var customTextField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    @IBAction func popupValueChanged(sender: NSPopUpButton) {
    }
    @IBAction func sliderValueChanged(sender: NSSlider) {
    }
    @IBAction func cancelButtonClicked(sender: AnyObject) {
    }
    @IBAction func okButtonClicked(sender: AnyObject) {
    }
    
    
}
