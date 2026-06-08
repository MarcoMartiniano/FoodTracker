//
//  EntryItemView.swift
//  FoodTracker
//
//  Created by Marco Antonio Martiniano on 17.02.26.
//

import SwiftUI

struct EntryItemView: View {
    var entryItem: Entry
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(entryItem.title)
                    .font(.system(size: 18))
                
                Text(entryItem.formattedAmount)
                    .font(.system(size: 14))
                    .fontWeight(.semibold)
                
                Text(entryItem.date.germanFormatted)
                    .font(.footnote)
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("\(entryItem.calories)\nKcal")
                    .font(.system(size: 12))
                    .bold()
                    .foregroundStyle(.white)
                    .padding()
                    .multilineTextAlignment(.center)
                    .background(entryItem.calorieColor)
                    .cornerRadius(8)
            }
        }
    }

}

#Preview {
    let entryItem: Entry = Entry(
        title: "Gemischter Salat mit Feta",
        date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
        calories: 400,
        category: .hauptgericht,
        amount: 200.0
    )
    
    EntryItemView(
        entryItem: entryItem
    )
}
