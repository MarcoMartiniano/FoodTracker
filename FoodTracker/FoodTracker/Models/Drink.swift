//
//  Drink.swift
//  FoodTracker
//
//  Created by Marco Antonio Martiniano on 20.02.26.
//

import Foundation

enum DrinkType: String, CaseIterable, Identifiable, Hashable {
    case water = "Wasser"
    case coffee = "Kaffee"
    case tea = "Tee"
    case juice = "Saft"
    case beer = "Bier"
    case other = "Andere"
    
    var id: String { self.rawValue }
}

struct Drink: Identifiable, Hashable {
    let id: UUID = UUID()
    let type: DrinkType
}
