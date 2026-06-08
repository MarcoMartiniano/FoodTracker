//
//  WaterConsumptionCardView.swift
//  FoodTracker
//
//  Created by Marco Antonio Martiniano on 23.02.26.
//

import SwiftUI

struct WaterConsumptionView: View {
    @Binding var entries: [Entry]
    var period: WaterPeriod
    
    private let calendar = Calendar.current
    
    private var filteredEntries: [Entry] {

        let now = Date()

        let waterEntries = entries.filter {
            $0.category == .getraenk &&
            $0.drink?.type == .water
        }

        switch period {

        case .daily:

            return waterEntries
                .filter {
                    calendar.isDate($0.date, inSameDayAs: now)
                }
                .sorted { $0.date > $1.date }

        case .weekly:

            guard let weekInterval = calendar.dateInterval(
                of: .weekOfYear,
                for: now
            ) else {
                return []
            }

            return waterEntries
                .filter {
                    $0.date >= weekInterval.start &&
                    $0.date < weekInterval.end
                }
                .sorted { $0.date > $1.date }

        case .monthly:

            guard let monthInterval = calendar.dateInterval(
                of: .month,
                for: now
            ) else {
                return []
            }

            return waterEntries
                .filter {
                    $0.date >= monthInterval.start &&
                    $0.date < monthInterval.end
                }
                .sorted { $0.date > $1.date }

        case .yearly:

            guard let yearInterval = calendar.dateInterval(
                of: .year,
                for: now
            ) else {
                return []
            }

            return waterEntries
                .filter {
                    $0.date >= yearInterval.start &&
                    $0.date < yearInterval.end
                }
                .sorted { $0.date > $1.date }

        case .lifetime:

            return waterEntries
                .sorted { $0.date > $1.date }
        }
    }
    
    var body: some View {
        VStack(spacing: 16) {
            if filteredEntries.isEmpty {
                Text("Noch keine Einträge")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                ForEach(filteredEntries) { entry in
                    WaterConsumptionCardView(
                        title: entry.title,
                        time: entry.date.germanFormatted,
                        amount: "\(Int(entry.amount)) ml"
                    )
                }
            }
        }
    }
}

struct WaterConsumptionCardView: View {
    var title: String
    var time: String
    var amount: String
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color.gray.opacity(0.15))
                    .frame(width: 44, height: 44)
                
                Image(systemName: AppIcons.cupAndSaucerFill)
                    .foregroundColor(.black)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                
                Text(time)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Text(amount)
                .font(.system(size: 18, weight: .bold))
        }
        .padding()
        .background(Color.gray.opacity(0.08))
        .cornerRadius(20)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    WaterConsumptionCardView(
        title: "Water",
        time: Date().germanFormatted,
        amount: "1000"
    )
}
