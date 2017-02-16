//
//  Stop.swift
//  NJTransit
//
//  Created by Gokul Narasimhan on 8/13/16.
//  Copyright © 2016 GokulNarasimhan. All rights reserved.
//

import Foundation
import CoreData
import CoreLocation


//TODO: Populate Routes also

class Stop {
    var stopID:Int32?
    var stopName:String?
     var stopCode:String?
     var stopDesc:String?
    var stopLat:Double?
     var stopLong:Double?
    var location:CLLocation?
     var zoneID:Int32?
     var transitType:String?
    
    
 }

class Trip {
     var tripID: Int32?
     var routeID: Int32?
     var serviceID: Int32?
     var tripHeadSign: String?
     var directionID: Int32?
     var blockID: Int32?
     var shapeID: Int32?
     var transitType:String?
     var truncatedTripHeadSign: String?
}

class StopTime{
     var rowID:String?
     var stopID:Int32?
     var tripID:Int32?
     var arrivalTime: String?
     var departureTime: String?
     var stopSequence: Int32?
     var pickupType : Int32?
     var dropType: Int32?
     var shapeDistanceTravelled: Double?
     var transitType:String?
}

class TransitSetting {
    var settingBusFilterDistance : Double?
    var settingTrainFilterDistance : Double?
    var settingFilterTime: Int?
    @NSManaged var settingTransitFilterDateTime : Date
    
}

class TransitFilterCriteria{
    var location : CLLocation?
    var busNumber : Int32?
    var filterDateTme : Date?
    var transitType : String?
}

class TransitResult{
    var lstStop: [Stop]
    var lstTrip: [Trip]
    var lstStopTime: [StopTime]
    
    init()
    {
        lstStop = [Stop]()
        lstTrip = [Trip]()
        lstStopTime = [StopTime]()
    }
    
}


