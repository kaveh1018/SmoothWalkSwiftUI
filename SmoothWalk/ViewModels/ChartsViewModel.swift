//
//  ChartsViewModel.swift
//  SmoothWalk
//
//  Created by kaveh mohammadpour on 5/9/21.
//

import Foundation

struct ChartsViewModel {
    
    var charts = [Chart]()
    
    init(){
        self.getAll()
    }
    
    mutating func getAll(){
        charts = [
            Chart(chartType: .walkingSpeed, chartInterval: .daily, title: "Daily Walking Speed Average", description: "Daily Average: ", legend: "Week Days",unit: "m/s"),
            Chart(chartType: .walkingSpeed, chartInterval: .weekly, title: "Weekly Walking Speed Average",description: "Weekly Average: ", legend: "Week of the Year",unit: "m/s"),
            Chart(chartType: .walkingSpeed, chartInterval: .monthly, title: "Monthly Walking Speed Average",description: "Monthly Average: ", legend: "Month",unit: "m/s"),
            Chart(chartType: .step, chartInterval: .daily, title: "Daily Steps", description: "Daily Average: ", legend: "Week Days",unit: "steps"),
            Chart(chartType: .step, chartInterval: .weekly, title: "Weekly Steps", description: "Weekly Average: ", legend: "Week of the Year",unit: "steps"),
            Chart(chartType: .step, chartInterval: .monthly, title: "Monthly Steps",description: "Monthly Average: ", legend: "Month",unit: "steps")
        
        ]
        
    }

}
