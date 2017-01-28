//
//  TransitData.swift
//  NJTransit
//
//  Created by Gokul Narasimhan on 8/23/16.
//  Copyright © 2016 GokulNarasimhan. All rights reserved.
//

import UIKit
import CoreData

import Foundation

class TransitData
{
   
    var transitType: TransitType
    
    
    var someVariable: Int { return 1 }
    var lstStop = [Stop]()
    var lstStopTime = [StopTime]()
    var lstTrip = [Trip]()
    
    
   
    lazy  var managedObjectContext : NSManagedObjectContext? = {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.managedObjectContext
        
    }()
    
    lazy var applicationDocumentsDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
    
    

    init(_transitType : TransitType)
    {
       
        transitType = _transitType
    }

    
    
    func loadTransitStop() -> [Stop]
    {
            let databasePath = self.applicationDocumentsDirectory.appendingPathComponent("NJTransit.sqlite")
            
            let transitDB = FMDatabase(path: databasePath.absoluteString)
            
            transitDB?.open()
            var lstStop : [Stop] = [Stop]()
            
            let selectStop = "Select stopID,stopCode,stopName,stopDesc,stopLat,stopLong,zoneID From Stop"
           //  let selectFilingStatusSql = "Select count(*) as cnt From Stop"
            
            NSLog(selectStop)
            
            
            let results:FMResultSet? = transitDB?.executeQuery(selectStop,
                                                                                  withArgumentsIn: nil)
            
            if !(results != nil) {
                print("Error: \(transitDB?.lastErrorMessage())")
            }
            
        
            while results?.next() == true {
                
                let stop = Stop()
                
                stop.stopID = results?.int(forColumn: "stopID")
                
                
                stop.stopCode =  results?.string(forColumn: "stopCode")
                
                stop.stopName =  results?.string(forColumn: "stopName")
                
                stop.stopDesc =  results?.string(forColumn: "stopDesc")
                
                stop.stopLat =  results?.double(forColumn: "stopLat")
                
                stop.stopLong =  results?.double(forColumn: "stopLong")
                
                stop.zoneID = results?.int(forColumn: "zoneID")
 
                
                lstStop.append(stop)
                
                
            }
            
            return lstStop
        
    }

    
    func loadTransitStopTime() -> [StopTime]
    {
        
        let databasePath = self.applicationDocumentsDirectory.appendingPathComponent("NJTransit.sqlite")
        
        let transitDB = FMDatabase(path: databasePath.absoluteString)
        
        transitDB?.open()
        var lstStopTime : [StopTime] = [StopTime]()
        
        let selectStopTime = "Select tripID,arrivalTime,departureTime,stopID,stopSequence,pickupType,dropType,shapeDistanceTravelled From StopTime"
        
        NSLog(selectStopTime)
        
        
        let results:FMResultSet? = transitDB?.executeQuery(selectStopTime,
                                                          withArgumentsIn: nil)
        
        if !(results != nil) {
            print("Error: \(transitDB?.lastErrorMessage())")
        }
        
        
        while results?.next() == true {
            
            let stopTime = StopTime()
            
            stopTime.tripID = results?.int(forColumn: "tripID")
            
            
            stopTime.arrivalTime =  results?.string(forColumn: "arrivalTime")
            
            stopTime.departureTime =  results?.string(forColumn: "departureTime")
            
            stopTime.stopID =  results?.int(forColumn: "stopID")
            
            stopTime.stopSequence =  results?.int(forColumn: "stopSequence")
            
            stopTime.pickupType =  results?.int(forColumn: "pickupType")
            
            stopTime.dropType  = results?.int(forColumn: "dropType")
            
            stopTime.shapeDistanceTravelled = results?.double(forColumn: "shapeDistanceTravelled")
            
            lstStopTime.append(stopTime)
            
            
        }
        
        return lstStopTime
        
    }
    
 
    
    func loadTransitTrip() -> [Trip]
    {
            let databasePath = self.applicationDocumentsDirectory.appendingPathComponent("NJTransit.sqlite")
            
            let transitDB = FMDatabase(path: databasePath.absoluteString)
            
            transitDB?.open()
            var lstTrip : [Trip] = [Trip]()
            
            let selectTrip = "Select routeID,serviceID,tripID,tripHeadSign,blockID,shapeID,truncatedTripHeadSign From Trip"
            
            NSLog(selectTrip)
            
            
            let results:FMResultSet? = transitDB?.executeQuery(selectTrip,
                                                                             withArgumentsIn: nil)
            
            if !(results != nil) {
                print("Error: \(transitDB?.lastErrorMessage())")
            }
            
        
            
            while results?.next() == true {
                
                let trip = Trip()
                
                trip.routeID = results?.int(forColumn: "routeID")
                
                trip.serviceID = results?.int(forColumn: "serviceID")
                
                trip.tripID = results?.int(forColumn: "tripID")
                
                trip.tripHeadSign =  results?.string(forColumn: "tripHeadSign")
                
                trip.truncatedTripHeadSign =  results?.string(forColumn: "truncatedTripHeadSign")
                
                
                trip.blockID =  results?.int(forColumn: "blockID")
                
                trip.shapeID =  results?.int(forColumn: "shapeID")
                
             
                lstTrip.append(trip)
                
                
            }
            
            return lstTrip
        
    }
    

}




class BusTransitData : TransitData
{
    override init(_transitType : TransitType) {
        super.init(_transitType: _transitType)
    }
    
    convenience init()
    {
        self.init(_transitType: TransitType.bus)
    }
    
  }

class TrainTransitData : TransitData
{
    override init(_transitType: TransitType) {
        super.init(_transitType: _transitType)
    }
    
    convenience init()
    {
        self.init(_transitType: TransitType.train)
    }
   
}
