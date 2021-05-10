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
    
    
    func checktAuth(completion: @escaping (Bool)->()) {
        
        guard let walkingSpeed = ChartType.walkingSpeed.queryInfo().quantityType,
              let stepType = ChartType.step.queryInfo().quantityType,
              let healthStore = healthStore
        else {
            completion(false)
            return
        }
        
        if authorized {
            completion(true)
            return
        }
        
         
        healthStore.getRequestStatusForAuthorization(toShare: [stepType,walkingSpeed], read: [stepType,walkingSpeed]) { [weak self] (status, error) in

            if status  == .shouldRequest {
                self?.requestAuthorization(permissions:[stepType,walkingSpeed]) { success in
                    self?.authorized  = success
                    completion(success)
                }
                
            }
        }
        



        
    }
    
    func requestAuthorization(permissions:[HKQuantityType], completion: @escaping (Bool)->() ){
        healthStore?.requestAuthorization(toShare: [], read: Set(permissions)) { (success, error) in
            completion(success)
        }
    }
    
}
