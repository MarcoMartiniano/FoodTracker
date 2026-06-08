//
//  WaterDetailView.swift
//  FoodTracker
//
//  Created by Marco Antonio Martiniano on 20.02.26.
//

import SwiftUI

struct WaterDetailView: View {
    let selectedDate: Date
    let waterConsumed: Double
    let waterGoal: Double
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Wasser am \(selectedDate.formatted(.dateTime.day().month().year()))")
                .font(.title2)
                .bold()
            
            Text("\(Int(waterConsumed)) / \(Int(waterGoal)) ml konsumiert")
                .font(.title3)
            
            ProgressView(value: waterConsumed, total: waterGoal)
                .tint(.blue)
                .frame(height: 15)
                .background(Color(.systemGray5))
                .cornerRadius(7)
                .padding(.horizontal)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    WaterDetailView(selectedDate: Date(), waterConsumed: 300.0, waterGoal: 1000.0)
}
