//
//  CardStatus.swift
//  FoodTracker
//
//  Created by Marco Antonio Martiniano on 23.02.26.
//

import Foundation

enum CardStatus {
    case solidBlack
    case striped
    case partial(Double)
}

struct ChartColumn : Identifiable {
    let id: UUID = UUID()
    let label: String
    let values: [CardStatus]
}
