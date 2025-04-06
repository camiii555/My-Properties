//
//  PropertyModelTest.swift
//  My PropertiesTests
//
//  Created by Juan Camilo  Mejia Soto on 9/04/25.
//

import XCTest

@testable import My_Properties
final class PropertyModelTest: XCTestCase {
    
    
    func testPropertyModelInitialization() {
        
        // Given
        let propertyTitle = "Apartamento moderno"
        let propertyType = "Apartamento"
        let propertyDetails = "Hermoso apartamento en el centro"
        let maximumNumberOfGuests =  4
        let numberOfBeds = 2
        let numberOfBathrooms = 1
        let propertyPhotos =  [
            UIImage(named: "Property"),
            UIImage(named: "Property"),
            UIImage(named: "Property")
        ].compactMap { $0 }
        let ubication = "Bogotá, Colombia"
        let latitude = 4.7110
        let longitude = -74.0721
        
        // When
        let property = PropertyModel(propertyTitle: propertyTitle, propertyType: propertyType, propertyDetails: propertyDetails, maximumNumberOfGuests: maximumNumberOfGuests, numberOfBeds: numberOfBeds, numberOfBathrooms: numberOfBathrooms, propertyPhotos: propertyPhotos, ubication: ubication, latitude: latitude, longitude: longitude)
        
        
        // Then
        XCTAssertEqual(property.propertyTitle, propertyTitle)
        XCTAssertEqual(property.propertyType, propertyType)
        XCTAssertEqual(property.propertyDetails, propertyDetails)
        XCTAssertEqual(property.maximumNumberOfGuests, maximumNumberOfGuests)
        XCTAssertEqual(property.numberOfBeds, numberOfBeds)
        XCTAssertEqual(property.numberOfBathrooms, numberOfBathrooms)
        XCTAssertEqual(property.ubication, ubication)
        XCTAssertEqual(property.latitude, latitude)
        XCTAssertEqual(property.longitude, longitude)
    }
    
    
    func testPropertyUbicationEmpty() {
        
        // Given
        let propertyTitle = "Apartamento moderno"
        let propertyType = "Apartamento"
        let propertyDetails = "Hermoso apartamento en el centro"
        let maximumNumberOfGuests =  4
        let numberOfBeds = 2
        let numberOfBathrooms = 1
        let propertyPhotos =  [
            UIImage(named: "Property"),
            UIImage(named: "Property"),
            UIImage(named: "Property")
        ].compactMap { $0 }
        let latitude = 4.7110
        let longitude = -74.0721
        
        
        // When
        let property = PropertyModel(propertyTitle: propertyTitle, propertyType: propertyType, propertyDetails: propertyDetails, maximumNumberOfGuests: maximumNumberOfGuests, numberOfBeds: numberOfBeds, numberOfBathrooms: numberOfBathrooms, propertyPhotos: propertyPhotos, ubication: nil, latitude: latitude, longitude: longitude)
        
        // Then
        XCTAssertEqual(property.getUbication, "", "No se ha especificado")
        
    }
    
    
    func testPropertyLatitudeEmpty() {
        
        // Given
        let propertyTitle = "Apartamento moderno"
        let propertyType = "Apartamento"
        let propertyDetails = "Hermoso apartamento en el centro"
        let maximumNumberOfGuests =  4
        let numberOfBeds = 2
        let numberOfBathrooms = 1
        let propertyPhotos =  [
            UIImage(named: "Property"),
            UIImage(named: "Property"),
            UIImage(named: "Property")
        ].compactMap { $0 }
        let ubication = "Bogotá, Colombia"
        let longitude = -74.0721
        
        // When
        let property = PropertyModel(propertyTitle: propertyTitle, propertyType: propertyType, propertyDetails: propertyDetails, maximumNumberOfGuests: maximumNumberOfGuests, numberOfBeds: numberOfBeds, numberOfBathrooms: numberOfBathrooms, propertyPhotos: propertyPhotos, ubication: ubication, latitude: nil, longitude: longitude)
        
        // Then
        XCTAssertEqual(property.getLatitude, 0.0, "No se ha especificado")
        
    }
    
    
    func testPropertyLongitudeEmpty() {
        
        // Given
        let propertyTitle = "Apartamento moderno"
        let propertyType = "Apartamento"
        let propertyDetails = "Hermoso apartamento en el centro"
        let maximumNumberOfGuests =  4
        let numberOfBeds = 2
        let numberOfBathrooms = 1
        let propertyPhotos =  [
            UIImage(named: "Property"),
            UIImage(named: "Property"),
            UIImage(named: "Property")
        ].compactMap { $0 }
        let ubication = "Bogotá, Colombia"
        let latitude = 4.7110
        
        // When
        let property = PropertyModel(propertyTitle: propertyTitle, propertyType: propertyType, propertyDetails: propertyDetails, maximumNumberOfGuests: maximumNumberOfGuests, numberOfBeds: numberOfBeds, numberOfBathrooms: numberOfBathrooms, propertyPhotos: propertyPhotos, ubication: ubication, latitude: latitude, longitude: nil)
        
        // Then
        XCTAssertEqual(property.getLongitude, 0.0, "No se ha especificado")
    }
    
    
    func testPropertyPhotosGetterAndSetter() {
        // Given
        guard let imageFortTest = UIImage(named: "Property") else {
            XCTFail("No se ha podido cargar la imagen de prueba")
            return
        }
        
        let propertyTitle = "Apartamento moderno"
        let propertyType = "Apartamento"
        let propertyDetails = "Hermoso apartamento en el centro"
        let maximumNumberOfGuests =  4
        let numberOfBeds = 2
        let numberOfBathrooms = 1
        let propertyPhotos =  [
            imageFortTest,
            imageFortTest,
            imageFortTest
        ].compactMap { $0 }
        let ubication = "Bogotá, Colombia"
        let latitude = 4.7110
        // When
        let property = PropertyModel(propertyTitle: propertyTitle, propertyType: propertyType, propertyDetails: propertyDetails, maximumNumberOfGuests: maximumNumberOfGuests, numberOfBeds: numberOfBeds, numberOfBathrooms: numberOfBathrooms, propertyPhotos: propertyPhotos, ubication: ubication, latitude: latitude, longitude: nil)
        //Then
        XCTAssertEqual(propertyPhotos.count, property.propertyPhotos.count)
        XCTAssertEqual(propertyPhotos.count, property.propertyPhotosData.count)
        for data in property.propertyPhotosData {
            XCTAssertNotNil(UIImage(data: data), "El data debe representar una imagen válida")
        }
    }
}
