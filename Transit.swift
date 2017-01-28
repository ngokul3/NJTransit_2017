//
//  Transit.swift
//  NJTransit
//
//  Created by Gokul Narasimhan on 8/18/16.
//  Copyright © 2016 GokulNarasimhan. All rights reserved.
//

import Foundation

protocol Transit {
    var getStop : [Stop]? {get}
    var getStopTime : [StopTime]? {get}
    var getTrip : [Trip]? {get}
    func getTransitResult(_ transitFilterCriteria : TransitFilterCriteria, transitSetting: TransitSetting, transitResult: TransitResult , completion: ((Bool)->())?)
   
  
}

class BusTransit: Transit
{
    
    var getStop : [Stop]?
        {
        get
        {
            return TransitDBManager.sharedTransitInstance.getBusStops
        }
    
    }
    
    
    var getStopTime : [StopTime]?
        {
        get
        {
            return TransitDBManager.sharedTransitInstance.getBusStopStime
        }
        
    }
    
    var getTrip : [Trip]?
        {
        get
        {
            return TransitDBManager.sharedTransitInstance.getBusTrip
        }
        
    }

   func getTransitResult(_ transitFilterCriteria : TransitFilterCriteria, transitSetting: TransitSetting, transitResult: TransitResult , completion: ((Bool)->())?)
   {
    TransitDBManager.sharedTransitInstance.StopFromCloudKitGet(transitFilterCriteria, transitSetting: transitSetting, transitResult: transitResult, completion : { success in
        if success {
            
           completion?(true)
        }});
    }
    
    
}

class TrainTransit: Transit
{
    
    var getStop : [Stop]?
        {
        get
        {
            return TransitDBManager.sharedTransitInstance.getTrainStops
        }
     
    }
    
    var getStopTime : [StopTime]?
        {
        get
        {
            return TransitDBManager.sharedTransitInstance.getTrainStopStime
        }
        
    }
    
    var getTrip : [Trip]?
        {
        get
        {
            return TransitDBManager.sharedTransitInstance.getTrainTrip
        }
        
    }
    
    
    func getTransitResult(_ transitFilterCriteria : TransitFilterCriteria, transitSetting: TransitSetting, transitResult: TransitResult , completion: ((Bool)->())?)
    {
         TransitDBManager.sharedTransitInstance.StopFromCloudKitGet(transitFilterCriteria, transitSetting: transitSetting, transitResult: transitResult, completion : { success in
            if success {
                
                completion?(true)
            }});
    }
    
    
}

