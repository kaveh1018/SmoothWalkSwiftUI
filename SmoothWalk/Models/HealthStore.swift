//
//  HealthStore.swift
//  SmoothWalk
//
//  Created by kaveh mohammadpour on 5/7/21.
//

import Foundation
import HealthKit

class HealthStore : ObservableObject {
    var healthStore: HKHealthStore?
    var authorized = false
    
    init(){
        //should check of health store if available
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        }
    }
    
    
    func fetchData(chartInterval:ChartInterval,
                           chartType:ChartType,
                           completion: @escaping (HKStatisticsCollection?) ->()) {
        
        guard let quantityType = chartType.queryInfo().quantityType else {
            completion(nil)
            return
        }
        
        let chartIntervalQueryInfo = chartInterval.queryIntervalResources()
        let chartTypeQueryInfo = chartType.queryInfo()
        
        let graphStartDate = Calendar.current.date(byAdding: chartIntervalQueryInfo.unitInterval, value: chartIntervalQueryInfo.startDateOffset, to: chartIntervalQueryInfo.startDate)
        let predicate = HKQuery.predicateForSamples(withStart: graphStartDate, end: chartIntervalQueryInfo.endDate, options: .strictStartDate)
        let query = HKStatisticsCollectionQuery(quantityType: quantityType, quantitySamplePredicate: predicate, options: chartTypeQueryInfo.quantityOption, anchorDate: chartIntervalQueryInfo.anchorDate, intervalComponents: chartIntervalQueryInfo.dateComponentInterval)
        
        query.initialResultsHandler = { query, statisticsCollection, error in
            completion(statisticsCollection)
        }
        
        if let healthStore = healthStore {
            healthStore.execute(query)
        }

        
    }
    
    
    func requestAuth(completion: @escaping (Bool)->()) {
        
        guard let walkingSpeed = ChartType.walkingSpeed.queryInfo().quantityType,
              let stepType = ChartType.step.queryInfo().quantityType
        else {
            completion(false)
            return
        }
        
        if authorized {
            completion(true)
            return
        }

        HKHealthStore().requestAuthorization(toShare: [], read: [stepType,walkingSpeed]) { [weak self] (success, error) in
            self?.authorized  = success
            completion(success)
        }
        
    }
    
}
