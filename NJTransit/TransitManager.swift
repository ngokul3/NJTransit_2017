//
//  TransitManager.swift
//  NJTransit
//
//  Created by Gokul Narasimhan on 8/18/16.
//  Copyright © 2016 GokulNarasimhan. All rights reserved.
//

import Foundation

open class TransitDBManager
{
    static let sharedTransitInstance = TransitController()
    
    init()
    {
        
    }
}

open class TransitFactory
{
    static func getTransitConcreteObject(_ transitType: TransitType) -> Transit
    {
        switch (transitType)
        {
        case .bus:
            return BusTransit()
            
        case .train:
            return TrainTransit()
            
        }
    }
}
