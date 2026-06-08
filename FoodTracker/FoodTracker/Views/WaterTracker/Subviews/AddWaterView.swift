//
//  AddWaterView.swift
//  FoodTracker
//
//  Created by Marco Antonio Martiniano on 23.02.26.
//

import SwiftUI

struct AddWaterView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var date: Date = Date()
    @State private var amount: String = ""
    
    var onSave: (Entry) -> Void
    
    var body: some View {
        NavigationStack {
            Form {

                Section {
                    VStack(spacing: 10) {
                        
                        Image(systemName: AppIcons.dropFill)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, height: 70)
                            .foregroundStyle(.blue.gradient)
                        
                        VStack(spacing: 4)  {
                            Text("Trinke genug Wasser")
                                .font(.headline)
                            
                            Text("Empfohlen: 2000 ml pro Tag")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                }
                .listRowBackground(Color.clear)
                
                
                WaterGeneralSection(date: $date)
                WaterAmountSection(amount: $amount)
                
                WaterSaveSection(
                    isDisabled: Double(amount) == nil,
                    onSave: saveWater
                )
            }
            .navigationTitle("Wasser hinzufügen")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Label("Abbrechen", systemImage: AppIcons.xmark)
                    }
                }
            }
        }
    }
    
    private func saveWater() {
        guard let amountDouble = Double(amount) else { return }
        
        let entry =  Entry(
            title: "Wasser",
            date: Date(),
            calories: 0,
            drink: Drink(type: .water),
            amount: amountDouble
        )
            
        onSave(entry)
        dismiss()
    }
}

private struct WaterGeneralSection: View {
    @Binding var date: Date
    
    var body: some View {
        Section("Allgemein") {
            DatePicker(
                "Datum und Uhrzeit",
                selection: $date
            )
        }
    }
}

private struct WaterAmountSection: View {
    @Binding var amount: String
    
    var body: some View {
        Section("Menge") {
            HStack {
                Text("Wasser (ml)")
                Spacer()
                TextField("250", text: $amount)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
            }
        }
    }
}

private struct WaterSaveSection: View {
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
    AddWaterView(onSave: {_ in })
}
