//
//  MealCategory.swift
//  FoodTracker
//
//  Created by Marco Antonio Martiniano on 20.02.26.
//

import Foundation
import SwiftUI

enum MealCategory: String, CaseIterable, Identifiable {
    case vorspeise = "Vorspeise"
    case hauptgericht = "Hauptgericht"
    case nachspeise = "Nachspeise"
    case getraenk = "Getränk"
    
    var id: String { self.rawValue }
    
    var color: Color {
        switch self {
        case .vorspeise: return .green
        case .hauptgericht: return .blue
        case .nachspeise: return .pink
        case .getraenk: return .purple
        }
    }
}
