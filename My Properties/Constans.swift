//
//  Constans.swift
//  My Properties
//
//  Created by Juan Camilo  Mejia Soto on 8/04/25.
//

import Foundation
import SwiftUI

struct Constants {
    
    struct GoogleMaps {
        static let apiKeyFormGoogleMaps = "AIzaSyDHsBX92619b3kC30QY1goo4WnLq2PtTm4"
    }
    
    struct PreviewsForViewSample {
        static let propertyDetail = PropertyModel(
            identifier: UUID(),
            propertyTitle: "Apartamento moderno",
            propertyType: "Apartamento",
            propertyDetails: "Hermoso apartamento en el centro",
            maximumNumberOfGuests: 4,
            numberOfBeds: 2,
            numberOfBathrooms: 1,
            propertyPhotos: [
                UIImage(named: "Property"),
                UIImage(named: "Property"),
                UIImage(named: "Property")
            ].compactMap { $0 },
            ubication: "Bogotá, Colombia",
            latitude: 4.7110,
            longitude: -74.0721
        )
    }
}
