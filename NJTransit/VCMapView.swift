//
//  VCMapView.swift
//  NJTransit
//
//  Created by Gokul Narasimhan on 8/17/16.
//  Copyright © 2016 GokulNarasimhan. All rights reserved.
//

import Foundation
import MapKit

extension HomeViewController: MKMapViewDelegate {
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? Artwork {
            let identifier = "pin"
            var view: MKAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                as MKAnnotationView! { // 2
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                // 3
                view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                let btn = UIButton(type: .detailDisclosure)
                view.rightCalloutAccessoryView = btn
            }
            return view
        }
        return nil
    }
}
