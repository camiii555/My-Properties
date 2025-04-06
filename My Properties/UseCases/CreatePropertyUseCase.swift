//
//  CreatePropertyUseCase.swift
//  My Properties
//
//  Created by Juan Camilo  Mejia Soto on 8/04/25.
//

import Foundation



protocol CreatePropertyProtocol {
    func createPropertyWith(property: PropertyModel) throws
}

struct CreatePropertyUseCase: CreatePropertyProtocol {
    
    var propertiesDataBase : PropertiesDataBaseProtocol
    
    init(propertiesDataBase: PropertiesDataBaseProtocol = PropertiesDataBase.shared) {
        self.propertiesDataBase = propertiesDataBase
    }
    
    func createPropertyWith(property: PropertyModel) throws {
        try propertiesDataBase.insert(property: property)
    }
}
