//
//  Date+Formatting.swift
//  FoodTracker
//
//  Created by Marco Antonio Martiniano on 17.02.26.
//

import Foundation

extension Date {
    var germanFormatted: String {
        self.formatted(
            .dateTime
                .locale(Locale(identifier: "de_DE"))
                .day(.twoDigits)
                .month(.twoDigits)
                .year()
                .hour(.twoDigits(amPM: .omitted))
                .minute(.twoDigits)
        )
    }
}
