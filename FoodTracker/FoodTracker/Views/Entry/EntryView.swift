//
//  EntryListView.swift
//  FoodTracker
//
//  Created by Marco Antonio Martiniano on 17.02.26.
//

import SwiftUI

struct EntryView: View {
    @Binding var entries: [Entry]
    @Binding var showAlert: Bool
    @Binding var showAddSheet: Bool
    
    var body: some View {
        List {
            ForEach(MealCategory.allCases) { category in
                let itemsInCategory = entries.filter { $0.category == category }

                Section(category.rawValue) {
                    ForEach(itemsInCategory) { item in
                        NavigationLink {
                            DetailView(entry: item)
                        } label: {
                            EntryItemView(entryItem: item)
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                if let index = entries.firstIndex(where: { $0.id == item.id }) {
                                    entries.remove(at: index)
                                }
                            } label: {
                                Label("Löschen", systemImage: AppIcons.trash)
                            }
                        }
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Einträge")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Button {
                        showAddSheet = true
                    } label: {
                        Label("Neuer Eintrag", systemImage: AppIcons.plus)
                    }

                    Button(role: .destructive) {
                        showAlert = true
                    } label: {
                        Label("Alles löschen", systemImage: AppIcons.trash)
                    }

                } label: {

                    Image(systemName: AppIcons.ellipsisCircle)
                        .font(.title2)
                }
            }
        }
        .alert("Bist du sicher, dass du alle Einträge löschen möchtest?", isPresented: $showAlert) {
            Button("Abbrechen", role: .cancel) {}
            Button("Löschen", role: .destructive) {
                entries.removeAll()
            }
        }
    }
}

#Preview {
    EntryView(
        entries: .constant(InitiaEntryData.entries),
        showAlert: .constant(false),
        showAddSheet: .constant(false),
    )
}
