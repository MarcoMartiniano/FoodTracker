//
//  DashboardView.swift
//  FoodTracker
//
//  Created by Marco Antonio Martiniano on 19.02.26.
//

import SwiftUI

struct DashboardView: View {
    @Binding var entries: [Entry]
    @Binding var selectedTab: Int
    @State private var selectedDate: Date = Date()

    private var entriesForSelectedDate: [Entry] {
        entries.filter { Calendar.current.isDate($0.date, inSameDayAs: selectedDate) }
    }
    
    private var waterConsumed: Double {
        entriesForSelectedDate
            .filter { $0.category == .getraenk && $0.drink?.type == .water }
            .reduce(0) { $0 + $1.amount }
    }
    
    private let waterGoal: Double = 2000
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 30) {
                    DatePicker(
                        "Datum auswählen",
                        selection: $selectedDate,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.compact)
                    .padding(.horizontal)
                    
                    DailyCaloriesCardView(
                        totalCalories: entriesForSelectedDate.reduce(0) { $0 + $1.calories },
                        selectedDate: selectedDate
                    )
                    
                    WaterProgressView(
                        waterConsumed: waterConsumed,
                        onTap: {
                            selectedTab = 2
                        }
                    )
                    
                    DailyMealSectionView(
                        meals: MealCategory.allCases.map { category in
                            MealCategoryData(
                                category: category,
                                calories: entriesForSelectedDate
                                    .filter { $0.category == category }
                                    .reduce(0) { $0 + $1.calories }
                            )
                        }
                    )
                    
                    Spacer()
                }
                .padding(.top)
            }
            .navigationTitle("Übersicht")
        }
    }
}

#Preview {
    DashboardView(entries: .constant(InitiaEntryData.entries), selectedTab: .constant(1))
}
