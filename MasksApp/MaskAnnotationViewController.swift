//
//  MaskAnnotationViewController.swift
//  MasksApp
//
//  Created by Glen Lin on 2020/2/16.
//  Copyright © 2020 Glen Lin. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class MaskAnnotationViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        mapView.delegate = self
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: "\(MaskAnnotation.self)")
        
        guard let url = URL(string: "https://raw.githubusercontent.com/kiang/pharmacies/master/json/points.json")
            else{
                return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            let decoder = MKGeoJSONDecoder()
            if let features = try? decoder.decode(data) as? [MKGeoJSONFeature]{
                let maskAnnotations = features.map {
                    MaskAnnotation(feature: $0)
                }
                DispatchQueue.main.async {
                    self.mapView.addAnnotations(maskAnnotations)
                }
            }
        }.resume()
        
    }
    
}
extension MaskAnnotationViewController:MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
       print("didUpdate")
        let region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 23.5, longitudinalMeters: 121)
        mapView.setRegion(region, animated: true)
         print(region)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? MaskAnnotation else{ return nil }
        
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "\(MaskAnnotation.self)", for: annotation) as? MKMarkerAnnotationView
        
        annotationView!.canShowCallout = true
        let infoButton = UIButton(type:.detailDisclosure)
        annotationView?.rightCalloutAccessoryView = infoButton
        
        if let count = annotation.mask?.maskAdult, count == 0 {
            annotationView?.markerTintColor = .green
        }else{
            annotationView?.markerTintColor = .blue
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
         let annotation = view.annotation as? MaskAnnotation
         print(annotation)
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let annotation = view.annotation as? MaskAnnotation
        print(annotation)

    }
}



