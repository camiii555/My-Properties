//
//  AddNewPropertyView.swift
//  My Properties
//
//  Created by Juan Camilo  Mejia Soto on 6/04/25.
//

import SwiftUI
import GoogleMaps

struct AddNewPropertyView: View {
    
    var viewModel: ViewModel
    
    @State var propertyTitle: String = ""
    @State var propertyDetails: String = ""
    @State var propertyType: String = "Apartamento"
    @State var numberOfGuests: Int = 1
    @State var numberOfBathrooms: Int = 1
    @State var numberOfBedrooms: Int = 1
    
    @State private var selectedAddress = ""
    @State private var selectedCoordinate: CLLocationCoordinate2D?
    @State private var showMap: Bool = false
    @State private var showImagePicker = false
    @State private var selectedImages: [UIImage] = []
    @State private var alertMessage = ""
    @State private var showAlert = false
    @State private var isLoading: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                
                PropertyDetailsSectionView(
                    propertyTitle: $propertyTitle,
                    propertyDetails: $propertyDetails,
                    propertyType: $propertyType,
                    numberOfGuests: $numberOfGuests,
                    numberOfBedrooms: $numberOfBedrooms,
                    numberOfBathrooms: $numberOfBathrooms
                )
                
                
                PropertyPhotosSectionView(
                    selectedImages: $selectedImages,
                    showImagePicker: $showImagePicker
                )
                
                PropertyLocationSectionView(showMap: $showMap, selectedAddress: $selectedAddress)
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(maxSelection: 10 - selectedImages.count) { images in
                    selectedImages.append(contentsOf: images)
                }
            }
            .sheet(isPresented: $showMap) {
                MapPickerView(selectedAddress: $selectedAddress, selectedCoordinate: $selectedCoordinate)
            }
            .alert("Faltan Campos", isPresented: $showAlert, actions: {
                Button("OK", role: .cancel) {}
            }, message: {
                Text("⚠️ \(alertMessage)")
                
            })
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle")
                            .font(.title3)
                            .foregroundColor(.red)
                    }
                }
                
                ToolbarItem {
                    Button {
                        
                        if let formError = FormPropertyValidator.validate(
                            title: propertyTitle,
                            description: propertyDetails,
                            address: selectedAddress,
                            coordinate: selectedCoordinate,
                            photos: selectedImages
                        ) {
                            self.alertMessage = formError
                            self.showAlert.toggle()
                            return
                        }
                        
                        isLoading = true
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            let property = PropertyModel(
                                identifier: UUID.init(),
                                propertyTitle: self.propertyTitle,
                                propertyType: self.propertyType,
                                propertyDetails: self.propertyDetails,
                                maximumNumberOfGuests: self.numberOfGuests,
                                numberOfBeds: self.numberOfBedrooms,
                                numberOfBathrooms: self.numberOfBathrooms,
                                propertyPhotos: self.selectedImages,
                                ubication: self.selectedAddress,
                                latitude: self.selectedCoordinate?.latitude,
                                longitude: self.selectedCoordinate?.longitude
                            )
                            
                            viewModel.addProperty(property: property)
                            isLoading = true
                            dismiss()
                        }
                        
                    } label: {
                        Text("Guardar")
                            .bold()
                    }
                }
            }
            .navigationTitle("Agregar Propiedad")
            .navigationBarTitleDisplayMode(.large)
        }
        
        if isLoading {
            LoadingView(text: "Guardando...")
        }
    }
}

#Preview {
    AddNewPropertyView(viewModel: .init())
}

