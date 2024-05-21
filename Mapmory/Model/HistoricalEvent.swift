//
//  HistoricalEvent.swift
//  Mapmory
//
//  Created by Dixon Willow on 21/05/24.
//

import Foundation
import SwiftData

@Model
class HistoricalEvent {
    var eventName: String
    var eventYear: String
    var eventDesc: String
    var eventAspect: String
    
    @Relationship var eventLocation: Location?
    
    init(eventName: String, eventYear: String, eventDesc: String, eventAspect: String, eventLocation: Location? = nil) {
        self.eventName = eventName
        self.eventYear = eventYear
        self.eventDesc = eventDesc
        self.eventAspect = eventAspect
        self.eventLocation = eventLocation
    }
    
}
