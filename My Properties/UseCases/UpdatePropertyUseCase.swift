//
//  UpdatePropertyUseCase.swift
//  My Properties
//
//  Created by Juan Camilo  Mejia Soto on 9/04/25.
//

import Foundation

protocol UpdatePropertyUseCaseProtocol {
    func updatePropertyWith(property: PropertyModel) throws
}

struct UpdatePropertyUseCase: UpdatePropertyUseCaseProtocol {
    
    var porpertiesDataBase: PropertiesDataBaseProtocol
    
    init(porpertiesDataBase: PropertiesDataBaseProtocol = PropertiesDataBase.shared) {
        self.porpertiesDataBase = porpertiesDataBase
    }
    
    func updatePropertyWith(property: PropertyModel) throws {
        try porpertiesDataBase.update(property: property)
    }
}
