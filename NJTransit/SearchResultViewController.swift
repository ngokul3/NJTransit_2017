//
//  SearchResultViewController.swift
//  NJTransit
//
//  Created by Gokul Narasimhan on 9/12/16.
//  Copyright © 2016 GokulNarasimhan. All rights reserved.
//

import UIKit
import CoreLocation

class SearchResultViewController: UITableViewController, UISearchResultsUpdating {

    @IBOutlet var SearchResultView: UITableView!
    var lstResult : TransitResult?
    
    
   // var distinctTripHeadSign = Set<String>()
    var arrayTripHeadSign = Array<String>()
    var resultSearchController = UISearchController()
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.resultSearchController = UISearchController(searchResultsController: nil)
        
        self.resultSearchController.searchResultsUpdater = self
        self.resultSearchController.dimsBackgroundDuringPresentation = false
        self.resultSearchController.searchBar.sizeToFit()
        self.tableView.tableHeaderView = self.resultSearchController.searchBar
        self.tableView.reloadData()
        
      //  arrayTripHeadSign = Array(distinctTripHeadSign)
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let recordCount = arrayTripHeadSign.count
        return recordCount
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripHeadSignCell", for: indexPath) 
        cell.textLabel?.text = arrayTripHeadSign[(indexPath as NSIndexPath).item]
        return cell
    }


    override func prepare(for segue: UIStoryboardSegue,
                          sender: Any?) {
        
        let identifier = segue.identifier
        if ( identifier == "ShowMapView")
        {
            if (lstResult == nil)
            {
                return
            }
            
            if let mapViewController = segue.destination as? MapViewController{
                
                let row = tableView.indexPathForSelectedRow!.row
                let tripHeadSignItem = arrayTripHeadSign[row].description
                
                let trips = lstResult?.lstTrip.filter({$0.truncatedTripHeadSign == tripHeadSignItem})
                
                let stopTime = lstResult?.lstStopTime.filter{
                    
                    let x = $0.tripID
                    let y = trips?.filter({$0.tripID == x})
                    
                    if ((y?.count)! > 0)
                    {
                        return true
                    }
                    else{
                        return false
                    }
                }
                
                let stops = lstResult?.lstStop.filter{
                    let x = $0.stopID
                    let y = stopTime?.filter{$0.stopID == x}
                    
                    if ((y?.count)! > 0)
                    {
                        return true
                    }
                    else{
                        return false
                    }
                }
                //todo
                mapViewController.lstResult = TransitResult()
                mapViewController.lstResult?.lstStop = stops!
                mapViewController.lstResult?.lstStopTime = stopTime!
                mapViewController.lstResult?.lstTrip = trips!
                
            }

        }
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        var setTripHeadSign = Set<String>()
        
        
        let transitFilterCriteria = TransitFilterCriteria()
        
        let searchString = searchController.searchBar.text!
        
        
        CLGeocoder().geocodeAddressString(searchString, completionHandler: { (placemarks, error) in
            if error != nil {
                print(90)
                // print(error)
                return
            }
            else{
                //   print(88)
            }
            
            
            
            
            if (placemarks?.count)! > 0 {
                let placemark = placemarks?[0]
                let location = placemark?.location
                
              //  let location_test = CLLocation(latitude: 40.736928, longitude: -74.242452)
            
                
                transitFilterCriteria.location = location
                
                let coordinate = location?.coordinate
                print("\nlat: \(coordinate!.latitude), long: \(coordinate!.longitude)")
                
                if (transitFilterCriteria.location != nil)
                {
                    
                    
                    
                    let transitResult = TransitResult()
                    
                    
                    var dateSetting = DateComponents()
                    dateSetting.day = 06
                    dateSetting.hour = 7
                    dateSetting.minute = 40
                    dateSetting.month = 9
                    dateSetting.year = 2016
                    (dateSetting as NSDateComponents).timeZone = TimeZone(identifier:  "America/New_York")
                    
                    
                    let outFormatter = DateFormatter()
                    outFormatter.locale = Locale(identifier: "en_US_POSIX")
                    outFormatter.dateFormat = "hh:mm"
                    
                    let userCalendar = Calendar(identifier: Calendar.Identifier.gregorian)
                    
                    transitFilterCriteria.filterDateTme = (userCalendar.date(from: dateSetting))!
                    transitFilterCriteria.transitType = TransitType.bus.description
                    
                    let setting = TransitSetting()
                    
                    setting.settingBusFilterDistance = 0.5
                    setting.settingFilterTime = 30
                    
                    
                    let transitType = BusTransit()
                    let transitDelegate = TransitSearchTracker()
                    transitType.delegate = transitDelegate
                    
                    
                    
                    let _ = transitType.getTransitResult(transitFilterCriteria, transitSetting: setting, transitResult: transitResult, completion : { success in
                        if success {
                            
                            let tmpSet = Set<String>()
                            
                            let lstBusTrip = transitResult.lstTrip
                            
                            setTripHeadSign = tmpSet.union(lstBusTrip.map{$0.truncatedTripHeadSign!}) //ToDo: Unwrap
                            
                            self.arrayTripHeadSign = Array(setTripHeadSign)
                            self.lstResult = transitResult
                            self.tableView.reloadData()
                            
                        } else {
                            NSLog("Parse unsuccessful")
                            // I'll handle the issue here
                        }});
                    
                    
                    
                }
                
            }
        })
        
        
    }
}
