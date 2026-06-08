//
//  MealCategoryData.swift
//  FoodTracker
//
//  Created by Marco Antonio Martiniano on 21.02.26.
//

import SwiftUI

struct MealCategoryData: Identifiable {
    let category: MealCategory
    let calories: Int
    
    var color: Color { category.color }
    var id: MealCategory { category }
}
