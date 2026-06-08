//
//  InitialData.swift
//  FoodTracker
//
//  Created by Marco Antonio Martiniano on 22.02.26.
//

import Foundation

struct AllInitialEntries {
    static let entries: [Entry] = InitiaEntryData.entries + InitialWaterData.entries
}

struct InitiaEntryData {
    static let entries: [Entry] = [
        entryItemHauptgericht,
        Entry(title: "Spaghetti Bolognese", date: Date(), calories: 850, category: .hauptgericht, amount: 300),
        Entry(title: "Apfelstrudel", date: Date(), calories: 550, category: .nachspeise, amount: 200),
        Entry(title: "Apfelschorle", date: Date(), calories: 180, drink: Drink(type: .beer), amount: 300),
        Entry(title: "Spaghetti", date: Date(), calories: 800, category: .hauptgericht, amount: 400),
        Entry(title: "Wasser", date: Date(), calories: 0, drink: Drink(type: .water), amount: 1000),
        Entry(title: "Pils", date: Date(), calories: 330, category: .getraenk, amount: 400),
        Entry(title: "Wasser", date: Date(), calories: 0, drink: Drink(type: .water), amount: 1000),
    ]
}

struct InitialWaterData {
    static let calendar = Calendar.current

    static func daysAgo(_ days: Int) -> Date {
        calendar.date(byAdding: .day, value: -days, to: Date())!
    }

    static func yearsAgo(_ years: Int, month: Int, day: Int) -> Date {
        let currentYear = calendar.component(.year, from: Date())
        let year = currentYear - years

        return calendar.date(
            from: DateComponents(
                year: year,
                month: month,
                day: day,
                hour: Int.random(in: 8...20),
                minute: [0, 15, 30, 45].randomElement()
            )
        )!
    }

    static let entries: [Entry] = [

        // MARK: - Today (2)
        Entry(title: "Wasser", date: makeDate(hour: 9, minute: 10), calories: 0, drink: Drink(type: .water), amount: 250),
        Entry(title: "Wasser", date: makeDate(hour: 14, minute: 30), calories: 0, drink: Drink(type: .water), amount: 350),

        // MARK: - This Year (mais 18 = total 20)
        Entry(title: "Wasser", date: daysAgo(2), calories: 0, drink: Drink(type: .water), amount: 400),
        Entry(title: "Wasser", date: daysAgo(5), calories: 0, drink: Drink(type: .water), amount: 500),
        Entry(title: "Wasser", date: daysAgo(8), calories: 0, drink: Drink(type: .water), amount: 350),
        Entry(title: "Wasser", date: daysAgo(12), calories: 0, drink: Drink(type: .water), amount: 600),
        Entry(title: "Wasser", date: daysAgo(18), calories: 0, drink: Drink(type: .water), amount: 450),
        Entry(title: "Wasser", date: daysAgo(24), calories: 0, drink: Drink(type: .water), amount: 300),
        Entry(title: "Wasser", date: daysAgo(32), calories: 0, drink: Drink(type: .water), amount: 700),
        Entry(title: "Wasser", date: daysAgo(40), calories: 0, drink: Drink(type: .water), amount: 500),
        Entry(title: "Wasser", date: daysAgo(55), calories: 0, drink: Drink(type: .water), amount: 400),
        Entry(title: "Wasser", date: daysAgo(70), calories: 0, drink: Drink(type: .water), amount: 550),
        Entry(title: "Wasser", date: daysAgo(85), calories: 0, drink: Drink(type: .water), amount: 650),
        Entry(title: "Wasser", date: daysAgo(100), calories: 0, drink: Drink(type: .water), amount: 450),
        Entry(title: "Wasser", date: daysAgo(120), calories: 0, drink: Drink(type: .water), amount: 350),
        Entry(title: "Wasser", date: daysAgo(140), calories: 0, drink: Drink(type: .water), amount: 800),
        Entry(title: "Wasser", date: daysAgo(160), calories: 0, drink: Drink(type: .water), amount: 500),
        Entry(title: "Wasser", date: daysAgo(180), calories: 0, drink: Drink(type: .water), amount: 600),
        Entry(title: "Wasser", date: daysAgo(220), calories: 0, drink: Drink(type: .water), amount: 700),
        Entry(title: "Wasser", date: daysAgo(280), calories: 0, drink: Drink(type: .water), amount: 450),

        // MARK: - Last Year  (5)
        Entry(title: "Wasser", date: yearsAgo(1, month: 2, day: 10), calories: 0, drink: Drink(type: .water), amount: 450),
        Entry(title: "Wasser", date: yearsAgo(1, month: 4, day: 18), calories: 0, drink: Drink(type: .water), amount: 650),
        Entry(title: "Wasser", date: yearsAgo(1, month: 6, day: 25), calories: 0, drink: Drink(type: .water), amount: 350),
        Entry(title: "Wasser", date: yearsAgo(1, month: 9, day: 12), calories: 0, drink: Drink(type: .water), amount: 550),
        Entry(title: "Wasser", date: yearsAgo(1, month: 12, day: 2), calories: 0, drink: Drink(type: .water), amount: 700),

        // MARK: - 2 Years ago (3)
        Entry(title: "Wasser", date: yearsAgo(2, month: 3, day: 8), calories: 0, drink: Drink(type: .water), amount: 500),
        Entry(title: "Wasser", date: yearsAgo(2, month: 7, day: 20), calories: 0, drink: Drink(type: .water), amount: 600),
        Entry(title: "Wasser", date: yearsAgo(2, month: 11, day: 15), calories: 0, drink: Drink(type: .water), amount: 400),

        // MARK: - 3 Years ago (2)
        Entry(title: "Wasser", date: yearsAgo(3, month: 5, day: 10), calories: 0, drink: Drink(type: .water), amount: 550),
        Entry(title: "Wasser", date: yearsAgo(3, month: 10, day: 28), calories: 0, drink: Drink(type: .water), amount: 750),
    ]
}
let entryItemHauptgericht = Entry(title: "Bruschetta", date: Date(), calories: 250, category: .vorspeise, amount: 100)

private func makeDate(hour: Int, minute: Int) -> Date {
    var components = Calendar.current.dateComponents([.year, .month, .day], from: Date())
    components.hour = hour
    components.minute = minute
    return Calendar.current.date(from: components)!
}
