//
//  DataSeeder.swift
//  Mapmory
//
//  Created by Dixon Willow on 21/05/24.
//

import Foundation
import SwiftData

struct DataSeeder {
    
    let locationsData = [
        Location(
            cityName: "Tangerang",
            cityDescription: "Tangerang City is a city located in Banten Province, Indonesia. The city is located just west of DKI Jakarta. Its indigenous population is Sundanese. At the end of 2023, the total population of Tangerang city was 1,912,679 with a density of 12,000 people/km2. Tangerang is the largest city in Banten Province, and the third largest in the Greater Jakarta metropolitan area after Bekasi City and Depok City."
        ),
        Location(
            cityName: "Cilegon",
            cityDescription: "Cilegon City is a city located in Banten Province, Indonesia. The city is also located in the western part of Java Island, precisely on the edge of the Sunda Strait. The city is known as the \"Kota Baja\", due to the presence of the Indonesian government-owned steel industry, Krakatau Steel. The city is located in the Greater Serang metropolitan area. Previously, Cilegon City was an administrative city that covered the entire area of the current Cilegon City, until the city changed its status to an autonomous city on April 27, 1999."
        )
    ]
    
    let eventsData = [
        (
            eventName: "The violence of Pasukan Ubel-ubel",
            eventYear: "1945 - 1946",
            eventDesc: "Tangerang's Regent hesitation about accepting the news of the Proclamation of Independence sparked uncertainty and unrest. The Tangerang Regional KNI replaced Agus Padmanegara with Haji Achmad Chairun, forming the Tangerang Governing Council which then faced violence from the Laskar Hitam group. The Tangerang Council government was ineffective, triggering a crackdown operation by the Tangerang TKR Regiment who arrested and executed Council leaders, then formed a new government according to the structure of the Regional Government of the Republic of Indonesia.",
            eventAspect: "Social and Politic",
            eventCityName: "Tangerang"
        ),
        (
            eventName: "The opening of Soekarno-Hatta International Airport",
            eventYear: "1985",
            eventDesc: "The needs of bigger international airport to accommodate the growth of passengers and cargo is the reasons behind Soekarno-Hatta International Airport to be built. After it is built it easily become the main gate of international and domestic flight in Indonesia",
            eventAspect: "Economic",
            eventCityName: "Tangerang"
        ),
        (
            eventName: "Geger Cilegon",
            eventYear: "1888",
            eventDesc: "Ki Wasyid's fatwa on shirk, the 1883 eruption of Mount Krakatau, the banning of the Prophet's shalawat, the Dutch demand that the people kill all their buffaloes and the Dutch disdain for religious activities underpinned the Cilegon uprising. Until finally on July 9, 1888, the rebellion led by Ki Wasyid attacked the Dutch resident, divided the troops, and committed acts of violence against colonial officials and released political prisoners. Nonetheless, the rebellion was suppressed by the colonial army, leading to the arrest, banishment and hunting of religious teachers, hajjis and ulama, causing resentment and trauma among the Dutch.",
            eventAspect: "Social",
            eventCityName: "Cilegon"
        )
    ]
    
    func seedData(in context: ModelContext) {
        guard !isDataSeeded else { return }

        var locationDictionary: [String: Location] = [:]

        for locationData in locationsData {
            do {
                context.insert(locationData)
                try context.save()
                locationDictionary[locationData.cityName] = locationData
            } catch {
                print("Error seeding location data \(locationData.cityName): \(error.localizedDescription)")
            }
        }

        for eventData in eventsData {
            guard let location = locationDictionary[eventData.eventCityName] else {
                print("Error: Location for \(eventData.eventName) not found.")
                continue
            }

            let event = HistoricalEvent(
                eventName: eventData.eventName,
                eventYear: eventData.eventYear,
                eventDesc: eventData.eventDesc,
                eventAspect: eventData.eventAspect,
                eventLocation: location
            )

            do {
                context.insert(event)
                try context.save()
            } catch {
                print("Error seeding event data \(event.eventName): \(error.localizedDescription)")
            }
        }

        setDataSeeded()
    }
    
    private var isDataSeeded: Bool {
        return UserDefaults.standard.bool(forKey: "isDataSeeded")
    }
    
    private func setDataSeeded() {
        UserDefaults.standard.set(true, forKey: "isDataSeeded")
    }
}

