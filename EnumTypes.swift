//
//  TransitType.swift
//  NJTransit
//
//  Created by Gokul Narasimhan on 8/16/16.
//  Copyright © 2016 GokulNarasimhan. All rights reserved.
//

import Foundation

public enum TransitType {
    case bus
    case train
   
    var description : String {
        switch self {
        
        case .bus: return "Bus";
        case .train: return "Train";
        
        }
    }
}

public enum EntityType {
    case stop
    case stopTime
    case trip
    
    var description : String {
        switch self {
            
        case .stop: return "Stop";
        case .stopTime: return "StopTime";
        case .trip: return "Trip";
        }
    }
}

public enum TransitError: Error {
    case invalidStop
    case invalidStopTime
    case invalidTrip
    case invalidDateTimeSetting
    case invalidDateTimeFilterCriteria
    // case InsufficientFunds(coinsNeeded: Int)
    //case OutOfStock
}
