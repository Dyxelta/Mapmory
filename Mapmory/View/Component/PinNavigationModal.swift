//
//  PinNavigationModal.swift
//  Mapmory
//
//  Created by Dixon Willow on 21/05/24.
//

import SwiftUI
import CoreLocation

struct PinNavigationModal: View {
    var removePinAction: () -> Void
    var navigateAction: () -> Void
    
    var body: some View {
        VStack {
            Text("Get to know the history of where you pin")
                .font(.headline)
                .padding()
            
            Button(action: navigateAction) {
                Text("Get from pinned location")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.top)
            
            Button(action: removePinAction) {
                Text("Remove Pin")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
        }
        .frame(maxWidth: 500)
        .background(Color.white)
        .cornerRadius(16)
        .ignoresSafeArea(edges: .bottom)
    }
}
