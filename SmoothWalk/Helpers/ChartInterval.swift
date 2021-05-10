//
//  ChartInterval.swift
//  SmoothWalk
//
//  Created by kaveh mohammadpour on 5/9/21.
//

import Foundation

/// Different interval options that will be used in our queries and query resources
enum ChartInterval {
    case daily
    case weekly
    case monthly
    
    /// Will generate the interval resources needed for HealthKit query
    /// - Returns: query interval resources which needed for different chart interval and windows 
    func queryIntervalResources() -> QueryIntervalResources {
        switch self {
        case.daily:
            return QueryIntervalResources(startDate: Date(),
                                  endDate: Date(),
                                  anchorDate: Date.anchorDay(DateOffsets.anchorDateTimeOffset),
                                  startDateOffset: DateOffsets.dayOffset,
                                  unitInterval: .day,
                                  dateComponentInterval: DateComponents(day: 1))
        case.weekly:
            return QueryIntervalResources(startDate: Date(),
                                  endDate: Date(),
                                  anchorDate: Date.anchorDay(DateOffsets.anchorDateTimeOffset),
                                  startDateOffset: DateOffsets.weekOffset,
                                  unitInterval: .weekOfYear,
                                  dateComponentInterval: DateComponents(weekOfYear: 1))
            
        case.monthly:
            return QueryIntervalResources(startDate: Date(),
                                  endDate: Date(),
                                  anchorDate: Date.anchorDay(DateOffsets.anchorDateTimeOffset),
                                  startDateOffset: DateOffsets.monthOffset,
                                  unitInterval: .month,
                                  dateComponentInterval: DateComponents(month:1))
            
        }
    }
    
}
