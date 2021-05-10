//
//  DateOffsets.swift
//  SmoothWalk
//
//  Created by kaveh mohammadpour on 5/9/21.
//

import Foundation

/// App Magic numbers which will be used in HealthKit query to define time window
struct DateOffsets {
    /// day starting time offset
    static let anchorDateTimeOffset = 3
    /// daily chart window which will show number of days form now
    static let dayOffset = -7
    /// weekly chart  which will show number of  weeks from now
    static let weekOffset = -12
    /// monthly chart which will show number months from now
    static let monthOffset = -12
}
