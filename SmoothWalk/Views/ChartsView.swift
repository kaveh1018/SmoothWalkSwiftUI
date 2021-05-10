//
//  ContentView.swift
//  SmoothWalk
//
//  Created by kaveh mohammadpour on 5/6/21.
//

import SwiftUI
import HealthKit
import CareKit
import Combine

struct ChartsView: View {

    @State var healthKitIsAuthorized:Bool = false
    var healthStore:HealthStore
    var chartsViewModel:ChartsViewModel
    
    init(viewModel:ChartsViewModel, healthStore:HealthStore){
        self.healthStore = healthStore
        self.chartsViewModel = viewModel
    }
    
    
    var body: some View {

        ScrollView(.vertical, showsIndicators: false){
            if !healthKitIsAuthorized {
                Text("HealthKit is Not available or HealthKit Authorization is in Progress")
            }else{
                VStack {
                    ForEach(chartsViewModel.charts, id:\.id) { chart in
                        ChartView(chart:chart, healthStore:healthStore)
                            .frame(height: 220, alignment: .center)
                            .padding()

                    }
                    
                }
                
            }
        }
        .onAppear(){
            healthStore.checktAuth(){ success in
                DispatchQueue.main.sync {
                    healthKitIsAuthorized = success
                }
            }
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChartsView(viewModel: ChartsViewModel(), healthStore: HealthStore())
    }
}
