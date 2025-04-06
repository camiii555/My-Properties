//
//  MapPickerView.swift
//  My Properties
//
//  Created by Juan Camilo  Mejia Soto on 7/04/25.
//

import SwiftUI
import GoogleMaps

struct MapPickerView: UIViewControllerRepresentable {
    @Binding var selectedAddress: String
    @Binding var selectedCoordinate: CLLocationCoordinate2D?

    func makeUIViewController(context: Context) -> UINavigationController {
        let mapPickerVC = MapPickerViewController()
        mapPickerVC.delegate = context.coordinator

        let nav = UINavigationController(rootViewController: mapPickerVC)
        return nav
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    class Coordinator: NSObject, MapViewDelegateProtocol {
        var parent: MapPickerView

        init(parent: MapPickerView) {
            self.parent = parent
        }

        func didUpdateLocation(address: String, coordinate: CLLocationCoordinate2D) {
            parent.selectedAddress = address
            parent.selectedCoordinate = coordinate
        }
    }
}




