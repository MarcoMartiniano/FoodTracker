//
//  DrinkDay.swift
//  FoodTracker
//
//  Created by Marco Antonio Martiniano on 20.02.26.
//

import Foundation

struct DrinkDay: Identifiable, Hashable {
    let id: UUID = UUID()
    let date: Date
    let goal: Double
    var drinks: [Drink] = []
}
