//
//  AnimatedLabel.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/26/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

enum CountingEffect {
    case easeInOut, easeIn, easeOut, linear
}

enum AnimationDuration {
    case long, fast, none
    
    var value: TimeInterval {
        switch self {
        case .long: return 20.0
        case .fast: return 2.0
        case .none: return 0.0
        }
    }
}

class AnimatedLabel: TitleLabel {

    typealias OptionalCallback = (() -> Void)
    typealias OptionalFormatBlock = (() -> String)
    
    var completion: OptionalCallback?
    var animationDuration: AnimationDuration = .fast
    var countingEffect: CountingEffect = .easeInOut
    var customFormatBlock: OptionalFormatBlock?
    var currencyIdentifier: String = "en-US"
    
    private var rate: Float = 0
    private var startingValue: Double = 0
    private var destinationValue: Double = 0
    private var progress: TimeInterval = 0
    private var lastUpdate: TimeInterval = 0
    private var totalTime: TimeInterval = 0
    private var easingRate: Float = 0
    private var timer: CADisplayLink?
    private var currentValue: Double {
        if progress >= totalTime { return destinationValue }
        return startingValue + Double((update(time: Float(progress / totalTime)) * Float(destinationValue - startingValue)))
    }
    
    func count(from: Double, to: Double, duration: AnimationDuration = .fast) {
        startingValue = from
        destinationValue = to
        timer?.invalidate()
        timer = nil
        
        if duration.value == 0.0 {
            setTextValue(value: to)
            completion?()
            return
        }
        
        easingRate = 3.0
        progress = 0.0
        totalTime = duration.value
        lastUpdate = Date.timeIntervalSinceReferenceDate
        rate = 3.0
        addDisplayLink()
    }
    
    func countFromCurrent(to: Double, duration: AnimationDuration = .fast) {
        count(from: currentValue, to: to, duration: duration)
    }
    
    func countFromZero(to: Double, duration: AnimationDuration = .fast) {
        count(from: 0.0, to: to, duration: duration)
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
        progress = totalTime
        completion?()
    }
    
    private func addDisplayLink() {
        timer = CADisplayLink(target: self, selector: #selector(updateValue(timer:)))
        timer?.add(to: .main, forMode: .default)
        timer?.add(to: .main, forMode: .tracking)
    }
    
    private func update(time: Float) -> Float {
        var time = time
        switch countingEffect {
        case .linear:
            return time
        case .easeIn:
            return powf(time, rate)
        case .easeInOut:
            var sign: Float = 1
            if Int(rate) % 2 == 0 { sign = -1}
            time *= 2
            return time < 1 ? 0.5 * powf(time, rate) : (sign * 0.5) * (powf(time - 2, rate) + sign * 2)
        case .easeOut:
            return 1.0 - powf((1.0 - time), rate)
        }
    }

    @objc private func updateValue(timer: Timer) {
        let now: TimeInterval = Date.timeIntervalSinceReferenceDate
        progress += now - lastUpdate
        lastUpdate = now
        
        if progress >= totalTime {
            self.timer?.invalidate()
            self.timer = nil
            progress = totalTime
        }
        
        setTextValue(value: currentValue)
        if progress == totalTime { completion?() }
    }
    
    private func setTextValue(value: Double) {
        text = value.toCurrency(with: currencyIdentifier)
    }
}
