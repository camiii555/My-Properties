//
//  UpdatePropertyView.swift
//  My Properties
//
//  Created by Juan Camilo  Mejia Soto on 9/04/25.
//

import SwiftUI
import GoogleMaps

struct UpdatePropertyView: View {
    
    var viewModel: ViewModel
    var property: PropertyModel
    
    @State private var propertyTitle: String
    @State private var propertyDetails: String
    @State private var propertyType: String
    @State private var numberOfGuests: Int
    @State private var numberOfBathrooms: Int
    @State private var numberOfBedrooms: Int
    
    @State private var selectedAddress: String
    @State private var selectedCoordinate: CLLocationCoordinate2D?
    @State private var showMap: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var selectedImages: [UIImage]
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var isLoading: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    
    init(viewModel: ViewModel, property: PropertyModel, onDelete: (() -> Void)? = nil) {
        self.viewModel = viewModel
        self.property = property
        
        _propertyTitle = State(initialValue: property.propertyTitle)
        _propertyDetails = State(initialValue: property.propertyDetails)
        _propertyType = State(initialValue: property.propertyType)
        _numberOfGuests = State(initialValue: property.maximumNumberOfGuests)
        _numberOfBathrooms = State(initialValue: property.numberOfBathrooms)
        _numberOfBedrooms = State(initialValue: property.numberOfBeds)
        _selectedAddress = State(initialValue: property.getUbication)
        _selectedCoordinate = State(initialValue: CLLocationCoordinate2D(latitude: property.getLatitude, longitude: property.getLongitude))
        _selectedImages = State(initialValue: property.propertyPhotos)
    }
    
    var body: some View {
        ZStack {
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
                    
                    PropertyLocationSectionView(
                        showMap: $showMap,
                        selectedAddress: $selectedAddress
                    )
                }
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(maxSelection: 10 - selectedImages.count) { images in
                        selectedImages.append(contentsOf: images)
                    }
                }
                .sheet(isPresented: $showMap) {
                    MapPickerView(
                        selectedAddress: $selectedAddress,
                        selectedCoordinate: $selectedCoordinate
                    )
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
                            Text("Salir")
                                .foregroundStyle(.red)
                                .bold()
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
                                showAlert.toggle()
                                alertMessage = formError
                                return
                            }
                            
                            isLoading = true
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                property.propertyTitle = propertyTitle
                                property.propertyDetails = propertyDetails
                                property.propertyType = propertyType
                                property.maximumNumberOfGuests = numberOfGuests
                                property.numberOfBeds = numberOfBedrooms
                                property.numberOfBathrooms = numberOfBathrooms
                                property.propertyPhotos = selectedImages
                                property.ubication = selectedAddress
                                property.latitude = selectedCoordinate?.latitude
                                property.longitude = selectedCoordinate?.longitude
                                
                                viewModel.updatePropertyWith(property: property)
                                
                                isLoading = false
                                dismiss()
                            }
                            
                        } label: {
                            Text("Guardar")
                                .bold()
                        }
                    }
                }
                .navigationTitle("Editar Propiedad")
                .navigationBarTitleDisplayMode(.large)
                
                if isLoading {
                    LoadingView(text: "Guardando...")
                }
            }
        }
    }
}


#Preview {
    UpdatePropertyView(viewModel: .init() ,property: Constants.PreviewsForViewSample.propertyDetail)
}
