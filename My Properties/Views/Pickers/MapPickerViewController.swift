//
//  MapPickerViewController.swift
//  My Properties
//
//  Created by Juan Camilo  Mejia Soto on 7/04/25.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation

protocol MapViewDelegateProtocol: AnyObject {
    func didUpdateLocation(address: String, coordinate: CLLocationCoordinate2D)
}

class MapPickerViewController: UIViewController {
    
    weak var delegate: MapViewDelegateProtocol?
    var mapView: GMSMapView!
    var marker = GMSMarker()
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var placesClient = GMSPlacesClient.shared()
    let locationManager = CLLocationManager()
    var hasCenteredMapOnUserLocation = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        configureLocation()
        setupSearch()
        setupCloseButton()
    }
    
    func setupMap() {
        let defaultCamera = GMSCameraPosition.camera(withLatitude: 4.7110, longitude: -74.0721, zoom: 16)
        let options = GMSMapViewOptions()
        options.camera = defaultCamera
        mapView = GMSMapView(options: options)
        mapView.frame = view.bounds
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        view.addSubview(mapView)
    }
    
    func configureLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func setupSearch() {
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        searchController?.obscuresBackgroundDuringPresentation = false
        searchController?.hidesNavigationBarDuringPresentation = false
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func setupCloseButton() {
        let closeButton = UIButton(type: .system)
        closeButton.setTitle("Cerrar", for: .normal)
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        closeButton.layer.cornerRadius = 8
        closeButton.titleLabel?.font = .boldSystemFont(ofSize: 14)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
        
        view.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            closeButton.widthAnchor.constraint(equalToConstant: 70),
            closeButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    @objc func closeModal() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension MapPickerViewController: GMSMapViewDelegate, GMSAutocompleteResultsViewControllerDelegate {
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        updateMarker(coordinate)
        reverseGeocode(coordinate)
    }
    
    func updateMarker(_ coordinate: CLLocationCoordinate2D) {
        marker.position = coordinate
        marker.map = mapView
        mapView.animate(toLocation: coordinate)
    }
    
    func reverseGeocode(_ coordinate: CLLocationCoordinate2D) {
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(coordinate) { response, _ in
            if let address = response?.firstResult(), let lines = address.lines {
                let fullAddress = lines.joined(separator: ", ")
                self.delegate?.didUpdateLocation(address: fullAddress, coordinate: coordinate)
            }
        }
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didAutocompleteWith place: GMSPlace) {
        updateMarker(place.coordinate)
        delegate?.didUpdateLocation(address: place.formattedAddress ?? "", coordinate: place.coordinate)
        dismiss(animated: true)
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didFailAutocompleteWithError error: Error) {
        print("Autocompletado falló: \(error.localizedDescription)")
    }
}

extension MapPickerViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }

        if !hasCenteredMapOnUserLocation {
            let camera = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 16)
            mapView.animate(to: camera)
            hasCenteredMapOnUserLocation = true
        }

        marker.position = location.coordinate
        marker.map = mapView
        reverseGeocode(location.coordinate)

        locationManager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
}
