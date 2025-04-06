//
//  PropertyDetailsSectionView.swift
//  My Properties
//
//  Created by Juan Camilo  Mejia Soto on 8/04/25.
//

import SwiftUI

struct PropertyDetailsSectionView: View {
    
    @Binding var propertyTitle: String
    @Binding var propertyDetails: String
    @Binding var propertyType: String
    @Binding var numberOfGuests: Int
    @Binding var numberOfBedrooms: Int
    @Binding var numberOfBathrooms: Int
    
    private let propertyTypes: [String] = ["Apartamento", "Casa"]
    private let numberOfGuestsOptions: [Int] = Array(1...10)
    private let numberOfBedroomsOptions: [Int] = Array(1...10)
    private let numberOfBathroomsOptions: [Int] = Array(1...5)
    
    var body: some View {
        Section(header: Text("Datos de la propiedad")) {
            TextField("*Titulo de la propiedad", text: $propertyTitle)
           
            VStack(alignment: .leading) {
                Text("Descripción de la propiedad:")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $propertyDetails)
                        .padding(8)
                        .background(Color(.secondarySystemBackground))
                }
                .frame(height: 150)
            }
            
            Picker("Tipo de propiedad", selection: $propertyType) {
                ForEach(propertyTypes, id: \.self) { type in
                    Text(type)
                }
            }
            .pickerStyle(.menu)
            
            Picker("Huéspedes", selection: $numberOfGuests) {
                ForEach(numberOfGuestsOptions, id: \.self) { number in
                    Text("\(number)")
                }
            }
            .pickerStyle(.menu)
            
            Picker("Camas", selection: $numberOfBedrooms) {
                ForEach(numberOfBedroomsOptions, id: \.self) { number in
                    Text("\(number)")
                }
            }
            .pickerStyle(.menu)
            
            Picker("Baños", selection: $numberOfBathrooms) {
                ForEach(numberOfBathroomsOptions, id: \.self) { number in
                    Text("\(number)")
                }
            }
            .pickerStyle(.menu)
        }
    }
}

#Preview {
    
    @Previewable @State var propertyTitle: String = ""
    @Previewable @State var propertyDescription: String = ""
    @Previewable @State var propertyType: String = "Casa"
    @Previewable @State var numberOfGuest: Int = 1
    @Previewable @State var numberOfBedrooms: Int = 1
    @Previewable @State var numberOfBathrooms: Int = 1
    
    Form {
        PropertyDetailsSectionView(propertyTitle: $propertyTitle, propertyDetails: $propertyDescription, propertyType: $propertyType, numberOfGuests: $numberOfGuest, numberOfBedrooms: $numberOfBedrooms, numberOfBathrooms: $numberOfBathrooms)
    }
}
