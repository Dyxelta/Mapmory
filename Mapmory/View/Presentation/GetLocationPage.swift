//
//  GetLocationPage.swift
//  Mapmory
//
//  Created by Dixon Willow on 21/05/24.
//

import SwiftUI
import MapKit
import CoreLocation

struct GetLocationPage: View {
    
    @StateObject private var locationManager = LocationManager()
    
    @State private var selectedCoordinate: CLLocationCoordinate2D?
    
    @State private var showHistoricalEventModal = false
    @State private var showLocationErrorAlert = false
    @State private var isAddPin = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            MapView(selectedCoordinate: $selectedCoordinate, isAddPin: $isAddPin)
                .ignoresSafeArea(.all)
            
            Button(action: {
                locationManager.getLocation()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if locationManager.cityName == "Unknown" {
                        showLocationErrorAlert = true
                    } else {
                        showHistoricalEventModal = true
                    }
                }
            }) {
                Text("Get from current location")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
            .opacity(showHistoricalEventModal ? 0 : 1)
            
            if isAddPin, let coordinate = selectedCoordinate {
                PinNavigationModal(
                    removePinAction: {
                        selectedCoordinate = nil
                        isAddPin = false
                    },
                    navigateAction: {
                        locationManager.reverseMapGeocode(coordinate: coordinate)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            if locationManager.cityName == "Unknown" {
                                showLocationErrorAlert = true
                            } else {
                                showHistoricalEventModal = true
                                isAddPin = false
                            }
                        }
                    }
                )
                .transition(.move(edge: .bottom))
                .ignoresSafeArea(edges: .bottom)
            }
        }
        .sheet(isPresented: $showHistoricalEventModal, content: {
            HistoricalEventModal(cityName: locationManager.cityName)
        })
        .alert(isPresented: $showLocationErrorAlert) {
            Alert(
                title: Text("Location error"),
                message: Text("Cannot get the location properly"),
                dismissButton: .default(Text("Dismiss"))
            )
        }
    }
}

#Preview {
    GetLocationPage()
}
