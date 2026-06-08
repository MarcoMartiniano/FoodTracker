//
//  WaterPeriod.swift
//  FoodTracker
//
//  Created by Marco Antonio Martiniano on 23.02.26.
//

enum WaterPeriod: CaseIterable {
    case daily
    case weekly
    case monthly
    case yearly
    case lifetime
    
    var title: String {
        switch self {
        case .daily: return "Heute"
        case .weekly: return "Diese Woche"
        case .monthly: return "Dieser Monat"
        case .yearly: return "Dieses Jahr"
        case .lifetime: return "Gesamt"
        }
    }
}
