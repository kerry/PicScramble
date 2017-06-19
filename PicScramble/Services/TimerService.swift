//
// Created by Prateek Grover on 18/06/17.
// Copyright (c) 2017 Personal. All rights reserved.
//

import Foundation

protocol TimerDelegate: class {
    func updateTimer(elapsedIntervals: Int)
}

protocol TimerService {
    func startTimer()
    func pauseTimer()
    func resumeTimer()
    func stopTimer()
}

class TimerServiceImpl: NSObject, TimerService {
    weak var timerDelegate: TimerDelegate?
    var timer: Timer!
    var elapsedIntervals: Int
    var interval: TimeInterval

    init(interval: TimeInterval, delegate: TimerDelegate) {
        self.timerDelegate = delegate
        self.elapsedIntervals = 0
        self.interval = interval
        super.init()
    }
    
    func scheduleTimer(interval: TimeInterval) {
        self.timer = Timer.scheduledTimer(timeInterval: self.interval,
                target: self,
                selector: #selector(self.intervalReached),
                userInfo: nil,
                repeats: true)
    }

    func intervalReached() {
        self.elapsedIntervals += 1
        self.timerDelegate?.updateTimer(elapsedIntervals: self.elapsedIntervals)
    }

    func startTimer() {
        self.scheduleTimer(interval: self.interval)
        self.timer.fire()
    }

    func pauseTimer() {
        guard self.timer != nil else {
            return
        }
        self.timer.invalidate()
    }

    func resumeTimer() {
        guard self.timer != nil else {
            return
        }
        self.startTimer()
    }

    func stopTimer() {
        guard self.timer != nil else {
            return
        }
        self.resetElapsedIntervals()
        self.timer.invalidate()
        self.timer = nil
    }

    func resetElapsedIntervals() {
        self.elapsedIntervals = 0
    }
}
