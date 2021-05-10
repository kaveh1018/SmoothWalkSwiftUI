//
//  ChartViewModel.swift
//  SmoothWalk
//
//  Created by kaveh mohammadpour on 5/9/21.
//

import Foundation
import Combine
import SwiftUI
import HealthKit

class ChartViewModel: ObservableObject {
    
    @Published var data:[ChartData]?
    @ObservedObject var healthStore:HealthStore
    var chartInterval:ChartInterval
    var chartType:ChartType
    var title:String
    var legend:String
    var unit:String
    init(chart:Chart, healthStore:HealthStore){
        self.chartInterval = chart.chartInterval
        self.chartType = chart.chartType
        self.healthStore = healthStore
        self.title = chart.title
        self.legend = chart.legend
        self.unit = chart.unit
        self.healthStore.fetchData(chartInterval:chartInterval,
                                   chartType: chartType )
                { (statisticsCollection) in
                    if let statisticsCollection = statisticsCollection {
                        self.updateStatistics(statisticsCollection,chartInterval: chart.chartInterval, chartType:chart.chartType)
                    }
               }
    }
    
    var seriesValues:[CGFloat] {
        return data?.reduce(into: [CGFloat]()){ $0.append($1.value)} ?? []
    }
    var labels :[String] {
        return data?.reduce(into: [String]()){ $0.append($1.label)} ?? []
    }
    
    func updateStatistics(_ statisticsCollection:HKStatisticsCollection, chartInterval:ChartInterval, chartType:ChartType) {
        var newRecords:[ChartData] = []
        for record in statisticsCollection.statistics() {
            var value:Double = 0.0
            switch chartType {
            case .step:
                value = record.sumQuantity()?.doubleValue(for: .count()) ?? 0.0
                
            case .walkingSpeed:
                value = record.averageQuantity()?.doubleValue(for: HKUnit(from: "m/s")) ?? 0.0
                
            }
            
            let label = getLabelString(chartInterval ,date:record.startDate)
            let newRecord = ChartData(value: CGFloat(value), label: label)
            newRecords.append(newRecord)
            
        }
    
        DispatchQueue.main.async { [weak self] in
            self?.data = newRecords
        }
        
        
    }
    
    func getLabelString(_ chartType:ChartInterval, date:Date) -> String{
        
        switch chartType {
        case .daily:
            return date.weekdayString
        case .weekly:
            return date.weekOfYearString
        case .monthly:
            return date.shortMonthNameString
        }
        
        
    }

}
