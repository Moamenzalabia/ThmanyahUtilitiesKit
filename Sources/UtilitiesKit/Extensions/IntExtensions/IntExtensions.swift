//
//  IntExtensions.swift
//
//  Created by Moamen on 25/11/2023.
//

import Foundation

// MARK: - Int Extensions
public extension Int {
    func getTimeDuration() -> (hours: Int, minutes: Int, seconds: Int) {
        let hours = self / 3600
        let minutes = (self % 3600) / 60
        let remainingSeconds = (self % 3600) % 60
        return (hours, minutes, remainingSeconds)
    }
}
