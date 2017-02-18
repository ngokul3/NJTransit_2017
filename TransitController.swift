//
//  TransitController.swift
//  NJTransit
//
//  Created by Gokul Narasimhan on 8/17/16.
//  Copyright © 2016 GokulNarasimhan. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import CloudKit

import MapKit
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


extension Date {
    func add(_ minutes: Int) -> Date {
        let calendar = Calendar.current
        var comps = DateComponents()
        comps.minute = minutes
       // return calendar.date (byAdding: comps, to: self, options: [])! //ToDo
        
        return calendar.date(byAdding: comps, to: self)!
        //date( (byAdding: .minute, value: minutes, to: self, options: [])!
    }
    
    func dateToStringinHHMM() -> String?{
        let outFormatter = DateFormatter()
        outFormatter.locale = Locale(identifier: "en_US_POSIX")
        outFormatter.dateFormat = "hh:mm"
        
        return outFormatter.string(from: self)

    }
}

class TransitController {
    
    var lstBusStop : [Stop]?
    var lstTrainStop :[Stop]?
    var lstBusStopTime : [StopTime]?
    var lstTrainStopTime : [StopTime]?
    var lstBusTrip : [Trip]?
    var lstTrainTrip: [Trip]?
    
     required init()
    {
        
    }
    
    convenience init( _lstBusStop: [Stop], _lstTrainStop : [Stop], _lstBusStopTime : [StopTime], _lstTrainStopTime : [StopTime], _lstBusTrip : [Trip], _lstTrainTrip: [Trip])
    {
        self.init()
        lstBusStop = _lstBusStop
        lstTrainStop = _lstTrainStop
        
        lstBusStopTime   = _lstBusStopTime
        lstTrainStopTime   = _lstTrainStopTime
        
        lstBusTrip = _lstBusTrip
        lstTrainTrip = _lstTrainTrip
    }
    
    
    
    func StopFromCloudKitGet(_ transitFilterCriteria : TransitFilterCriteria, transitSetting: TransitSetting, transitResult: TransitResult , completion: ((Bool)->())?) {
     /*
        let filterCriteria = TransitFilterCriteria()
        let setting = TransitSetting()
        var dateSetting = DateComponents()
        dateSetting.day = 06
        dateSetting.hour = 7
        dateSetting.minute = 40
        dateSetting.month = 9
        dateSetting.year = 2016
        (dateSetting as NSDateComponents).timeZone = TimeZone(identifier:  "America/New_York")
        
        let userCalendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let location = CLLocation(latitude: 40.957574, longitude: -74.228039)
        let date = (userCalendar.date(from: dateSetting))!
        filterCriteria.filterDateTme = date
        filterCriteria.location = location
        filterCriteria.transitType = TransitType.bus.description
        
        setting.settingBusFilterDistance = 0.25
        setting.settingFilterTime = 30
        let lat = 40.957574
        let longi = -74.228039
 */
        let lat = transitFilterCriteria.location!.coordinate.latitude //Todo

        let longi = transitFilterCriteria.location!.coordinate.longitude //Todo

                // let D = 80.0 * 1.1;
        let D = transitSetting.settingBusFilterDistance! *  1609.34
        let R = 6371009.0; // Earth readius in meters
        let meanLatitidue = lat * M_PI / 180;
        let deltaLatitude = D / R * 180 / M_PI;
        let deltaLongitude = D / (R * cos(meanLatitidue)) * 180 / M_PI;
        let minLatitude = lat - deltaLatitude;
        let maxLatitude = lat + deltaLatitude;
        let minLongitude = longi - deltaLongitude;
        let maxLongitude = longi + deltaLongitude;
        
        
        
        let predicate = NSPredicate(format: "(\(minLongitude) <= StopLong) AND (StopLong <= \(maxLongitude))" +
            "AND (\(minLatitude) <= StopLat) AND (StopLat <= \(maxLatitude))")
        
        let query = CKQuery(recordType: "BusStop", predicate: predicate)
        
        // Create the initial query operation
        let queryOperation = CKQueryOperation(query: query)
        
        
        var stopArray = [Stop]()
        
        let publicDatabase = CKContainer.default().publicCloudDatabase;
        
        // Setup the query operation
        queryOperation.database = publicDatabase
        
        // Assign a record process handler
        queryOperation.recordFetchedBlock = { record in
            // Process each record
            let stop = Stop()
            
            stop.stopID =  record["StopID"] as! Int32?
            
            
            stop.stopCode =  record["StopCode"] as! String?
            
            stop.stopName =  record["StopName"] as! String?
            
            stop.stopDesc =  record["StopDesc"] as! String?
            
            stop.stopLat =  record["StopLat"] as! Double?
            
            stop.stopLong =  record["StopLong"] as! Double?
            
            stop.zoneID = record["ZoneID"] as! Int32?
            
            stop.location = record["Location"] as! CLLocation
            
            
            stopArray.append(stop)}
        
        
        queryOperation.queryCompletionBlock = { [unowned self] (cursor, error) in
            DispatchQueue.main.async {
                if error == nil {
                    
                    
                    print( stopArray.count)
                    
                    transitResult.lstStop = stopArray
                    
                    self.StopTimeFromCloudKitGet(transitFilterCriteria, transitSetting: transitSetting, stopArray: stopArray, transitResult: transitResult, stopTimecompletion : { success in
                        if success {
                            completion?(true)
                            //print(stopTimeArray.count)

                            
                        }}
                    )
                        

                    
                    
                        
                } else {
                    
                    completion?(false)
                    let ac = UIAlertController(title: "Fetch failed", message: "There was a problem fetching the list of whistles; please try again: \(error!.localizedDescription)", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    
                }
            }
        }
        
        CKContainer.default().publicCloudDatabase.add(queryOperation)
        
    
        
    }
    
    
    func StopTimeFromCloudKitGet(_ transitFilterCriteria : TransitFilterCriteria, transitSetting: TransitSetting, stopArray: [Stop], transitResult: TransitResult, stopTimecompletion: ((Bool)->())?) {
    
        let reqTimeIncludingSetting = transitFilterCriteria.filterDateTme?.add(transitSetting.settingFilterTime!)
        
       // let reqTimeIncludingSetting = transitFilterCriteria.filterDateTme?.add(transitSetting.settingFilterTime!).dateToStringinHHMM()
        
        let reqTimeInString = transitFilterCriteria.filterDateTme?.dateToStringinHHMM()
        let reqTimeIncludingSettingInString = reqTimeIncludingSetting?.dateToStringinHHMM()
        //var date = inFormatter.date(from: inStr)!
        let reqTime = transitFilterCriteria.filterDateTme
        
        let stopIdArray = stopArray.map({$0.stopID!}) //Todo
        
       /* let mappedTime = $0.arrivalTime! > reqTimeInString! && $0.arrivalTime! < reqTimeIncludingSettingInString! // Todo coditional unwrap req...
        
        if (!mappedTime)
        {
            return false
        }
        */
        
        
        let inFormatter = DateFormatter()
        inFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
        inFormatter.dateFormat = "HH:mm"

        
       //let predicate = NSPredicate(format: "StopId IN %@", stopIdArray)
        
       let predicate = NSPredicate(format: "StopId IN %@", stopIdArray)
        
       // let predicate = NSPredicate(format: "ArrivalTime > %@ AND ArrivalTime < %@", reqTime! as CVarArg, reqTimeIncludingSetting! as CVarArg)
        
         //let predicate = NSPredicate(format: "ArrivalTime \(as NSDate) > %@", reqTime! as CVarArg)
      
        //let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1, predicate2])
        
     //   predicate = predicate + NSPredicate(format: "StopId IN %@", stopIdArray)
        let query = CKQuery(recordType: "BusStopTime", predicate: predicate)
        
        // Create the initial query operation
        let queryOperation = CKQueryOperation(query: query)
        
        
        var stopTimeArray = [StopTime]()
        
        let publicDatabase = CKContainer.default().publicCloudDatabase;
        
        // Setup the query operation
        queryOperation.database = publicDatabase
        
        // Assign a record process handler
        queryOperation.recordFetchedBlock = { record in
            // Process each record
            let stopTime = StopTime()
            
            stopTime.tripID = record["TripId"] as! Int32?
        
            stopTime.arrivalTime =  record["ArrivalTime"]  as! String?
            
            stopTime.departureTime = record["DepartureTime"]  as! String?
            
            stopTime.stopID = record["StopId"] as! Int32?
            
            stopTime.stopSequence = record["StopSequence"] as! Int32?
 
            
            stopTime.pickupType =  record["PickupType"] as! Int32?
 
            
            stopTime.dropType  =  record["DropType"] as! Int32?
            
            stopTime.shapeDistanceTravelled = record["ShapeDistanceTravelled"] as! Double?
            
            stopTimeArray.append(stopTime)
        
        
        }
        
        
        queryOperation.queryCompletionBlock = { [unowned self] (cursor, error) in
            DispatchQueue.main.async {
                if error == nil {
                    
                    print(stopTimeArray.count)
                    
                    stopTimeArray = stopTimeArray.filter({$0.arrivalTime! > reqTimeInString! && $0.arrivalTime! < reqTimeIncludingSettingInString!})
                    transitResult.lstStopTime = stopTimeArray
                    
                    self.TripFromCloudKitGet(transitFilterCriteria, transitSetting: transitSetting, stropTimeTripArray: stopTimeArray,transitResult: transitResult, tripCompletion : { success in
                        if success {
                            stopTimecompletion?(true)
                            //print(stopTimeArray.count)
                            
                            
                        }})
                    
                    
                } else {
                    print(error!.localizedDescription)
                    let ac = UIAlertController(title: "Fetch failed", message: "There was a problem fetching the list of whistles; please try again: \(error!.localizedDescription)", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    
                }
            }
        }
        
        CKContainer.default().publicCloudDatabase.add(queryOperation)
        
        
        
    }
    
    func TripFromCloudKitGet(_ transitFilterCriteria : TransitFilterCriteria, transitSetting: TransitSetting, stropTimeTripArray: [StopTime], transitResult: TransitResult, tripCompletion: ((Bool)->())?)  {
        
    
        let stopTimeTripIdArray = stropTimeTripArray.map({$0.tripID!}) //Todo
 
 
        let predicate = NSPredicate(format: "TripId IN %@", stopTimeTripIdArray)
 
        // let predicate = NSPredicate(format: "StopId = 27663")
        
        let query = CKQuery(recordType: "BusTrip", predicate: predicate)
        
        // Create the initial query operation
        let queryOperation = CKQueryOperation(query: query)
        
        
        var tripArray = [Trip]()
        
        let publicDatabase = CKContainer.default().publicCloudDatabase;
        
        // Setup the query operation
        queryOperation.database = publicDatabase
        
        // Assign a record process handler
        queryOperation.recordFetchedBlock = { record in
            // Process each record
            let trip = Trip()
            
            trip.routeID = record["RouteId"] as! Int32?
            
            trip.serviceID = record["ServiceId"]  as! Int32?
            
            trip.tripID = record["TripId"]  as! Int32?
            
            trip.tripHeadSign =  record["TripHeadSign"]  as! String?
            
            trip.truncatedTripHeadSign =  record["TruncatedTripHeadSign"] as! String?
            
            
            trip.blockID =  record["BlockId"] as! Int32?
            
            trip.shapeID =  record["ShapeId"] as! Int32?
            
            
            tripArray.append(trip)
            
            
        }
        
        
        queryOperation.queryCompletionBlock = { [unowned self] (cursor, error) in
            DispatchQueue.main.async {
                if error == nil {
                    
                    print(tripArray.count)
                    transitResult.lstTrip = tripArray
                    tripCompletion?(true)
                    
                    
                } else {
                    let ac = UIAlertController(title: "Fetch failed", message: "There was a problem fetching the list of whistles; please try again: \(error!.localizedDescription)", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    
                }
            }
        }
        
        CKContainer.default().publicCloudDatabase.add(queryOperation)
        
        
    }
    /*
     func getTransitResult(_ transitFilterCriteria : TransitFilterCriteria, transitSetting: TransitSetting) throws -> TransitResult
    {
        var lstStop : [Stop]!
        var lstStopTime : [StopTime]!
        var lstTrip : [Trip]!
        let transitResult = TransitResult()
        
        guard transitSetting.settingFilterTime != nil else
        {
            throw TransitError.invalidDateTimeSetting
        }
        
        
        
        let reqTimeIncludingSetting = transitFilterCriteria.filterDateTme?.add(transitSetting.settingFilterTime!)
        
        let reqTimeInString = transitFilterCriteria.filterDateTme?.dateToStringinHHMM()
        let reqTimeIncludingSettingInString = reqTimeIncludingSetting?.dateToStringinHHMM()
       
        guard reqTimeInString != nil else
        {
            throw TransitError.invalidDateTimeFilterCriteria
        }
        
        guard reqTimeIncludingSettingInString != nil else
        {
            throw TransitError.invalidDateTimeFilterCriteria
        }
        
        
        if(transitFilterCriteria.transitType == TransitType.bus.description)
        {
            if(lstBusStop == nil)
            {
                lstBusStop = StopFromCloudKitGet(transitFilterCriteria, transitSetting: transitSetting)
            
            }
            guard lstBusStop != nil else{
                throw TransitError.invalidStop
            }
            
            if(lstBusStopTime == nil)
            {
                lstBusStopTime = StopTimeFromCloudKitGet(transitFilterCriteria, transitSetting: transitSetting, stopArray: lstBusStop!)
                
            }
            
            
            guard lstBusStopTime != nil else{
                throw TransitError.invalidStopTime
            }
            
            
            if(lstBusTrip == nil)
            {
                //lstBusStop = StopFromCloudKitGet(transitFilterCriteria, transitSetting: transitSetting)
                let _ = 1
                
            }

            
            guard lstBusTrip != nil else{
                throw TransitError.invalidTrip
            }
            
            lstStop = lstBusStop
            lstTrip = lstBusTrip
            lstStopTime = lstBusStopTime
        }
        else if(transitFilterCriteria.transitType == TransitType.train.description)
        {
            
            guard lstTrainStop != nil else{
                throw TransitError.invalidStop
            }
            
            guard lstTrainStopTime != nil else{
                throw TransitError.invalidStopTime
            }
            
            guard lstTrainTrip != nil else{
                throw TransitError.invalidTrip
            }

            
            
            lstStop = lstTrainStop
            lstTrip = lstTrainTrip
            lstStopTime = lstTrainStopTime
        }
        
        
        /* Populating lstStops*/
        
        let mapArray = lstStop.map({CLLocation(latitude: $0.stopLat! as Double, longitude: $0.stopLong! as Double)})
        
        let filterArray = mapArray.filter({ (transitFilterCriteria.location?.distance(from: $0))! * 0.000621371 < transitSetting.settingBusFilterDistance})
     
        
        let filteredStops = lstStop.filter{
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

        transitResult.lstStop = filteredStops
        
        /* End lstStops*/
        
        if (filteredStops.count == 0)
        {
            return transitResult
        }
        /*Populating lstStopTime */
        
      //  let busData = BusTransitData()
        
        //lstBusStopTime = busData.loadTransitStopTime_Filtered(reqTimeInString!, endTime: reqTimeIncludingSettingInString!)//ToDo Unwrap not done right
        
        
      /*  let filteredStopTime = lstBusStopTime!.filter //Todo Unwrap not done
            {
                
                let stop = $0.stopID!
                
                let stopFiltered = filteredStops.filter{
                    
                    $0.stopID == stop
                }
                
                if(stopFiltered.count != 0)
                {
                    return true
                }
                else{
                    return false
                }
         
        }*/
        
        
        
        let filteredStopTime = lstStopTime.filter
            {
                let mappedTime = $0.arrivalTime! > reqTimeInString! && $0.arrivalTime! < reqTimeIncludingSettingInString! // Todo coditional unwrap req...
                
                if (!mappedTime)
                {
                    return false
                }
                
                
                let stop = $0.stopID!
                
                let stopFiltered = filteredStops.filter{
                    
                    $0.stopID == stop
                }
                
                if(stopFiltered.count != 0)
                {
                    return true
                }
                else{
                    return false
                }
                
        }
        transitResult.lstStopTime = filteredStopTime
        /* */
        
        if (filteredStopTime.count == 0)
        {
            return transitResult
        }
        
        
        /*Populating lstTrip*/
        
        let filteredTrip = lstTrip.filter{
            
            let trip = $0.tripID
            
            let stopTimeFiltered = filteredStopTime.filter{
                $0.tripID == trip
            }
            
            if(stopTimeFiltered.count != 0)
            {
                return true
            }
            else{
                return false
            }
            
        }
        
        transitResult.lstTrip = filteredTrip
        /* */
        return transitResult
        
    }
    */
     internal var getBusStops:[Stop]? {
        get
            {
        if let count = lstBusStop?.count
        {
            if( count == 0)// ToDo: test when lst <> 0 by navigating within app and coming back to getStops
            {
                let busData = BusTransitData()
                
                lstBusStop = busData.loadTransitStop()
                return lstBusStop
            }
            else
            {
                return lstBusStop
            }
        }
        else
        {
            let busData = BusTransitData()
            
            lstBusStop = busData.loadTransitStop()
            return lstBusStop
        }
        }
    }
    
    
        internal  var getTrainStops:[Stop]? {
    
        get
        {
            if let count = lstTrainStop?.count
            {
                if( count == 0)// ToDo: test when lst <> 0 by navigating within app and coming back to getStops
                {
                    let busData = BusTransitData()
        
                    lstTrainStop = busData.loadTransitStop()
                    return lstTrainStop
                }
                else
                {
                    return lstTrainStop
                }
            }
            else
            {
                let trainData = TrainTransitData()
        
                lstTrainStop = trainData.loadTransitStop()
                return lstTrainStop
        }

    }
        }

    
    internal  var getBusStopStime:[StopTime]?
        {
        get
        {
            if let count = lstBusStopTime?.count
            {
                if(count == 0)
                {
                    let busData = BusTransitData()
                    
                    lstBusStopTime = busData.loadTransitStopTime()
                    return lstBusStopTime
                }
                else
                {
                    return lstBusStopTime
                }
            }
            
            else
            {
                let busData = BusTransitData()
                
                lstBusStopTime = busData.loadTransitStopTime()
                return lstBusStopTime
            }
        }
        
    }
    
    
   
    
    internal  var getTrainStopStime:[StopTime]?
        {
        get
        {
            if let count = lstTrainStopTime?.count
            {
                if(count == 0)
                {
                    let trainData = TrainTransitData()
                    
                    lstTrainStopTime = trainData.loadTransitStopTime()
                    return lstTrainStopTime
                }
                else
                {
                    return lstTrainStopTime
                }
            }
                
            else
            {
                let trainData = TrainTransitData()
                
                lstTrainStopTime = trainData.loadTransitStopTime()
                return lstTrainStopTime
            }
        }
        
    }
    
    internal  var getBusTrip:[Trip]?
        {
        get
        {
            if let count = lstBusTrip?.count
            {
                if(count == 0)
                {
                    let trainData = BusTransitData()
                    
                    lstBusTrip = trainData.loadTransitTrip()
                    return lstBusTrip
                }
                else{
                    return lstBusTrip
                }
            }
            
            else
            {
                let busData = BusTransitData()
                
                lstBusTrip = busData.loadTransitTrip()
                return lstBusTrip
            }
        }
        
    }
    
    internal  var getTrainTrip:[Trip]?
        {
        get
        {
            if let count = lstTrainTrip?.count
            {
                if(count == 0)
                {
                    let trainData = TrainTransitData()
                    
                    lstTrainTrip = trainData.loadTransitTrip()
                    return lstTrainTrip
                }
                else{
                    return lstTrainTrip
                }
            }
                
            else
            {
                let trainData = TrainTransitData()
                
                lstTrainTrip = trainData.loadTransitTrip()
                return lstTrainTrip
            }
        }
    }
    
    
   
}
