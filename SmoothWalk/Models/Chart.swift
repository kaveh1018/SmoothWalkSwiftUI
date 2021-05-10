//
//  Chart.swift
//  SmoothWalk
//
//  Created by kaveh mohammadpour on 5/9/21.
//

import Foundation

struct Chart:Identifiable{
    let id = UUID()
    let chartType:ChartType
    let chartInterval:ChartInterval
    let title:String
    let description:String
    let legend:String
    let unit:String
}
