//
//  DailyCaloriesCard.swift
//  FoodTracker
//
//  Created by Marco Antonio Martiniano on 21.02.26.
//

import SwiftUI

struct DailyCaloriesCardView: View {
    let totalCalories: Int
    let selectedDate: Date
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: AppIcons.flameFill)
                .font(.system(size: 28))
                .foregroundStyle(.orange)
            
            Text("\(totalCalories)")
                .font(.system(size: 28, weight: .bold))
            
            Text("Kalorien am \(selectedDate.formatted(.dateTime.day().month().year()))")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .padding(.horizontal)
        .background(.ultraThinMaterial)
        .cornerRadius(16)
        .padding(.horizontal)
    }
}

#Preview {
    DailyCaloriesCardView(
        totalCalories: 3200,
        selectedDate: Date()
    )
}
