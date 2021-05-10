//
//  CHartTypes.swift
//  SmoothWalk
//
//  Created by kaveh mohammadpour on 5/9/21.
//

import Foundation
import HealthKit

/// return type which include type and options which will be used in HealthKit query
struct QuantityChartTypeQueryInfoOptions {
    /// Type of data we want to show on chart
    var quantityType:HKQuantityType?
    /// quantity option for data query
    var quantityOption:HKStatisticsOptions
}


/// Different type of chart data that app needed. we  can add more types here.
enum ChartType {

    case step
    case walkingSpeed
    
    /// Function to generate query info
    /// - Returns: will return info necessary for HealthKit data query regarding type of data we need.
    func queryInfo() -> QuantityChartTypeQueryInfoOptions {
        switch self {
        case .step:
            return QuantityChartTypeQueryInfoOptions(quantityType: HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount) ?? nil, quantityOption: .cumulativeSum)
        case .walkingSpeed:
            return QuantityChartTypeQueryInfoOptions(quantityType:  HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.walkingSpeed) ?? nil, quantityOption: .discreteAverage)
        }
    }
}
