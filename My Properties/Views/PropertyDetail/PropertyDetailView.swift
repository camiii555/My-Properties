//
//  PropertyDetailView.swift
//  My Properties
//
//  Created by Juan Camilo  Mejia Soto on 8/04/25.
//

//
//  PropertyDetailView.swift
//  My Properties
//
//  Created by Juan Camilo  Mejia Soto on 8/04/25.
//

import SwiftUI

struct PropertyDetailView: View {
    
    var viewModel: ViewModel
    var property: PropertyModel
    
    @State private var showUpdatePropertyView: Bool = false
    @State private var isLoading: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    
    private let width: CGFloat = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    CarouselPropertyImagesView(property: property, width: width , height: 500)
                        .frame(maxWidth: .infinity)
                        .clipped()
                    
                    VStack(alignment: .center, spacing: 15) {
                        Text(property.propertyTitle)
                            .font(.title)
                            .bold()
                        
                        Text(property.propertyDetails)
                            .font(.title3)
                            
                        
                        Text(property.getUbication)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        
                        HStack(spacing: 20) {
                            VStack(spacing: 10) {
                                Image(systemName: "person.fill")
                                Text("\(property.maximumNumberOfGuests) huéspedes")
                            }
                            
                            VStack(spacing: 10) {
                                Image(systemName: "bed.double")
                                Text("\(property.numberOfBeds) camas")
                            }
                            
                            VStack(spacing: 10) {
                                Image(systemName: "bathtub")
                                Text("\(property.numberOfBathrooms) baños")
                            }
                        }
                        .font(.subheadline)
                        .padding(.vertical, 5)
                        
                        Divider()
                            .frame(width: UIScreen.main.bounds.width - 40, height: 1)
                            .background(Color.gray)
                        
                        Text("Ubicación de la propiedad")
                            .font(.title2)
                            .bold()
                        
                        GoogleMapView(
                            latitude: property.getLatitude,
                            longitude: property.getLongitude,
                            zoom: 15
                        )
                        .frame(height: 400)
                        .clipShape(.buttonBorder)
                    }
                    .padding()
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            showUpdatePropertyView.toggle()
                        } label: {
                            Text("Editar")
                        }
                    }

                    ToolbarItem(placement: .bottomBar) {
                        Button(action: {
                            isLoading = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                viewModel.removePropertyWith(identifier: property.identifier)
                                isLoading = false
                                dismiss()
                            }
                        }, label: {
                            Label("Eliminar", systemImage: "trash")
                                .labelStyle(TitleAndIconLabelStyle())
                        })
                        .buttonStyle(.bordered)
                        .tint(.red)
                        .bold()
                    }
                }
                .fullScreenCover(isPresented: $showUpdatePropertyView, onDismiss: {
                    viewModel.fetchAllProperties()
                }) {
                    UpdatePropertyView(
                        viewModel: viewModel,
                        property: property
                    )
                }
            }
            
            if isLoading {
                LoadingView(text: "Cargando...")
            }
        }
    }
}


#Preview {
    PropertyDetailView(viewModel: .init(), property: Constants.PreviewsForViewSample.propertyDetail)
}


//import SwiftUI
//
//struct PropertyDetailView: View {
//    
//    var viewModel: ViewModel
//    var property: PropertyModel
//    
//    @State private var showUpdatePropertyView: Bool = false
//    
//    @Environment(\.dismiss) private var dismiss
//    
//    private let width: CGFloat = UIScreen.main.bounds.width
//    
//    var body: some View {
//        ScrollView {
//            VStack(){
//                CarouselPropertyImagesView(property: property, width: width , height: 500)
//                    .frame(maxWidth: .infinity)
//                    .clipped()
//                VStack {
//                    Text(property.propertyTitle)
//                        .font(.title)
//                        .bold()
//                    Text(property.propertyDetails)
//                        .font(.title3)
//                        .padding(.vertical, 5)
//                    Text(property.getUbication)
//                        .font(.subheadline)
//                        .padding(.vertical, 5)
//                    HStack(spacing: 20) {
//                        VStack(spacing: 10) {
//                            Image(systemName: "person.fill")
//                            Text("\(property.maximumNumberOfGuests) huéspedes")
//                        }
//                        
//                        VStack(spacing: 10) {
//                            Image(systemName: "bed.double")
//                            Text("\(property.numberOfBeds) camas")
//                        }
//                        
//                        VStack(spacing: 10) {
//                            Image(systemName: "bathtub")
//                            Text("\(property.numberOfBathrooms) baños")
//                        }
//                        
//                    }
//                    .font(.subheadline)
//                    .padding(.vertical, 5)
//                    
//                    Divider()
//                        .frame(width: UIScreen.main.bounds.width - 40, height: 1)
//                        .background(Color.gray)
//                    
//                    Text("Ubicacion de la propiedad")
//                        .font(.title)
//                        .padding(.top, 20)
//                    
//                    GoogleMapView(
//                        latitude: property.getLatitude,
//                        longitude: property.getLongitude,
//                        zoom: 15
//                    )
//                    .frame(height: 400)
//                    .padding(.all, 20)
//                    .clipShape(.buttonBorder)
//                    
//                }
//                
//                Spacer()
//            }
//            .toolbar {
//                ToolbarItem(placement: .topBarTrailing) {
//                    Button {
//                        showUpdatePropertyView.toggle()
//                    } label: {
//                        Text("Editar")
//                    }
//                }
//                
//                ToolbarItem(placement: .bottomBar) {
//                    Button(action: {
//                        viewModel.removePropertyWith(identifier: property.identifier)
//                        dismiss()
//                    }, label: {
//                        Label("Eliminar", systemImage: "trash")
//                            .labelStyle(TitleAndIconLabelStyle())
//                    })
//                    .buttonStyle(.bordered)
//                    .tint(.red)
//                    .bold()
//                }
//
//            }
//            .fullScreenCover(isPresented: $showUpdatePropertyView) {
//                UpdatePropertyView(
//                    viewModel: viewModel,
//                    property: property
//                )
//            }
//        }
//        .onAppear() {
//            print("cargue el detalle de la propiedad")
//        }
//    }
//}
//
//#Preview {
//    PropertyDetailView(viewModel: .init(), property: Constants.PreviewsForViewSample.propertyDetail)
//}
