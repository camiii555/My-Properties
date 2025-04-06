//
//  PropertyLocationSectionView.swift
//  My Properties
//
//  Created by Juan Camilo  Mejia Soto on 8/04/25.
//

import SwiftUI
import GoogleMaps
import GooglePlaces

struct PropertyLocationSectionView: View {
    
    @Binding var showMap: Bool
    @Binding var selectedAddress: String
    
    var body: some View {
        Section(header: Text("Ubicación de la propiedad")) {
            Button {
                showMap.toggle()
            } label: {
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                    Text(selectedAddress.isEmpty ? "Seleccionar ubicación" : selectedAddress)
                }
            }
        }
    }
}

#Preview {
    
    @Previewable @State var showMap: Bool = false
    @Previewable @State var selectedAddress: String = ""
    @Previewable @State var selectedCoordinate: CLLocationCoordinate2D?
    
    Form {
        PropertyLocationSectionView(
            showMap: $showMap,
            selectedAddress: $selectedAddress
        )
    }
    .sheet(isPresented: $showMap) {
        MapPickerView(selectedAddress: $selectedAddress, selectedCoordinate: $selectedCoordinate)
    }
}
    
