//
//  GoogleMapView.swift
//  My Properties
//
//  Created by Juan Camilo  Mejia Soto on 8/04/25.
//

import SwiftUI
import GoogleMaps

struct GoogleMapView: UIViewRepresentable {
    
    var latitude: Double
    var longitude: Double
    var zoom: Float
    
    func makeUIView(context: Context) -> GMSMapView {
        let camera = GMSCameraPosition(latitude: latitude, longitude: longitude, zoom: zoom)
        let options = GMSMapViewOptions()
        options.camera = camera
        let mapview = GMSMapView(options: options)
        mapview.isMyLocationEnabled = false
        
        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        marker.map = mapview
        
        return mapview
    }
    
    func updateUIView(_ uiView: GMSMapView, context: Context) {
        uiView.clear()
        let position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        uiView.camera = GMSCameraPosition(latitude: latitude, longitude: longitude, zoom: zoom)
        GMSMarker(position: position).map = uiView
    }
    
    
}

#Preview {
    GoogleMapView(
        latitude: Constants.PreviewsForViewSample.propertyDetail.latitude!,
        longitude: Constants.PreviewsForViewSample.propertyDetail.longitude!,
        zoom: 16
    )
}
