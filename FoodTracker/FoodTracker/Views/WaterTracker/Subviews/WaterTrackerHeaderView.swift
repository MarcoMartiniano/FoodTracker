//
//  WaterTrackerHeaderView.swift
//  FoodTracker
//
//  Created by Marco Antonio Martiniano on 23.02.26.
//

import SwiftUI

struct WaterTrackerHeaderView: View {
    @Binding var selectedTab: WaterPeriod
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(WaterPeriod.allCases, id: \.self) { period in
                    WaterTrackerHeaderItemView(
                        label: period.title,
                        isSelected: selectedTab == period
                    )
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            selectedTab = period
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct WaterTrackerHeaderItemView: View {
    var label: String
    var isSelected: Bool
    
    var body: some View {
        Text(label)
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(isSelected ? .white : .gray)
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(
                isSelected ? Color.black : Color.gray.opacity(0.15)
            )
            .cornerRadius(24)
            .animation(.easeInOut(duration: 0.2), value: isSelected)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    WaterTrackerHeaderView(selectedTab: .constant(.daily))
}
