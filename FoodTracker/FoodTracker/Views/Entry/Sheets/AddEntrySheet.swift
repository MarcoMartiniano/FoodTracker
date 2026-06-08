//
//  AddEntryView.swift
//  FoodTracker
//
//  Created by Marco Antonio Martiniano on 18.02.26.
//

import SwiftUI

struct AddEntrySheet: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    @State private var date: Date = Date()
    @State private var calories: String = ""
    @State private var amount: String = ""
    @State private var category: MealCategory = .hauptgericht
    @State private var selectedDrinkType: DrinkType = .water
    
    var onSave: (Entry) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                GeneralSection(title: $title, date: $date)
                
                DetailsSection(
                    category: $category,
                    selectedDrinkType: $selectedDrinkType,
                    calories: $calories,
                    amount: $amount
                )
                
                SaveSection(
                    isDisabled: title.isEmpty
                        || Int(calories) == nil
                        || Double(amount) == nil,
                    onSave: saveEntry
                )
            }
            .navigationTitle("Neuer Eintrag")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Label("Abbrechen", systemImage: AppIcons.xmark)
                    }
                }
            }
            .onChange(of: category) {
                if category != .getraenk {
                    selectedDrinkType = .water
                }
                updateCaloriesIfNeeded()
            }
            .onChange(of: selectedDrinkType) {
                updateCaloriesIfNeeded()
            }
        }
    }
    
    // MARK: - Auto calories logic
    
    private func updateCaloriesIfNeeded() {
        if category == .getraenk && selectedDrinkType == .water{
            calories = "0"
        }
    }
    
    // MARK: - Save
    
    private func saveEntry() {
        guard
            let caloriesInt = Int(calories),
            let amountDouble = Double(amount)
        else { return }
        
        let newEntry: Entry
        
        if category == .getraenk {
            newEntry = Entry(
                title: title,
                date: date,
                calories: caloriesInt,
                drink: Drink(type: selectedDrinkType),
                amount: amountDouble
            )
        } else {
            newEntry = Entry(
                title: title,
                date: date,
                calories: caloriesInt,
                category: category,
                amount: amountDouble
            )
        }
        print(newEntry)
        onSave(newEntry)
        dismiss()
    }
}

// MARK: - Subviews

private struct GeneralSection: View {
    @Binding var title: String
    @Binding var date: Date
    
    var body: some View {
        Section("Allgemein") {
            TextField("Titel", text: $title)
            
            DatePicker(
                "Datum und Uhrzeit",
                selection: $date
            )
        }
    }
}

private struct DetailsSection: View {
    @Binding var category: MealCategory
    @Binding var selectedDrinkType: DrinkType
    @Binding var calories: String
    @Binding var amount: String
    
    var body: some View {
        Section("Details") {
            
            Picker("Kategorie", selection: $category) {
                ForEach(MealCategory.allCases) { category in
                    Text(category.rawValue).tag(category)
                }
            }
            
            if category == .getraenk {
                Picker("Getränkeart", selection: $selectedDrinkType) {
                    ForEach(DrinkType.allCases) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
            }
            
            HStack {
                Text("Menge")
                Spacer()
                TextField(
                    category == .getraenk ? "ml" : "kg",
                    text: $amount
                )
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.trailing)
            }
            
            HStack {
                Text("Kalorien")
                Spacer()
                TextField("0", text: $calories)
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(
                        category == .getraenk && selectedDrinkType == .water
                        ? .gray
                        : .primary
                    )
            }
        }
    }
}

private struct SaveSection: View {
    var isDisabled: Bool
    var onSave: () -> Void
    
    var body: some View {
        Section {
            Button("Speichern") {
                onSave()
            }
            .disabled(isDisabled)
        }
    }
}

#Preview {
    AddEntrySheet(onSave: { _ in })
}


