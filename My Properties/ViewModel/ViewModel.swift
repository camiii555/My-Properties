//
//  ViewModel.swift
//  My Properties
//
//  Created by Juan Camilo  Mejia Soto on 7/04/25.
//

import Foundation
import Observation

@Observable
class ViewModel {
    
    var properties: [PropertyModel]
    var dataBaseError: DataBaseError?
    
    var createPropertyUseCase: CreatePropertyProtocol
    var fetchAllPropertiesUseCase: FetchAllPropertiesUseCaseProtocol
    var updatedPropertyUseCase: UpdatePropertyUseCaseProtocol
    var removePropertyUseCase: RemovePropertyUseCaseProtocol
    
    init(
        properties: [PropertyModel] = [],
        createPropertyUseCase: CreatePropertyProtocol = CreatePropertyUseCase(),
        fetchAllPropertiesUseCase: FetchAllPropertiesUseCaseProtocol = FetchAllPropertiesUseCase(),
        updatePropertyUseCase: UpdatePropertyUseCaseProtocol = UpdatePropertyUseCase(),
        removePropertyUseCase: RemovePropertyUseCaseProtocol = RemovePropertyUseCase()
    ){
        self.properties = properties
        self.fetchAllPropertiesUseCase = fetchAllPropertiesUseCase
        self.createPropertyUseCase = createPropertyUseCase
        self.updatedPropertyUseCase = updatePropertyUseCase
        self.removePropertyUseCase = removePropertyUseCase
        self.fetchAllProperties()
    }
    
    func addProperty(property: PropertyModel) {
        do {
            try createPropertyUseCase.createPropertyWith(property: property)
            fetchAllProperties()
        } catch let error as DataBaseError {
            print("Error: \(error.localizedDescription)")
            dataBaseError = error
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func fetchAllProperties() {
        do {
            properties = try fetchAllPropertiesUseCase.fetchAllProperties()
        } catch let error as DataBaseError {
            print("Error: \(error.localizedDescription)")
            dataBaseError = error
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func updatePropertyWith(property: PropertyModel) {
        do {
            try updatedPropertyUseCase.updatePropertyWith(property: property)
        } catch let error as DataBaseError {
            print("Error: \(error.localizedDescription)")
            dataBaseError = error
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func removePropertyWith(identifier: UUID) {
        do {
            try removePropertyUseCase.removeProperty(identifier: identifier)
            fetchAllProperties()
        } catch let error as DataBaseError {
            print("Error: \(error.localizedDescription)")
            dataBaseError = error
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
