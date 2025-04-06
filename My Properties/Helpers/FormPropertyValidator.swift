//
//  FormPropertyValidator.swift
//  My Properties
//
//  Created by Juan Camilo  Mejia Soto on 9/04/25.
//

import Foundation
import GoogleMaps


struct FormPropertyValidator {
    static func validate(
        title: String,
        description: String,
        address: String,
        coordinate: CLLocationCoordinate2D?,
        photos: [UIImage]
    ) -> String? {
        
        if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return "El título de la propiedad es obligatorio."
        }
        
        if description.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return "La descripción de la propiedad es obligatoria."
        }
        
        if address.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return "La dirección de la propiedad es obligatoria."
        }
        
        if coordinate == nil {
            return "Debes seleccionar la ubicación en el mapa."
        }
        
        if photos.isEmpty || photos.count < 5 {
            return "Debes agregar al menos 5 fotos de la propiedad."
        }
        
        return nil
    }
}
