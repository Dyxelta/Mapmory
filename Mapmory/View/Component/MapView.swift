//
//  MapView.swift
//  Mapmory
//
//  Created by Dixon Willow on 21/05/24.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    @Binding var selectedCoordinate: CLLocationCoordinate2D?
    @Binding var isAddPin: Bool
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var map: MapView
        
        init(parent: MapView) {
            self.map = parent
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is MKUserLocation {
                return nil
            }
            
            let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            annotationView.canShowCallout = true
            annotationView.animatesWhenAdded = true
            
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            guard let coordinate = view.annotation?.coordinate else { return }
            
            map.selectedCoordinate = coordinate
            map.isAddPin = true
        }
        
        @objc func handleLongPress(gestureRecognizer: UIGestureRecognizer) {
            guard gestureRecognizer.state == .began else { return }
            guard let mapView = gestureRecognizer.view as? MKMapView else { return }
            
            let location = gestureRecognizer.location(in: mapView)
            let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
            
            map.selectedCoordinate = coordinate
            map.isAddPin = true
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        mapView.mapType = .mutedStandard
        
        mapView.pointOfInterestFilter = MKPointOfInterestFilter(excluding: [.airport, .amusementPark, .aquarium, .atm, .bakery, .bank, .beach, .brewery, .cafe, .campground, .carRental, .evCharger, .fireStation, .fitnessCenter, .foodMarket, .gasStation, .hospital, .hotel, .laundry, .library, .marina, .movieTheater, .museum, .nationalPark, .nightlife, .park, .parking, .pharmacy, .police, .postOffice, .publicTransport, .restaurant, .school, .stadium, .store, .theater, .university, .zoo])
        
        let longPressGesture = UILongPressGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleLongPress(gestureRecognizer:)))
        mapView.addGestureRecognizer(longPressGesture)
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        if let coordinate = selectedCoordinate {
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            
            uiView.removeAnnotations(uiView.annotations)
            uiView.addAnnotation(annotation)
            uiView.setCenter(coordinate, animated: true)
        } else {
            uiView.removeAnnotations(uiView.annotations)
        }
    }
}

#Preview {
    MapView(selectedCoordinate: .constant(nil), isAddPin: .constant(false))
}
