//
//  RemovePropertyUseCase.swift
//  My Properties
//
//  Created by Juan Camilo  Mejia Soto on 9/04/25.
//

import Foundation

protocol RemovePropertyUseCaseProtocol {
    func removeProperty(identifier: UUID) throws
}

struct RemovePropertyUseCase: RemovePropertyUseCaseProtocol {
    
    var propertiesDataBase: PropertiesDataBaseProtocol
    
    init(propertiesDataBase: PropertiesDataBaseProtocol = PropertiesDataBase.shared) {
        self.propertiesDataBase = propertiesDataBase
    }
    
    func removeProperty(identifier: UUID) throws {
        try propertiesDataBase.remove(propertyIdentifier: identifier)
    }
}
