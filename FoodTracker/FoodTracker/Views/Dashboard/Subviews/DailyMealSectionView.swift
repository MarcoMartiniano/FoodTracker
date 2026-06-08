//
//  DailyMealSectionView.swift
//  FoodTracker
//
//  Created by Marco Antonio Martiniano on 21.02.26.
//

import SwiftUI

struct DailyMealSectionView: View {
    let meals: [MealCategoryData]
    
    var body: some View {
        VStack(spacing: 16) {
            ForEach(meals) { meal in
                MealBreakdownRow(
                    category: meal.category,
                    calories: meal.calories,
                    color: meal.color
                )
            }
        }
        .padding(.horizontal)
    }
}

private struct MealBreakdownRow: View {
    let category: MealCategory
    let calories: Int
    let color: Color
    
    var body: some View {
        HStack {
            Text(category.rawValue)
            Spacer()
            Text("\(calories) kcal")
                .bold()
                .foregroundStyle(color)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

#Preview {
    let selectedDate = Date()
    
    let entriesForSelectedDate = InitiaEntryData.entries.filter { Calendar.current.isDate($0.date, inSameDayAs: selectedDate) }
    
    let mealsData = MealCategory.allCases.map { category in
        MealCategoryData(
            category: category,
            calories: entriesForSelectedDate
                .filter { $0.category == category }
                .reduce(0) { $0 + $1.calories }
        )
    }
    
    DailyMealSectionView(meals: mealsData)
}
