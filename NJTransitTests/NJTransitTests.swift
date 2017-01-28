//
//  NJTransitTests.swift
//  NJTransitTests
//
//  Created by Gokul Narasimhan on 8/13/16.
//  Copyright © 2016 GokulNarasimhan. All rights reserved.
//

import UIKit
import XCTest
import CoreLocation
@testable import NJTransit
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


class NJTransitTests: XCTestCase {
    
    var lstBusStop = [Stop]()
    var lstBusTrip = [Trip]()
    var lstBusStopTime  = [StopTime]()
    var lstTrainStop = [Stop]()
    var lstTrainTrip = [Trip]()
    var lstTrainStopTime = [StopTime]()
    
    override func setUp() {
        super.setUp()
        
        let stop1 = Stop()//.95 from home
        stop1.stopID = 1
        stop1.stopCode = "121"
        stop1.stopName = "Teaneck Rd - Test1"
        stop1.stopLat = 40.867568
        stop1.stopLong = -74.014883
        stop1.zoneID = 0
        lstBusStop.append(stop1)
        
        let stop2 = Stop() // 2.02 from home
        stop2.stopID = 2
        stop2.stopCode = "122"
        stop2.stopName = "Teaneck Rd - Test2"
        stop2.stopLat = 40.882239
        stop2.stopLong = -74.00867
        stop2.zoneID = 0
        lstBusStop.append(stop2)
        
        
        let stop3 = Stop() //2.76 from home
        stop3.stopID = 3
        stop3.stopCode = "123"
        stop3.stopName = "Teaneck Rd - Test3"
        stop3.stopLat = 40.892458
        stop3.stopLong = -74.002511
        stop3.zoneID = 0
        lstBusStop.append(stop3)
        
        let stop4 = Stop()//2.69 from home
        stop4.stopID = 4
        stop4.stopCode = "124"
        stop4.stopName = "Teaneck Rd - Test4"
        stop4.stopLat = 40.8912
        stop4.stopLong = -74.031321
        stop4.zoneID = 0
        lstBusStop.append(stop4)
        
        let stop5 = Stop()//2.60 from home
        stop5.stopID = 5
        stop5.stopCode = "125"
        stop5.stopName = "Queen Anne Rd - Test1"
        stop5.stopLat = 40.8914
        stop5.stopLong = -74.012523
        stop5.zoneID = 0
        lstBusStop.append(stop5)
        
        let stop6 = Stop()//2.25
        stop6.stopID = 6
        stop6.stopCode = "126"
        stop6.stopName = "Queen Anne Rd - Test2"
        stop6.stopLat = 40.886418
        stop6.stopLong = -74.015033
        stop6.zoneID = 0
        lstBusStop.append(stop6)
  
        let stop7 = Stop()//2.60
        stop7.stopID = 7
        stop7.stopCode = "127"
        stop7.stopName = "Anderson Ave - Test1"
        stop7.stopLat = 40.821298
        stop7.stopLong = -73.991062
        stop7.zoneID = 0
        lstBusStop.append(stop7)
        
        let stop8 = Stop()//51.4
        stop8.stopID = 8
        stop8.stopCode = "128"
        stop8.stopName = "Over 50 miles - Test1"
        stop8.stopLat = 40.303519
        stop8.stopLong = -74.675903
        stop8.zoneID = 0
        lstBusStop.append(stop8)
        
        let stop9 = Stop()//58.53
        stop9.stopID = 9
        stop9.stopCode = "129"
        stop9.stopName = "Over 100 miles - Test2"
        stop9.stopLat = 40.219198
        stop9.stopLong = -74.754223
        stop9.zoneID = 0
        lstBusStop.append(stop9)
        
        let stop10 = Stop()//2.35
        stop10.stopID = 10
        stop10.stopCode = "130"
        stop10.stopName = "Hackensack - Test1"
        stop10.stopLat = 40.881938
        stop10.stopLong = -74.041823
        stop10.zoneID = 0
        lstBusStop.append(stop10)
        
        
        
        
        /* Trip */
        
        let trip1 = Trip()
        trip1.tripID = 1
        trip1.routeID = 1
        trip1.directionID = 0
        trip1.serviceID = 1
        trip1.tripHeadSign = "155 XXXX viaTeaneck Rd"
        lstBusTrip.append(trip1)
        
        let trip2 = Trip()
        trip2.tripID = 2
        trip2.routeID = 1
        trip2.directionID = 0
        trip2.serviceID = 1
        trip2.tripHeadSign = "155 XXXX viaTeaneck Rd"
        lstBusTrip.append(trip2)
        
        let trip21 = Trip()
        trip21.tripID = 21
        trip21.routeID = 1
        trip21.directionID = 1
        trip21.serviceID = 1
        trip21.tripHeadSign = "155 NEWYORK"
        lstBusTrip.append(trip21)
        
        let trip22 = Trip()
        trip22.tripID = 22
        trip22.routeID = 1
        trip22.directionID = 1
        trip22.serviceID = 1
        trip22.tripHeadSign = "155 NEWYORK"
        lstBusTrip.append(trip22)
    
        let trip23 = Trip()
        trip23.tripID = 23
        trip23.routeID = 1
        trip23.directionID = 1
        trip23.serviceID = 1
        trip23.tripHeadSign = "155 NEWYORK"
        lstBusTrip.append(trip23)
 
        
        let trip3 = Trip()
        trip3.tripID = 3
        trip3.routeID = 2
        trip3.directionID = 0
        trip3.serviceID = 1
        trip3.tripHeadSign = "157 XXXX viaTeaneck Rd"
        lstBusTrip.append(trip3)
        
        let trip4 = Trip()
        trip4.tripID = 4
        trip4.routeID = 2
        trip4.directionID = 1
        trip4.serviceID = 1
        trip4.tripHeadSign = "157 NEWYORK viaTeaneck Rd"
        lstBusTrip.append(trip4)
        
        let trip5 = Trip()
        trip5.tripID = 5
        trip5.routeID = 3
        trip5.directionID = 1
        trip5.serviceID = 1
        trip5.tripHeadSign = "167 T NEWYORK"
        lstBusTrip.append(trip5)
        
        let trip6 = Trip()
        trip6.tripID = 6
        trip6.routeID = 3
        trip6.directionID = 0
        trip6.serviceID = 1
        trip6.tripHeadSign = "167 XXXX"
        lstBusTrip.append(trip6)
        
        let trip7 = Trip()
        trip7.tripID = 7
        trip7.routeID = 3
        trip7.directionID = 0
        trip7.serviceID = 1
        trip7.tripHeadSign = "167 XXXX"
        lstBusTrip.append(trip7)
        
        let trip8 = Trip()
        trip8.tripID = 8
        trip8.routeID = 3
        trip8.directionID = 0
        trip8.serviceID = 1
        trip8.tripHeadSign = "167 XXXX"
        lstBusTrip.append(trip8)
        
        let trip9 = Trip()
        trip9.tripID = 9
        trip9.routeID = 4
        trip9.directionID = 1
        trip9.serviceID = 1
        trip9.tripHeadSign = "2000 NEWYORK"
        lstBusTrip.append(trip9)
        
        let trip10 = Trip()
        trip10.tripID = 10
        trip10.routeID = 4
        trip10.directionID = 0
        trip10.serviceID = 1
        trip10.tripHeadSign = "2000 XXXX"
        lstBusTrip.append(trip10)
        
        let trip11 = Trip()
        trip11.tripID  = 11
        trip11.routeID = 11
        trip11.directionID = 1
        trip11.serviceID = 1
        trip11.tripHeadSign = "2001 ONLY NEWYORK"
        lstBusTrip.append(trip11)
        
        let trip12 = Trip()
        trip12.tripID  = 12
        trip12.routeID = 11
        trip12.directionID = 1
        trip12.serviceID = 1
        trip12.tripHeadSign = "2001 ONLY NEWYORK"
        lstBusTrip.append(trip12)
        
        
        /* Stop Trip Time */
        
        //Teaneck Rd - Test1, 155 XXXX viaTeaneck Rd
        let stopTime1 = StopTime()
        stopTime1.stopID = 1
        stopTime1.tripID = 1
        stopTime1.arrivalTime = "08:00:00"
        lstBusStopTime.append(stopTime1)
 
        //Teaneck Rd - Test1, 155 XXXX viaTeaneck Rd
        let stopTime11 = StopTime()
        stopTime11.stopID = 1
        stopTime11.tripID = 2
        stopTime11.arrivalTime = "09:00:00"
        lstBusStopTime.append(stopTime11)

        //Teaneck Rd - Test2, 155 XXXX viaTeaneck Rd
        let stopTime2 = StopTime()
        stopTime2.stopID = 2
        stopTime2.tripID = 1
        stopTime2.arrivalTime = "08:10:00"
        lstBusStopTime.append(stopTime2)

        //Teaneck Rd - Test3, 155 NEWYORK
        let stopTime3 = StopTime()
        stopTime3.stopID = 3
        stopTime3.tripID = 21
        stopTime3.arrivalTime = "07:10:00"
        lstBusStopTime.append(stopTime3)
        
        //Teaneck Rd - Test3, 155 NEWYORK
        let stopTime4 = StopTime()
        stopTime4.stopID = 3
        stopTime4.tripID = 22
        stopTime4.arrivalTime = "18:00:00"
        lstBusStopTime.append(stopTime4)

        //Teaneck Rd - Test3, 155 NEWYORK
        let stopTime5 = StopTime()
        stopTime5.stopID = 3
        stopTime5.tripID = 23
        stopTime5.arrivalTime = "19:00:00"
        lstBusStopTime.append(stopTime5)

        
        //Queen Anne Rd - Test2, 167 T NEWYORK
        let stopTime6 = StopTime()
        stopTime6.stopID = 6
        stopTime6.tripID = 5
        stopTime6.arrivalTime = "07:30:00"
        lstBusStopTime.append(stopTime6)

        //Over 50 miles - Test1, 167 T NEWYORK
        let stopTime61 = StopTime()
        stopTime61.stopID = 8
        stopTime61.tripID = 5
        stopTime61.arrivalTime = "08:20:00"
        lstBusStopTime.append(stopTime61)

        //Over 50 miles - Test1, 2000 NEWYORK
        let stopTime7 = StopTime()
        stopTime7.stopID = 8
        stopTime7.tripID = 9
        stopTime7.arrivalTime = "08:00:00"
        lstBusStopTime.append(stopTime7)

         //Over 100 miles - Test1, 2000 NEWYORK
        let stopTime71 = StopTime()
        stopTime71.stopID = 9
        stopTime71.tripID = 9
        stopTime71.arrivalTime = "08:30:00"
        lstBusStopTime.append(stopTime71)

        //Over 100 miles - Test2, 2000 XXXX
        let stopTime8 = StopTime()
        stopTime8.stopID = 9
        stopTime8.tripID = 10
        stopTime8.arrivalTime = "09:10:00"
        lstBusStopTime.append(stopTime8)

        //Over 100 miles - Test2, 2001 ONLY NEWYORK
        let stopTime9 = StopTime()
        stopTime9.stopID = 9
        stopTime9.tripID = 11
        stopTime9.arrivalTime = "09:20:00"
        lstBusStopTime.append(stopTime9)
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testBUSGetAllStopsFilteredByLocation_Base()
    {
       /* let transitController = TransitController(_lstBusStop: lstBusStop, _lstTrainStop: lstTrainStop, _lstBusStopTime: lstBusStopTime, _lstTrainStopTime: lstTrainStopTime, _lstBusTrip: lstBusTrip, _lstTrainTrip: lstTrainTrip )
        
        
        
        let filterCriteria = TransitFilterCriteria()
        let setting = TransitSetting()
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
        let location = CLLocation(latitude: 40.8537810, longitude: -74.0162710)
        let date = (userCalendar.date(from: dateSetting))!
        //let sds = outFormatter.stringFromDate(date)
        //print(dateSetting)
        //filterCriteria.filterDateTme = outFormatter.stringFromDate(date)
        filterCriteria.filterDateTme = date
        filterCriteria.location = location
        filterCriteria.transitType = TransitType.bus.description
        
        setting.settingBusFilterDistance = 1.5
        setting.settingFilterTime = 30
 
        var result = try? transitController.getTransitResult(filterCriteria, transitSetting: setting)
        XCTAssertEqual(result!.lstStop.count, 1)//155 XXXX viaTeaneck Rd
        XCTAssertEqual(result!.lstStopTime.first?.arrivalTime, "08:00:00")
        XCTAssertEqual(result!.lstTrip.first?.tripHeadSign, "155 XXXX viaTeaneck Rd")
        
        setting.settingFilterTime = 10
 
        result = try? transitController.getTransitResult(filterCriteria, transitSetting: setting)
        XCTAssertEqual(result!.lstStopTime.count, 0)

        setting.settingBusFilterDistance = 3
        setting.settingFilterTime = 45
        result = try? transitController.getTransitResult(filterCriteria, transitSetting: setting)
 
        XCTAssertEqual(result!.lstStopTime.count, 2)
        XCTAssertEqual(result!.lstStopTime.first?.arrivalTime, "08:00:00")
        XCTAssertEqual(result!.lstTrip.first?.tripHeadSign, "155 XXXX viaTeaneck Rd")
        
        XCTAssertEqual(result!.lstStopTime.last?.arrivalTime, "08:10:00")
        XCTAssertEqual(result!.lstTrip.last?.tripHeadSign, "155 XXXX viaTeaneck Rd")

*/
        
    }
    func testGetBusStopsFromServer()
    {
       let transitController = TransitController()
       let stops = transitController.getBusStops
        
        XCTAssertTrue(stops?.count > 0)
        
        let stopsagain = transitController.getBusStops

        XCTAssertTrue(stopsagain?.count > 0)

    }
    
}
