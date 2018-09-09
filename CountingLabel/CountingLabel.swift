//
//  CountingLabel.swift
//  CountingLabel
//
//  Created by Local on 07/09/2018.
//  Copyright © 2018 Local. All rights reserved.
//

import Foundation
import UIKit

class CountingLabel: UILabel {
    
    let counterVelocity:Float = 3.0
    
    enum CounterAnimationType {
        case Linear     // f(x) = x
        case EaseIn     // f(x) = x^3
        case EaseOut    // f(x) = (1-x)^3
        case EaseInOut  // f(x) = 0.3*x^3 - EaseIn // f(x) = 0.5*(2-x)^3 - EaseOut
    }
    
    enum CounterType {
        case Int
        case Float
    }
    
    var startNumber: Float = 0.0
    var endNumber: Float = 0.0
    
    var progress: TimeInterval = 0
    var duration: TimeInterval!
    var lastUpdate: TimeInterval!
    
    var timer: Timer?
    
    var counterType: CounterType!
    var counterAnimationType: CounterAnimationType!
    
    var currentCounterValue: Float {
        if self.progress >= self.duration {
            return self.endNumber
        }
        
        let percentage = Float(self.progress / self.duration)
        let update = updateCounter(counterValue: percentage)
        
        return self.startNumber + (update * (self.endNumber - self.startNumber))
    }
    
    func count(fromValue:Float, to toValue:Float, withDuration duration:TimeInterval, andAnimationType animationType: CounterAnimationType, andCounterType counterType:CounterType) {
        
        self.startNumber = fromValue
        self.endNumber = toValue
        self.duration = duration
        self.counterType = counterType
        self.counterAnimationType = animationType
        self.progress = 0
        self.lastUpdate = Date.timeIntervalSinceReferenceDate
    
        invalidateTimer()
        
        if self.duration == 0 {
            updateText(value: toValue)
            return
        }
        
        self.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(CountingLabel.updateValue), userInfo: nil, repeats: true)
    }
    
    @objc func updateValue() {
        let now = Date.timeIntervalSinceReferenceDate
        self.progress += (now - self.lastUpdate)
        self.lastUpdate = now
        
        if self.progress >= self.duration {
            invalidateTimer()
            self.progress = self.duration
        }
        
        //update text in label
        updateText(value: currentCounterValue)
    }
    
    func updateText(value: Float) {
        switch counterType! {
        case .Int:
            self.text = "\(Int(value))"
        case .Float:
            self.text = String(format: "%.2f", value)
        }
    }
        
    func updateCounter(counterValue: Float) -> Float {
        switch counterAnimationType! {
        case .Linear:
            return counterValue
        case .EaseIn:
            return powf(counterValue, counterVelocity)
        case .EaseOut:
            return 1.0 - powf(1.0 - counterValue, counterVelocity)
        case .EaseInOut:
            return counterAnimationCalculationEaseInOut(counterValue: counterValue)
        }
    }
        
    func invalidateTimer() {
       self.timer?.invalidate()
        self.timer = nil
    }
    
    func counterAnimationCalculationEaseInOut(counterValue: Float) -> Float
    {
        var counterValue = counterValue
        counterValue *= 2
        if counterValue < 1 {
            return 0.3 * powf(counterValue, counterVelocity)
        } else {
            return 0.5 * (2.0 - powf(2.0 - counterValue, counterVelocity))
        }
    }
    
    
    
    
}
