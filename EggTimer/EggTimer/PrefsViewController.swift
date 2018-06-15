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
    var prefs = Preferences()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showExistingPrefs()
    }
    @IBAction func popupValueChanged(sender: NSPopUpButton) {
        if sender.selectedItem?.title == "Custom" {
            customSlider.enabled = true
            return
        }
        
        let newTimerDuration = sender.selectedTag()
        customSlider.integerValue = newTimerDuration
        showSliderValueAsText()
        customSlider.enabled = false
    }
    @IBAction func sliderValueChanged(sender: NSSlider) {
        showSliderValueAsText()
    }
    @IBAction func cancelButtonClicked(sender: AnyObject) {
        view.window?.close()
    }
    @IBAction func okButtonClicked(sender: AnyObject) {
        saveNewPrefs()
        view.window?.close()
    }
    
    func showExistingPrefs() {
        // 1
        let selectedTimeInMinutes = Int(prefs.selectedTime) / 60
        
        // 2
        presetsPopup.selectItemWithTitle("Custom")
        customSlider.enabled = true
        
        // 3
        for item in presetsPopup.itemArray {
            if item.tag == selectedTimeInMinutes {
                presetsPopup.selectItem(item)
                customSlider.enabled = false
                break
            }
        }
        
        // 4
        customSlider.integerValue = selectedTimeInMinutes
        showSliderValueAsText()
    }
    
    // 5
    func showSliderValueAsText() {
        let newTimerDuration = customSlider.integerValue
        let minutesDescription = (newTimerDuration == 1) ? "minute" : "minutes"
        customTextField.stringValue = "\(newTimerDuration) \(minutesDescription)"
    }
    
    func saveNewPrefs() {
        prefs.selectedTime = customSlider.doubleValue * 60
        NSNotificationCenter.defaultCenter().postNotification(NSNotification.init(name: "PrefsChanged", object: nil))
    }
    
}
