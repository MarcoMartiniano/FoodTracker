//
//  BlockChartView.swift
//  FoodTracker
//
//  Created by Marco Antonio Martiniano on 23.02.26.
//

import SwiftUI

struct BlockChartView: View {
    @Binding var entries: [Entry]
    var period: WaterPeriod
    
    private let totalDailyGoal: Double = 2000
    private let calendar = Calendar.current
    private let percentages = [100, 80, 60, 40, 20]
    
    // MARK: - UI
    var body: some View {
        VStack(alignment: .leading) {

            Text("Hydration")
                .font(.title2)
                .fontWeight(.semibold)

            ScrollView(.horizontal, showsIndicators: false) {
                
                VStack(alignment: .center, spacing: 4) {

                    ForEach(percentages.indices, id: \.self) { rowIndex in
                        HStack(spacing: 2) {

                            Text("\(percentages[rowIndex])%")
                                .font(.caption2)
                                .frame(width: 35, alignment: .trailing)

                            ForEach(columns.indices, id: \.self) { columnIndex in
                                let reversedIndex = (percentages.count - 1) - rowIndex

                                StatusSquare(
                                    status: columns[columnIndex].values[reversedIndex],
                                    cornerRadius: 6
                                )
                                .frame(width: 40, height: 30)
                            }
                        }
                    }

                    HStack(spacing: 2) {
                        Spacer().frame(width: 35)

                        ForEach(columns, id: \.id) { column in
                            Text(column.label)
                                .font(.caption2)
                                .frame(width: 40)
                        }
                    }
                }
                .padding(.all, 10)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(.systemBackground))
                )
                .shadow(color: .black.opacity(0.06),
                        radius: 10,
                        x: 0,
                        y: 4)
            }
        }
    }

    // MARK: - Columns
    private var columns: [ChartColumn] {
        let generatedColumns = Self.generateColumns(for: period)

        return generatedColumns.enumerated().map { index, column in

            let interval: (start: Date, end: Date)
            let goal: Double

            switch period {

            case .daily:

                interval = dailyInterval(for: index)
                goal = totalDailyGoal / Double(generatedColumns.count)

            case .weekly:

                interval = weeklyInterval(for: index)
                goal = totalDailyGoal

            case .monthly:

                interval = monthlyInterval(for: index)

                let days = calendar.dateComponents(
                    [.day],
                    from: interval.start,
                    to: interval.end
                ).day ?? 7

                goal = Double(days) * totalDailyGoal
                
            case .yearly:

                interval = yearlyInterval(for: index)

                let days = calendar.dateComponents(
                    [.day],
                    from: interval.start,
                    to: interval.end
                ).day ?? 30

                goal = Double(days) * totalDailyGoal

            case .lifetime:

                interval = lifetimeInterval(for: index)

                let days = calendar.dateComponents(
                    [.day],
                    from: interval.start,
                    to: interval.end
                ).day ?? 365

                goal = Double(days) * totalDailyGoal
            }

            let intervalEntries = entries.filter { entry in

                guard entry.category == .getraenk,
                      entry.drink?.type == .water
                else {
                    return false
                }

                return entry.date >= interval.start &&
                       entry.date < interval.end
            }

            var consumed = intervalEntries.reduce(0) {
                $0 + $1.amount
            }

            let perSquare = goal / 5

            let values = buildSquares(
                consumed: &consumed,
                perSquare: perSquare
            )

            return ChartColumn(
                label: column.label,
                values: values
            )
        }
    }
    
    private func dailyInterval(
        for index: Int
    ) -> (start: Date, end: Date) {

        let dayStart =
            calendar.startOfDay(for: Date())

        let hours = [0, 6, 12, 18, 24]

        let start = calendar.date(
            byAdding: .hour,
            value: hours[index],
            to: dayStart
        )!

        let end = calendar.date(
            byAdding: .hour,
            value: hours[index + 1],
            to: dayStart
        )!

        return (start, end)
    }
    
    private func weeklyInterval(
        for index: Int
    ) -> (start: Date, end: Date) {

        let weekStart = calendar.dateInterval(
            of: .weekOfYear,
            for: Date()
        )!.start

        let start = calendar.date(
            byAdding: .day,
            value: index,
            to: weekStart
        )!

        let end = calendar.date(
            byAdding: .day,
            value: 1,
            to: start
        )!

        return (start, end)
    }
    
    private func yearlyInterval(
        for index: Int
    ) -> (start: Date, end: Date) {

        let currentYear = calendar.component(.year, from: Date())

        var components = DateComponents()
        components.year = currentYear
        components.month = index + 1
        components.day = 1

        let start = calendar.date(from: components)!

        let end = calendar.date(
            byAdding: .month,
            value: 1,
            to: start
        )!

        return (start, end)
    }
    
    private var firstEntryYear: Int {

        guard let oldestEntry = entries.min(by: {
            $0.date < $1.date
        }) else {
            return calendar.component(.year, from: Date())
        }

        return calendar.component(.year, from: oldestEntry.date)
    }
    
    private func lifetimeInterval(
        for index: Int
    ) -> (start: Date, end: Date) {

        let year = firstEntryYear + index

        let start = calendar.date(
            from: DateComponents(
                year: year,
                month: 1,
                day: 1
            )
        )!

        let end = calendar.date(
            from: DateComponents(
                year: year + 1,
                month: 1,
                day: 1
            )
        )!

        return (start, end)
    }
    
    // MARK: - Builder dos quadrados
    private func buildSquares(consumed: inout Double,
                              perSquare: Double) -> [CardStatus] {
        
        return (0..<5).map { _ in
            if consumed >= perSquare {
                consumed -= perSquare
                return .solidBlack
            } else if consumed > 0 {
                let percent = consumed / perSquare
                consumed = 0
                return .partial(percent)
            } else {
                return .striped
            }
        }
    }
    
    
    // MARK: - Intervalos do Daily
    private func getDailyIntervalDate(for index: Int) -> Date {
        let today = Date()
        let components = calendar.dateComponents([.year, .month, .day], from: today)
        
        func makeHour(_ hour: Int) -> Date {
            var c = components
            c.hour = hour
            c.minute = 0
            return calendar.date(from: c)!
        }
        
        let hours = [9, 12, 17, 20]
        
        if index < 0 {
            return calendar.startOfDay(for: today)
        } else if index < hours.count {
            return makeHour(hours[index])
        } else {
            return today
        }
    }
    
    private func monthlyInterval(
        for index: Int
    ) -> (start: Date, end: Date) {

        let monthStart = calendar.dateInterval(
            of: .month,
            for: Date()
        )!.start

        let startDay = index * 7

        let start = calendar.date(
            byAdding: .day,
            value: startDay,
            to: monthStart
        )!

        let end = calendar.date(
            byAdding: .day,
            value: startDay + 7,
            to: monthStart
        )!

        return (start, end)
    }
    
    // MARK: - Labels
    static func generateColumns(
        for period: WaterPeriod
    ) -> [ChartColumn] {

        let labels: [String]

        switch period {

        case .daily:
            labels = [
                "00-06",
                "06-12",
                "12-18",
                "18-24"
            ]

        case .weekly:
            labels = [
                "Mon",
                "Tue",
                "Wed",
                "Thu",
                "Fri",
                "Sat",
                "Sun"
            ]

        case .monthly:
            labels = [
                "W1",
                "W2",
                "W3",
                "W4",
                "W5"
            ]

        case .yearly:
            labels = [
                "Jan",
                "Feb",
                "Mar",
                "Apr",
                "May",
                "Jun",
                "Jul",
                "Aug",
                "Sep",
                "Oct",
                "Nov",
                "Dec"
            ]

        case .lifetime:
            let currentYear = Calendar.current.component(.year, from: Date())

            labels = stride(
                from: currentYear - 4,
                through: currentYear,
                by: 1
            )
            .map(String.init)
        }

        return labels.map { label in
            ChartColumn(
                label: label,
                values: Array(
                    repeating: .striped,
                    count: 5
                )
            )
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    BlockChartView(entries: .constant(InitialWaterData.entries), period: .weekly)
}
