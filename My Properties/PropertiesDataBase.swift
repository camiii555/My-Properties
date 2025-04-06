//
//  PropertiesDataBase.swift
//  My Properties
//
//  Created by Juan Camilo  Mejia Soto on 8/04/25.
//

import Foundation
import SwiftData


enum DataBaseError: Error {
    case errorInsert
    case errorFetch
    case errorUpdate
    case errorRemove
}

protocol PropertiesDataBaseProtocol {
    func insert(property: PropertyModel) throws
    func fetchAll() throws -> [PropertyModel]
    func update(property: PropertyModel) throws
    func remove(propertyIdentifier: UUID) throws
}

class PropertiesDataBase: @preconcurrency PropertiesDataBaseProtocol {
    
    static let shared =  PropertiesDataBase()
    
    @MainActor
    let container: ModelContainer = setupContainer(inMemory: false)
    
    private init() {}
    
    @MainActor
    static func setupContainer(inMemory: Bool) -> ModelContainer {
        do {
            let container = try ModelContainer(for: PropertyModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: inMemory))
            
            container.mainContext.autosaveEnabled = true
            return container
            
        } catch {
            print("Error: \(error.localizedDescription)")
            fatalError("Database can't be created")
        }
    }
    
    @MainActor
    func insert(property: PropertyModel) throws {
        container.mainContext.insert(property)
        do {
            try container.mainContext.save()
        } catch {
            print("Error: \(error.localizedDescription)")
            throw DataBaseError.errorInsert
        }
    }
    
    @MainActor
    func fetchAll() throws -> [PropertyModel] {
        let fecthDescriptor = FetchDescriptor<PropertyModel>(sortBy: [SortDescriptor<PropertyModel>(\.identifier)])
        do {
            return try container.mainContext.fetch(fecthDescriptor)
        } catch {
            print("Error: \(error.localizedDescription)")
            throw DataBaseError.errorFetch
        }
    }
    
    
    @MainActor
    func update(property: PropertyModel) throws {
        
        let propertyID = property.identifier
        let propertyPredicate = #Predicate<PropertyModel> {
            $0.identifier == propertyID
        }

        var fetchDescriptor = FetchDescriptor<PropertyModel>(predicate: propertyPredicate)
        fetchDescriptor.fetchLimit = 1
        
        do {
            guard let updateProperty = try container.mainContext.fetch(fetchDescriptor).first else {
                throw DataBaseError.errorUpdate
            }
            
            updateProperty.propertyTitle = property.propertyTitle
            updateProperty.propertyDetails = property.propertyDetails
            updateProperty.propertyType = property.propertyType
            updateProperty.maximumNumberOfGuests = property.maximumNumberOfGuests
            updateProperty.numberOfBeds = property.numberOfBeds
            updateProperty.numberOfBathrooms = property.numberOfBathrooms
            updateProperty.propertyPhotos = property.propertyPhotos
            updateProperty.ubication = property.ubication
            updateProperty.latitude = property.latitude
            updateProperty.longitude = property.longitude
            
            try container.mainContext.save()
            
        } catch {
            print("Error: \(error.localizedDescription)")
            throw DataBaseError.errorUpdate
        }
    }
    
    @MainActor
    func remove(propertyIdentifier: UUID) throws {
        let propertyPredicate = #Predicate<PropertyModel> {
            $0.identifier == propertyIdentifier
        }
        
        var fetchDescriptor = FetchDescriptor(predicate: propertyPredicate)
        fetchDescriptor.fetchLimit = 1
        
        do {
            guard let deleteProperty = try container.mainContext.fetch(fetchDescriptor).first else {
                throw DataBaseError.errorRemove
            }
            container.mainContext.delete(deleteProperty)
            try container.mainContext.save()
            
        } catch {
            print("Error: \(error.localizedDescription)")
            throw DataBaseError.errorRemove
        }
    }
}
