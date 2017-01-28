//
//  MapViewController.swift
//  NJTransit
//
//  Created by Gokul Narasimhan on 8/16/16.
//  Copyright © 2016 GokulNarasimhan. All rights reserved.
//

import UIKit
import MapKit


class MapViewController: UIViewController,MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    public var lstResult : TransitResult?

    var transitFactory = TransitFactory()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       //let initialLocation = CLLocation(latitude: 40.8537810, longitude: -74.0162710)
        
        if(lstResult!.lstStop.count > 0)
        {
            if let setMapLocation = lstResult?.lstStop[0].location
            {
                centerMapOnLocation(setMapLocation)

            }
            
    
            
            
            
        }
     //   centerMapOnLocation(initialLocation)
        
        mapView.delegate = self
        
        let _ = Artwork(title: "Currently Here",
                              locationName: "RidgeField Park",
                              discipline: "Sculpture",
                              coordinate: CLLocationCoordinate2D(latitude: 40.8537810, longitude: -74.0162710))
        
      /*  let newYorkLocation = CLLocationCoordinate2DMake(40.730872, -74.003066)
        let dropPin = MKPointAnnotation()
        dropPin.coordinate = newYorkLocation
        dropPin.title = "New York City"
        */
        
        
        //mapView.addAnnotation(artwork)
        
        
        
     //   let transitObj = TransitFactory.getTransitConcreteObject(TransitType.bus)
  
        
       //TODO: Conditional Unwrapping required
        
        let stops = (lstResult?.lstStop)!
     //   let stopTime = (lstResult?.lstStopTime)!
        
       // let trip = (lstResult?.lstTrip)!
        
        let mapArray = stops.map({CLLocation(latitude: $0.stopLat! as Double, longitude: $0.stopLong! as Double)})
        let filterArray = mapArray
      //  let filterArray = mapArray.filter({ initialLocation.distance(from: $0) * 0.000621371 < 1})

        
        
        let filterStops = stops.filter{
            let x = CLLocation(latitude: $0.stopLat! as Double, longitude: $0.stopLong! as Double)
        
            let y = filterArray.filter({$0.coordinate.latitude == x.coordinate.latitude && $0.coordinate.longitude == x.coordinate.longitude})
            
            if(y.count != 0)
            {
                return true
            }
            else{
                return false
            }
        }
        
        
        for  stop in filterStops
        {
            let mapPoints = Artwork(title: stop.stopCode!,
                                  locationName: stop.stopDesc!,
                                  discipline: "Stops",
                                  coordinate: CLLocationCoordinate2D(latitude: stop.stopLat as Double!, longitude: stop.stopLong as Double!))
            
            
            mapView.addAnnotation(mapPoints)
            
        }
        
    }

    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(_ location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    
}
