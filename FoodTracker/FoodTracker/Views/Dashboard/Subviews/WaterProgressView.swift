//
//  WaterProgressView.swift
//  FoodTracker
//
//  Created by Marco Antonio Martiniano on 21.02.26.
//

import SwiftUI

struct WaterProgressView: View {
    let waterConsumed: Double
    let waterGoal: Double = 2000
    let onTap: () -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Wasserverbrauch").bold()
                Spacer()
                Text("\(Int(waterConsumed)) / \(Int(waterGoal)) ml")
                    .foregroundStyle(.secondary)
            }
            
            ProgressView(value: min(max(waterConsumed, 0), waterGoal), total: waterGoal)
                .tint(.blue)
                .frame(height: 10)
                .background(Color(.systemGray5))
                .cornerRadius(5)
            
            Button("Zur Wasserübersicht", action: onTap)
                .buttonStyle(.borderedProminent)
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .padding(.horizontal)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    WaterProgressView(waterConsumed: 300, onTap: {})
}
