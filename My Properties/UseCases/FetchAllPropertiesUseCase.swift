//
//  FetchAllPropertiesUseCase.swift
//  My Properties
//
//  Created by Juan Camilo  Mejia Soto on 8/04/25.
//

import Foundation

protocol FetchAllPropertiesUseCaseProtocol {
    func fetchAllProperties() throws -> [PropertyModel]
}

struct FetchAllPropertiesUseCase: FetchAllPropertiesUseCaseProtocol {
    
    var propertiesDataBase: PropertiesDataBaseProtocol
    
    init(propertiesDataBase: PropertiesDataBaseProtocol = PropertiesDataBase.shared) {
        self.propertiesDataBase = propertiesDataBase
    }

    func fetchAllProperties() throws -> [PropertyModel] {
        try propertiesDataBase.fetchAll()
    }
}
