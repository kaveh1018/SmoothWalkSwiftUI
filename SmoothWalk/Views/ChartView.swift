//
//  ChartView.swift
//  SmoothWalk
//
//  Created by kaveh mohammadpour on 5/9/21.
//

import SwiftUI
import CareKit
import HealthKit

struct ChartView: UIViewRepresentable {

    @ObservedObject var viewModel:ChartViewModel
    
    init(chart:Chart , healthStore:HealthStore){
        viewModel = ChartViewModel(chart:chart, healthStore: healthStore)
        viewModel.healthStore = healthStore
    }
    func makeUIView(context: Context) -> OCKCartesianChartView {
        let chartView = OCKCartesianChartView(type: .bar)

        return chartView
    }

    func updateUIView(_ uiView: OCKCartesianChartView, context: Context) {
        uiView.graphView.dataSeries = [
            OCKDataSeries(values: viewModel.seriesValues, title: viewModel.legend)
        ]
        uiView.graphView.yMinimum = 0.0
        uiView.graphView.yMaximum = (viewModel.seriesValues.max() ?? 0 ) + 1
        uiView.graphView.horizontalAxisMarkers = viewModel.labels
        uiView.headerView.titleLabel.text = viewModel.title
        uiView.headerView.detailLabel.text  =  String(format: "Average: %0.2f \(viewModel.unit)", viewModel.seriesValues.average)
    }
}
