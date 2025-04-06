//
//  ContentView.swift
//  My Properties
//
//  Created by Juan Camilo  Mejia Soto on 5/04/25.
//

import SwiftUI
import SwiftData


struct ContentView: View {
    var viewModel: ViewModel = .init()
    
    @State private var showAddNewPropertyView: Bool = false
    @State private var selectedProperty: PropertyModel? = nil
    
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(viewModel.properties) { property in
                    ZStack {
                        PropertyRowView(
                            property: property,
                            width: UIScreen.main.bounds.width,
                            height: 350
                        )
                        
                        NavigationLink(value: property) {
                            EmptyView()
                        }
                        .opacity(0)
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)

                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(Color(.systemGroupedBackground))
            .toolbar {
                ToolbarItem(placement: .status) {
                    Button(action: {
                        showAddNewPropertyView.toggle()
                    }) {
                        Label("Agregar Propiedad", systemImage: "plus.circle")
                            .labelStyle(TitleAndIconLabelStyle())
                    }
                    .buttonStyle(.bordered)
                    .tint(.blue)
                    .bold()
                }
            }
            .navigationTitle("Propiedades")
            .navigationDestination(for: PropertyModel.self, destination: { property in
                PropertyDetailView(viewModel: viewModel, property: property)
            })
            .fullScreenCover(isPresented: $showAddNewPropertyView) {
                AddNewPropertyView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    PropertyDetailView(
        viewModel: ViewModel(),
        property: Constants.PreviewsForViewSample.propertyDetail
        )

}
