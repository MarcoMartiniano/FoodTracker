//
//  HomeView.swift
//  FoodTracker
//
//  Created by Marco Antonio Martiniano on 17.02.26.
//

import SwiftUI

struct RootView: View {
    @State var entries: [Entry] = AllInitialEntries.entries
   // @State var entries: [Entry] = []
    @State private var showAlert = false
    @State private var showAddSheet = false
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            
            NavigationStack {
                EntryView(
                    entries: $entries,
                    showAlert: $showAlert,
                    showAddSheet: $showAddSheet
                )
            }
            .tabItem {
                Label("Einträge", systemImage: AppIcons.listBullet)
            }
            .tag(0)
            
            DashboardView(
                entries: $entries,
                selectedTab: $selectedTab
            )
            .tabItem {
                Label("Übersicht", systemImage: AppIcons.chartBarFill)
            }
            .tag(1)
            
            WaterTrackerView(entries: $entries)
                .tabItem {
                    Label("Wasser", systemImage: AppIcons.dropFill)
                }
                .tag(2)
        }
        .sheet(isPresented: $showAddSheet) {
            AddEntrySheet { newEntry in
                entries.insert(newEntry, at: 0)
            }
            .presentationDetents([.fraction(0.8)])
        }
    }
}

#Preview {
    RootView()
}
