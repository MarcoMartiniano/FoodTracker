//
//  Entry.swift
//  FoodTracker
//
//  Created by Marco Antonio Martiniano on 17.02.26.
//

import Foundation


struct Entry: Identifiable {
    let id: UUID = UUID()
    let title: String
    let date: Date
    let calories: Int
    let category: MealCategory
    let drink: Drink?
    let amount: Double
    
    // Init to food
    init(title: String, date: Date, calories: Int, category: MealCategory, amount: Double) {
        self.title = title
        self.date = date
        self.calories = calories
        self.category = category
        self.drink = nil
        self.amount = amount
    }
    
    // Init to drink
    init(title: String, date: Date, calories: Int, drink: Drink, amount: Double) {
        self.title = title
        self.date = date
        self.calories = calories
        self.category = .getraenk
        self.drink = drink
        self.amount = amount
    }
}
