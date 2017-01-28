//
//  SearchResultViewController.swift
//  NJTransit
//
//  Created by Gokul Narasimhan on 9/12/16.
//  Copyright © 2016 GokulNarasimhan. All rights reserved.
//

import UIKit

class SearchResultViewController: UITableViewController {

    @IBOutlet var SearchResultView: UITableView!
    var lstResult : TransitResult?
    
    
   // var distinctTripHeadSign = Set<String>()
    var arrayTripHeadSign = Array<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}
