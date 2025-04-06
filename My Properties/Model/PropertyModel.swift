//
//  PropertyModel.swift
//  My Properties
//
//  Created by Juan Camilo  Mejia Soto on 5/04/25.
//

import Foundation
import SwiftData
import SwiftUI


@Model
class PropertyModel: Identifiable, Hashable {
    
    @Attribute(.unique)
    var identifier: UUID
    var propertyTitle: String
    var propertyType: String
    
    @Attribute(originalName: "propertyDescription")
    var propertyDetails: String
    
    var maximumNumberOfGuests: Int
    var numberOfBeds: Int
    var numberOfBathrooms: Int
    var propertyPhotosData: [Data]
    
    var ubication: String?
    var latitude: Double?
    var longitude: Double?
    
    var getLatitude: Double {
        latitude ?? 0.0
    }
    
    var getLongitude: Double {
        longitude ?? 0.0
    }
    
    var getUbication: String {
        ubication ?? ""
    }
    
    var propertyPhotos: [UIImage] {
        get {
            propertyPhotosData.compactMap { UIImage(data: $0) }
        }
        set {
            propertyPhotosData = newValue.compactMap { $0.jpegData(compressionQuality: 0.8) }
        }
    }
    
    init(
        identifier: UUID = UUID(),
        propertyTitle: String,
        propertyType: String,
        propertyDetails: String,
        maximumNumberOfGuests: Int,
        numberOfBeds: Int,
        numberOfBathrooms: Int,
        propertyPhotos: [UIImage],
        ubication: String?,
        latitude: Double?,
        longitude: Double?
    ) {
        self.identifier = identifier
        self.propertyTitle = propertyTitle
        self.propertyType = propertyType
        self.propertyDetails = propertyDetails
        self.maximumNumberOfGuests = maximumNumberOfGuests
        self.numberOfBeds = numberOfBeds
        self.numberOfBathrooms = numberOfBathrooms
        self.propertyPhotosData = propertyPhotos.compactMap { $0.jpegData(compressionQuality: 0.8) }
        self.ubication = ubication
        self.latitude = latitude
        self.longitude = longitude
    }
}

