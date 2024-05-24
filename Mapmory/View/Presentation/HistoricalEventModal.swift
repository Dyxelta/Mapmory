//
//  HistoricalEventModal.swift
//  Mapmory
//
//  Created by Dixon Willow on 21/05/24.
//

import SwiftUI
import SwiftData

struct HistoricalEventModal: View {
    
    var cityName: String
    
    @Query var locations: [Location]
    
    private var pickedLocation: Location {
        locations.first { $0.cityName == cityName } ?? Location(cityName: "Unknown", cityDescription: "Unknown")
    }
    
    @State private var expandedEvents: Set<String> = []
    
    var body: some View {
        if pickedLocation.cityName == "Unknown" {
            Text("Data unavailable")
                .font(.title)
                .padding()
            Text("We have no data about the historical event in this city yet, stay tuned!")
        } else {
            ScrollView {
                VStack {
                    Text(pickedLocation.cityName)
                        .font(.title)
                        .padding()
                    
                    Text(pickedLocation.cityDescription)
                        .padding()
                    
                    Divider()
                        .padding()
                    
                    ForEach(pickedLocation.events) { eventData in
                        VStack(alignment: .leading) {
                            HStack (alignment: .center){
                                Text("\(eventData.eventName) (\(eventData.eventYear)) - \(eventData.eventAspect)")
                                    .font(.headline)
                                
                                Spacer()
                                
                                Image(systemName: expandedEvents.contains(eventData.eventName) ? "chevron.up" : "chevron.down")
                                    .font(.body)
                            }
                            .padding(.vertical)
                            .frame(maxWidth: UIScreen.main.bounds.width)
                            .onTapGesture {
                                withAnimation {
                                    toggleExpansion(eventData.eventName)
                                }
                            }
                            
                            Divider()
                            
                            if expandedEvents.contains(eventData.eventName) {
                                Text(eventData.eventDesc)
                                    .padding(.vertical)
                            }
                        }
                        .padding()
                    }
                }
                .padding()
            }
        }
    }
    
    private func toggleExpansion(_ eventName: String) {
        if expandedEvents.contains(eventName) {
            expandedEvents.remove(eventName)
        } else {
            expandedEvents.insert(eventName)
        }
    }
}

#Preview {
    HistoricalEventModal(cityName: "Sample")
}
