//
//  ViewController.swift
//  EggTimer
//
//  Created by Justin Athill on 6/12/18.
//  Copyright © 2018 Justin_Athill. All rights reserved.
//

import Cocoa
import AVFoundation

class ViewController: NSViewController {

    @IBOutlet weak var timeleftField: NSTextField!
    @IBOutlet weak var eggImageView: NSImageView!
    @IBOutlet weak var startButton: NSButton!
    @IBOutlet weak var stopButton: NSButton!
    @IBOutlet weak var resetButton: NSButton!
    var eggTimer = EggTimer()
    var prefs = Preferences()
    var soundPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        eggTimer.delegate = self
        setupPrefs()
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func startButtonClicked(sender: AnyObject) {
        if eggTimer.isPaused {
            eggTimer.resumeTimer()
        } else {
            eggTimer.duration = prefs.selectedTime
            eggTimer.startTimer()
        }
        configureButtonsAndMenus()
        prepareSound()
    }
    @IBAction func stopButtonClicked(sender: AnyObject) {
        eggTimer.stopTimer()
        configureButtonsAndMenus()
    }
    @IBAction func resetButtonClicked(sender: AnyObject) {
        eggTimer.resetTimer()
        updateDisplay(for: prefs.selectedTime)
        configureButtonsAndMenus()
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

extension ViewController: EggTimerProtocol {
    func timeRemainingOnTimer(timer: EggTimer, timeRemaining: NSTimeInterval) {
        updateDisplay(for: timeRemaining)
    }
    func timerHasFinished(timer: EggTimer) {
        updateDisplay(for: 0)
        playSound()
    }
}

extension ViewController {
    
    // MARK - Display
    
    func updateDisplay(for timeRemaining: NSTimeInterval) {
        timeleftField.stringValue = textToDisplay(for: timeRemaining)
        eggImageView.image = imageToDisplay(for: timeRemaining)
    }
    
    private func textToDisplay(for timeRemaining: NSTimeInterval) -> String {
        if timeRemaining == 0 {
            return "Done!"
        }
        
        let minutesRemaining = floor(timeRemaining / 60)
        let secondsRemaining = timeRemaining - (minutesRemaining * 60)
        
        let secondsDisplay = String(format: "%02d", Int(secondsRemaining))
        let timeRemainingDisplay = "\(Int(minutesRemaining)):\(secondsDisplay)"
        
        return timeRemainingDisplay
    }
    
    private func imageToDisplay(for timeRemaining: NSTimeInterval) -> NSImage? {
        let percentageComplete = 100 - (timeRemaining / prefs.selectedTime * 100)
        
        if eggTimer.isStopped {
            let stoppedImageName = (timeRemaining == 0) ? "100" : "stopped"
            return NSImage(named: stoppedImageName)
        }
        
        let imageName: String
        switch percentageComplete {
        case 0 ..< 25:
            imageName = "0"
        case 25 ..< 50:
            imageName = "25"
        case 50 ..< 75:
            imageName = "50"
        case 75 ..< 100:
            imageName = "75"
        default:
            imageName = "100"
        }
        
        return NSImage(named: imageName)
    }
    
    func configureButtonsAndMenus() {
        let enableStart: Bool
        let enableStop: Bool
        let enableReset: Bool
        
        if eggTimer.isStopped {
            enableStart = true
            enableStop = false
            enableReset = false
        } else if eggTimer.isPaused {
            enableStart = true
            enableStop = false
            enableReset = true
        } else {
            enableStart = false
            enableStop = true
            enableReset = false
        }
        
        startButton.enabled = enableStart
        stopButton.enabled = enableStop
        resetButton.enabled = enableReset
        
        if let appDel = NSApplication.sharedApplication().delegate as? AppDelegate {
            appDel.enableMenus(enableStart, stop: enableStop, reset: enableReset)
        }
    }
    
    
    
}

extension ViewController {
    
    // MARK: - Preferences
    
    func setupPrefs() {
        updateDisplay(for: prefs.selectedTime)
        
        NSNotificationCenter.defaultCenter().addObserverForName("PrefsChanged", object: nil, queue: nil) {(notification) in self.checkForResetAfterPrefsChange()}
    }
        
    func updateFromPrefs() {
        self.eggTimer.duration = self.prefs.selectedTime
        self.resetButtonClicked(self)
    }
    
    func checkForResetAfterPrefsChange() {
        if eggTimer.isStopped || eggTimer.isPaused {
            // 1
            updateFromPrefs()
        } else {
            // 2
            let alert = NSAlert()
            alert.messageText = "Reset timer with the new settings?"
            alert.informativeText = "This will stop your current timer!"
            alert.alertStyle = NSAlertStyle.WarningAlertStyle
            
            // 3
            alert.addButtonWithTitle("Reset")
            alert.addButtonWithTitle("Cancel")
            
            // 4
            let response = alert.runModal()
            if response == NSAlertFirstButtonReturn {
                self.updateFromPrefs()
            }
        }
    }

}

extension ViewController {
    
    // MARK: - Sound
    
    func prepareSound() {
        guard let audioFileUrl = NSBundle.mainBundle().URLForResource("ding", withExtension: "mp3") else {
            return
        }
        
        do {
            soundPlayer = try AVAudioPlayer(contentsOfURL: audioFileUrl)
            soundPlayer?.prepareToPlay()
        } catch {
            print("Sound player not available: \(error)")
        }
    }
    
    func playSound() {
        soundPlayer?.play()
    }
    
}
