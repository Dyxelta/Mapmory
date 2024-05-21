//
//  Location.swift
//  Mapmory
//
//  Created by Dixon Willow on 21/05/24.
//

import Foundation
import SwiftData

@Model
class Location: Identifiable {
    @Attribute(.unique) var cityName: String
    var cityDescription: String
    
    @Relationship(inverse: \HistoricalEvent.eventLocation) var events: [HistoricalEvent]
    
    init(cityName: String, cityDescription: String) {
        self.cityName = cityName
        self.cityDescription = cityDescription
        self.events = []
    }
}
