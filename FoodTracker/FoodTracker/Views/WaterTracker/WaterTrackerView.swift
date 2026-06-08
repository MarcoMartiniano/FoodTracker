//
//  WaterTrackerView.swift
//  FoodTracker
//
//  Created by Marco Antonio Martiniano on 23.02.26.
//

import SwiftUI

struct WaterTrackerView: View {
    @Binding var entries: [Entry]
    @State private var showAddWater = false
    @State private var selectedPeriod: WaterPeriod = .daily
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                ScrollView {
                    VStack(spacing: 20) {
                        WaterTrackerHeaderView(selectedTab: $selectedPeriod)
                        WaterInfoCardView()
                        BlockChartView(entries: $entries, period: selectedPeriod)
                        WaterConsumptionView(entries: $entries, period: selectedPeriod)
                        
                        Spacer(minLength: 100)
                    }
                    .padding(.horizontal)
                }
                
                AddHydrationButton {
                    showAddWater = true
                }
                .padding()
            }
            .navigationTitle("Wassertracker")
            .navigationDestination(isPresented: $showAddWater) {
                AddWaterView { entry in
                    entries.insert(entry, at: 0)
                }
            }
        }
    }
}

#Preview {
    WaterTrackerView(entries: .constant(InitiaEntryData.entries))
}
