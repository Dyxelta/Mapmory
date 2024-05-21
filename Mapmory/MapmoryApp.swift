//
//  MapmoryApp.swift
//  Mapmory
//
//  Created by Dixon Willow on 21/05/24.
//

import SwiftUI
import SwiftData

@main
struct MapmoryApp: App {
    
    var context: ModelContext
    
    init() {
        let modelContainer = try? ModelContainer(for: Location.self, HistoricalEvent.self)
        context = ModelContext(modelContainer!)
        
        let seeder = DataSeeder()
        seeder.seedData(in: context)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.modelContext, context)
        }
        .modelContainer(for: Location.self)
    }
}
