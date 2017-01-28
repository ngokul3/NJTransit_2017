//
//  HomeViewController.swift
//  NJTransit
//
//  Created by Gokul Narasimhan on 9/12/16.
//  Copyright © 2016 GokulNarasimhan. All rights reserved.
//

import UIKit
import CoreLocation
import CloudKit

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}



class HomeViewController: UIViewController {
 
    var setTripHeadSign = Set<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /*
        
        stopRecord.setObject(1 as CKRecordValue?, forKey: "StopId")
        stopRecord.setObject("name" as CKRecordValue?, forKey: "StopName")
        stopRecord.setObject("code" as CKRecordValue?, forKey: "StopCode")
        stopRecord.setObject("desc" as CKRecordValue?, forKey: "StopDesc")
        stopRecord.setObject("lat" as CKRecordValue?, forKey: "StopLat")
        stopRecord.setObject("long" as CKRecordValue?, forKey: "StopLong")
        stopRecord.setObject("type" as CKRecordValue?, forKey: "TransitType")
        stopRecord.setObject("xone" as CKRecordValue?, forKey: "ZoneId")
        
 
        let container = CKContainer.default()
        let publicDatabase = container.publicCloudDatabase
        publicDatabase.save(stopRecord, completionHandler: {(record, error) -> Void in
            
            if (error != nil)
            {
                print(error)
            }
        })
        */
        var x = 0;
        
        let busData = BusTransitData()
        
        
        //let lstTrip = busData.loadTransitTrip()
        let lstBusStopTime = busData.loadTransitStopTime()
    //   let lstBusStop = busData.loadTransitStop()
        
       
        let container = CKContainer.default()
        let publicDatabase = container.publicCloudDatabase
        /*
        CKContainer.default().accountStatus { (accountStat, error) in
            if (accountStat == .available) {
                print("iCloud is available")
                for stop in lstBusStop {
                  /*  if (x == 10)
                    {
                        break
                    }*/
                    x = x + 1
                    print(x)
                    
                    let stopRecord = CKRecord(recordType: "Stop")
                    stopRecord.setObject(stop.stopID as CKRecordValue?, forKey: "StopId")
                    stopRecord.setObject(stop.stopName as CKRecordValue?, forKey: "StopName")
                    
                    stopRecord.setObject(stop.stopCode as CKRecordValue?, forKey: "StopCode")
                    stopRecord.setObject(stop.stopDesc as CKRecordValue?, forKey: "StopDesc")
                    stopRecord.setObject(stop.stopLat as CKRecordValue?, forKey: "StopLat")
                    stopRecord.setObject(stop.stopLong as CKRecordValue?, forKey: "StopLong")
                    stopRecord.setObject(CLLocation(latitude: stop.stopLat!, longitude: stop.stopLong!) as CKRecordValue?, forKey: "StopLocation")
                    stopRecord.setObject("Bus" as CKRecordValue?, forKey: "TransitType")
                    stopRecord.setObject(stop.zoneID as CKRecordValue?, forKey: "ZoneId")

                    publicDatabase.save(stopRecord) {
                        record, error in
                        if error != nil {
                            print(error)
                        } else {
                            print(record?.object(forKey: "StopName") as! String + " recorded")
                        }
                    }
                }
            }
            else {
                print("iCloud is not available")
            }
        }
        */
        
        /*
        CKContainer.default().accountStatus { (accountStat, error) in
            if (accountStat == .available) {
                print("iCloud is available")
                for trip in lstTrip{
                    
                    x = x + 1
                    //print(x)
                    
                    
                    let tripRecord = CKRecord(recordType: "Trip")
                    tripRecord.setObject(trip.blockID as CKRecordValue?, forKey: "BlockId")
                    tripRecord.setObject(trip.directionID as CKRecordValue?, forKey: "DirectionId")
                    tripRecord.setObject(trip.routeID as CKRecordValue?, forKey: "RouteId")
                    
                    tripRecord.setObject(trip.serviceID as CKRecordValue?, forKey: "ServiceId")
                    tripRecord.setObject(trip.shapeID as CKRecordValue?, forKey: "ShapeId")
                    tripRecord.setObject("Bus" as CKRecordValue?, forKey: "TransitType")
                    tripRecord.setObject(trip.tripHeadSign as CKRecordValue?, forKey: "TripHeadSign")
                    tripRecord.setObject(trip.tripID as CKRecordValue?, forKey: "TripId")
                    tripRecord.setObject(trip.truncatedTripHeadSign as CKRecordValue?, forKey: "TruncatedTripHeadSign")
                    
                    publicDatabase.save(tripRecord) {
                        record, error in
                        if error != nil {
                            print(error)
                        } else {
                             print(record?.object(forKey: "TruncatedTripHeadSign") as! String + " recorded")
                        }
                    }
                }
            }
            else {
                print("iCloud is not available")
            }
        }
        
        */
       
    
        CKContainer.default().accountStatus { (accountStat, error) in
            if (accountStat == .available) {
                print("iCloud is available")
                for stopTime in lstBusStopTime.filter({$0.tripID < 100}){
                    
                    x = x + 1
                    //print(x)
                    
                    
                    let stopTimeRecord = CKRecord(recordType: "StopTime")
                    stopTimeRecord.setObject(stopTime.stopID as CKRecordValue?, forKey: "StopId")
                    stopTimeRecord.setObject(stopTime.tripID as CKRecordValue?, forKey: "TripId")
                    stopTimeRecord.setObject(stopTime.arrivalTime as CKRecordValue?, forKey: "ArrivalTime")
                    
                    stopTimeRecord.setObject(stopTime.departureTime as CKRecordValue?, forKey: "DepartureTime")
                    stopTimeRecord.setObject(stopTime.dropType as CKRecordValue?, forKey: "DropType")
                    stopTimeRecord.setObject(stopTime.pickupType as CKRecordValue?, forKey: "PickupType")
                    stopTimeRecord.setObject(stopTime.shapeDistanceTravelled as CKRecordValue?, forKey: "ShapeDistanceTravelled")
                    stopTimeRecord.setObject(stopTime.stopSequence as CKRecordValue?, forKey: "StopSequence")
                    stopTimeRecord.setObject("Bus" as CKRecordValue?, forKey: "TransitType")

                    
                    publicDatabase.save(stopTimeRecord) {
                        record, error in
                        if error != nil {
                            print(error)
                        } else {
                            print((record?.object(forKey: "TripId").debugDescription)!  + " recorded")
                        }
                    }
                }
            }
            else {
                print("iCloud is not available")
            }
        }
        
        
        
        
        
        
     /*
      
        guard let storeURL = NSURL(string: "https://drive.google.com/open?id=0B-1jRhZF8VZfRUIyUURzaTFoWkU") else {
            return
        }
        
        
        Utils.loadFileSync(storeURL as URL, completion:{(path:String) in
            print("file downloaded to: \(path)")
        } )
 
        getDetails()
 */
        
        
     //   let testObj = TransitController()
       // var lstSTop = testObj.StopFromCloudKitGet()
        
       //print(lstSTop.count)
         getDetails()
        
    }
    
    func getDetails()
    {
        
        let transitFilterCriteria = TransitFilterCriteria()
        let transitController = TransitDBManager.sharedTransitInstance
        
 //       let transitObj = TransitFactory.getTransitConcreteObject(TransitType.Bus)
        
   //     let _ = transitObj.getStop! //TODO: Conditional Unwrapping required
        
        CLGeocoder().geocodeAddressString("07660", completionHandler: { (placemarks, error) in
            if error != nil {
                print(90)
               // print(error)
                return
            }
            else{
             //   print(88)
            }
            
            print(placemarks?.count)
            
           
            
            if placemarks?.count > 0 {
                let placemark = placemarks?[0]
                let location = placemark?.location
                
                let location_test = CLLocation(latitude: 40.736928, longitude: -74.242452)
                
                
                transitFilterCriteria.location = location_test

                let coordinate = location?.coordinate
                print("\nlat: \(coordinate!.latitude), long: \(coordinate!.longitude)")
                
        if (transitFilterCriteria.location != nil)
        {
            
            let transitObj = TransitFactory.getTransitConcreteObject(TransitType.bus)
        
            
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
            
         //   let reqTimeIncludingSetting = transitFilterCriteria.filterDateTme?.add(setting.settingFilterTime!).dateToStringinHHMM()
            
           // let reqTimeInString = transitFilterCriteria.filterDateTme?.dateToStringinHHMM()

     
            
            let _ = transitObj.getTransitResult(transitFilterCriteria, transitSetting: setting, transitResult: transitResult, completion : { success in
                if success {
                    
                    let tmpSet = Set<String>()
                    
                    let lstBusTrip = transitResult.lstTrip
                    
                    self.setTripHeadSign = tmpSet.union(lstBusTrip.map{$0.truncatedTripHeadSign!}) //ToDo: Unwrap
                    
                    let containerViewController = self.childViewControllers[0] as! SearchResultViewController
                    
                    containerViewController.arrayTripHeadSign = Array(self.setTripHeadSign)
                    containerViewController.lstResult = transitResult
                    containerViewController.tableView.reloadData()
                } else {
                    NSLog("Parse unsuccessful")
                    // I'll handle the issue here
                }});
            
            
       
                }
                
            }
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  


    override func prepare(for segue: UIStoryboardSegue,
                                  sender: Any?) {
        
        let identifier = segue.identifier
        if ( identifier == "ShowTransitView")
        {
            
            let viewController1 = segue.destination as! SearchResultViewController
            
          // viewController1.distinctTripHeadSign = setTripHeadSign
            self.addChildViewController(viewController1)
        }
        
        
    }
}
