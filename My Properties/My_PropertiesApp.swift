//
//  My_PropertiesApp.swift
//  My Properties
//
//  Created by Juan Camilo  Mejia Soto on 5/04/25.
//

import SwiftUI
import SwiftData
import GoogleMaps
import GooglePlaces

@main
struct My_PropertiesApp: App {
    
    init() {
        GMSServices.provideAPIKey(Constants.GoogleMaps.apiKeyFormGoogleMaps)
        GMSPlacesClient.provideAPIKey(Constants.GoogleMaps.apiKeyFormGoogleMaps)
    }

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: .init())
        }
    }
}
