//
//  EggTimer.swift
//  EggTimer
//
//  Created by Justin Athill on 6/15/18.
//  Copyright © 2018 Justin_Athill. All rights reserved.
//

import Foundation

protocol EggTimerProtocol {
    func timeRemainingOnTimer(timer: EggTimer, timeRemaining: NSTimeInterval)
    func timerHasFinished(timer: EggTimer)
}

class EggTimer {
    
    var timer: NSTimer? = nil
    var startTime: NSDate?
    var duration: NSTimeInterval = 360    // default = 6 minutes
    var elapsedTime: NSTimeInterval = 0
    var delegate: EggTimerProtocol?
    
    var isStopped: Bool {
        return timer == nil && elapsedTime == 0
    }
    var isPaused: Bool {
        return timer == nil && elapsedTime > 0
    }
    
    dynamic func timerAction() {
        // 1
        guard let startTime = startTime else {
            return
        }
        
        // 2
        elapsedTime = -startTime.timeIntervalSinceNow
        
        // 3
        let secondsRemaining = round(duration - elapsedTime)
        
        //4
        if secondsRemaining <= 0 {
            resetTimer()
            delegate?.timerHasFinished(self)
        } else {
            delegate?.timeRemainingOnTimer(self, timeRemaining: secondsRemaining)
        }
    }
    
    func startTimer() {
        startTime = NSDate()
        elapsedTime = 0
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        
        timerAction()
    }
    
    // 1
    func resumeTimer() {
        startTime = NSDate(timeIntervalSinceNow: -elapsedTime)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        
        timerAction()
    }
    
    //3
    func stopTimer() {
        // really just pauses the timer
        timer?.invalidate()
        timer = nil
        
        timerAction()
    }
    
    // 4
    func resetTimer() {
        //stop the timer & reset back to start
        timer?.invalidate()
        timer = nil
        
        startTime = nil
        duration = 360
        elapsedTime = 0
        
        timerAction()
    }
}