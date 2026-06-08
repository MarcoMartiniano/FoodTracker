//
//  Entry+Helpers.swift
//  FoodTracker
//
//  Created by Marco Antonio Martiniano on 22.02.26.
//

import SwiftUI

extension Entry {
    
    var calorieColor: Color {
        calories > 500 ? .red : .green
    }
    
    var formattedAmount: String {
        if category == .getraenk {
            return "\(Int(amount)) ml"
        } else {
            return String(format: "%.2f kg", amount)
        }
    }
}
