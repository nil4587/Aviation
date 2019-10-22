//
//  AirportMapViewController.swift
//  Airport
//
//  Created by Nilesh Prajapati (ZA) on 2019/10/13.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit
import MapKit

class AirportMapViewController: BaseViewController {

    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!

    private lazy var viewModel = AirportMapViewModel(delegate: self,
                                             interactor: AirportMapViewInteractor(),
                                             dataTransporter: self.dataTransporter)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let locationManager = LocationManager.sharedInstance
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        self.loadingIndicator.startAnimating()
    }
}

//MARK: - MKMapViewDelegate

extension AirportMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        annotationView?.image = UIImage(named: "Pin")
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        viewModel.selectedAirport(at: view.annotation!)
        self.performSegue(withIdentifier: "FlightsDepartureSegue", sender: view)
    }
}

//MARK: - LocationManagerServiceDelegate

extension AirportMapViewController: LocationManagerServiceDelegate {
    func locationDidUpdateToLocation(currentLocation: CLLocation) {
        viewModel.updateCurrentLocationWith(location: currentLocation)
        //viewModel.retrieveNearByAirports()
        viewModel.retriveStubResponse()
    }
    
    func locationUpdateDidFailWithError(error: Error) {
        self.loadingIndicator.stopAnimating()
        DispatchQueue.main.async {
            self.displayAlert(message: error.localizedDescription)
        }
    }
}

//MARK: - AirportMapViewModelDelegate

extension AirportMapViewController: AirportMapViewModelDelegate {
    func refreshMap(with list: [AirportModel]?) {
        viewModel.nearbyAirportList = list
        var annotationList: [MKPointAnnotation] = []
        list?.enumerated().forEach({ (index, airport) in
            let airportAnnotation = MKPointAnnotation()
            airportAnnotation.title = airport.nameAirport
            airportAnnotation.subtitle = airport.codeIcaoAirport
            airportAnnotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(airport.latitude ?? "0.0") ?? 0.0, longitude: CLLocationDegrees(airport.longitude ?? "0.0") ?? 0.0)
            annotationList.append(airportAnnotation)
        })
        DispatchQueue.main.async { [weak self] in
            self?.loadingIndicator.stopAnimating()
            if let annotations = self?.mapView.annotations, annotations.count > 0 {
                self?.mapView.removeAnnotations(annotations)
            }
            self?.mapView.addAnnotations(annotationList)
            if let userLocation = self?.mapView.userLocation.coordinate {
                self?.mapView.setRegion(MKCoordinateRegion(center: userLocation, span: MKCoordinateSpan(latitudeDelta: 0.8, longitudeDelta: 0.8)), animated: true)
            }
        }
    }
    
    func showFailure(with error: String?) {
        DispatchQueue.main.async { [weak self] in
            self?.loadingIndicator.stopAnimating()
            self?.displayAlert(message: error ?? "api_something_went_wrong".localised())
        }
    }
}
