//
//  DetailView.swift
//  FoodTracker
//
//  Created by Marco Antonio Martiniano on 19.02.26.
//

import SwiftUI

struct DetailView: View {
    
    let entry: Entry
    
    var body: some View {
        List {
            
            // MARK: - Header
            Section {
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text(entry.title)
                        .font(.title2)
                        .bold()
                    
                    Text(entry.category.rawValue)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding(.vertical, 4)
            }
            
            // MARK: - Info Section
            Section("Informationen") {
                
                HStack {
                    Label("Datum", systemImage: AppIcons.calendar)
                    Spacer()
                    Text(entry.date.germanFormatted)
                        .foregroundStyle(.secondary)
                }
                
                HStack {
                    Label("Kalorien", systemImage: AppIcons.flameFill)
                    Spacer()
                    
                    Text("\(entry.calories) kcal")
                        .fontWeight(.semibold)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(entry.calorieColor)
                        .foregroundStyle(.white)
                        .cornerRadius(8)
                }
                
                    HStack {
                        Label("Menge", systemImage: AppIcons.scalemass)
                        Spacer()
                        Text(entry.formattedAmount)
                            .foregroundStyle(.secondary)
                    }
                
            }
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }

}

#Preview {
    DetailView(entry: entryItemHauptgericht)
}
