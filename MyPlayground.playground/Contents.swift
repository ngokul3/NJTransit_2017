//: Playground - noun: a place where people can play

import Cocoa
import CoreLocation
import XCPlayground

extension String
{
    func toDateTime() -> NSDate
    {
      /*  let dateFormatter = DateFormatter()
       // dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.timeZone = NSTimeZone.local
   
        dateFormatter.dateFormat = "HH:mm:ss"
        //let dateFromString : NSDate = (dateFormatter.dateFromString(self))!
       
        return dateFormatter.date(from: self)! as NSDate*/
        
        return NSDate()

    }
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


class Stop {
     var stopID:Int32?
     var stopName:String?
     var stopCode:String?
     var stopDesc:String?
     var stopLat:Double?
     var stopLong:Double?
     var zoneID:Int32?
    
    init()
    {
    
    }
    init( a: Int32?, b: String?, c: String?, _ d: String?, _ e: Double?, _ f: Double?, _ g: Int32?) {
        
      //  super.init()
        stopID = a
        stopName = b
        stopCode = c
        stopDesc = d
        stopLat = e
        stopLong = f
        zoneID = g
        
    }
    
}

class StopTime: NSManagedObject{
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



var stops:[Stop] = []

let stop1 = Stop()
stop1.stopID = 0
stop1.stopCode = "a"
stop1.stopDesc = "b32"
stop1.stopName = "25"
stop1.zoneID = 1
stop1.stopLat = 39.376359
stop1.stopLong = -74.537871

let stop2 = Stop()
stop2.stopID = 2
stop2.stopCode = "a12"
stop2.stopDesc = "bwr"
stop2.stopName = "b354"
stop2.zoneID = 1
stop2.stopLat = 39.390589
stop2.stopLong = -74.522791

let stop3 = Stop()
stop3.stopID = 3
stop3.stopCode = "a34"
stop3.stopDesc = "b234"
stop3.stopName = "br2r"
stop3.zoneID = 1
stop3.stopLat = 39.42373
stop3.stopLong = -74.500402

let stop4 = Stop()
stop4.stopID = 0
stop4.stopCode = "a34"
stop4.stopDesc = "b234"
stop4.stopName = "br2r"
stop4.zoneID = 1
stop4.stopLat = 40.867568
stop4.stopLong = -74.500402



stops.append(stop1)
stops.append(stop2)
stops.append(stop3)
stops.append(stop4)



var lstBusTrip = [Trip]()

let trip1 = Trip()
trip1.tripID = 1
trip1.routeID = 1
trip1.directionID = 0
trip1.serviceID = 1
trip1.tripHeadSign = "155 XXXX viaTeaneck Rd"
trip1.truncatedTripHeadSign = "XXXX viaTeaneck Rd"
lstBusTrip.append(trip1)

let trip2 = Trip()
trip2.tripID = 2
trip2.routeID = 1
trip2.directionID = 0
trip2.serviceID = 1
trip2.tripHeadSign = "155 XXXX viaTeaneck Rd"
trip2.truncatedTripHeadSign = "XXXX viaTeaneck Rd"
lstBusTrip.append(trip2)

let trip21 = Trip()
trip21.tripID = 21
trip21.routeID = 1
trip21.directionID = 1
trip21.serviceID = 1
trip21.tripHeadSign = "155 NEWYORK"
trip21.truncatedTripHeadSign = "NEWYORK"
lstBusTrip.append(trip21)

let trip22 = Trip()
trip22.tripID = 22
trip22.routeID = 1
trip22.directionID = 1
trip22.serviceID = 1
trip22.tripHeadSign = "155 NEWYORK via Main"
trip22.truncatedTripHeadSign = "NEWYORK via Main"

lstBusTrip.append(trip22)

let trip23 = Trip()
trip23.tripID = 23
trip23.routeID = 1
trip23.directionID = 1
trip23.serviceID = 1
trip23.tripHeadSign = "155 NEWYORK"
trip23.truncatedTripHeadSign = "NEWYORK"

lstBusTrip.append(trip23)

var testSet = Set<String>()
print(9)

 testSet = Set<String>().union(lstBusTrip.map{$0.truncatedTripHeadSign!})

/*testSet = lstBusTrip.map{$0.truncatedTripHeadSign!}.reduce(NSSet()){
    set, like in
    return set.setByAddingObject(like)
} as! Set<String>*/

//print(testSet)
print(1)

for aa in testSet
{
   // print(aa)
}

let l4 = CLLocation(latitude: 40.854548999999999, longitude: -73.982780000000005)
let l41 = CLLocation(latitude: 40.8537810, longitude: -74.0162710)

var ll3 = l4.distance(from: l41 )

print(ll3)


//et myArray = Array(testSet)

//print (myArray[0])





let inFormatter = DateFormatter()
inFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
inFormatter.dateFormat = "HH:mm"

let outFormatter = DateFormatter()
outFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
outFormatter.dateFormat = "hh:mm"


let inStr = "16:50"
var date = inFormatter.date(from: inStr)!
let outStr = outFormatter.string(from: date)
print(date)


let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "hh:mm"
 date = dateFormatter.date(from: "00:00")!
var str_from_date = dateFormatter.string (from: date)

/*
//print(str_from_date)
let myLocation = CLLocation(latitude: 40.8537810, longitude: -74.0162710)


let mapArray = stops.map({CLLocation(latitude: $0.stopLat! as Double, longitude: $0.stopLong! as Double)})

//print(mapArray)

let mmArray =  (stopCode: stops.map({$0.stopCode}), stopName: stops.map({$0.stopDesc}), stopLocation: stops.map({CLLocation(latitude: $0.stopLat! as Double, longitude: $0.stopLong! as Double)}) )


let ffFilterArray = mmArray.stopCode
let filterArray = mapArray.filter({ myLocation.distanceFromLocation($0) * 0.000621371 < 105})

var getArray = stops.filter{
    
    //var yy = filterArray.map({$0.coordinate.latitude})
    
    var x = CLLocation(latitude: $0.stopLat! as Double, longitude: $0.stopLong! as Double)
 //   print(x)
    return filterArray.contains
        {
            var yy = $0
            if ( x.coordinate.latitude == $0.coordinate.latitude && x.coordinate.longitude == $0.coordinate.longitude)
            {
                return true
            }
            else {return false}
    }
    //return $0.stopLat > 0
}


var getArray2 = stops.filter{
      var x = CLLocation(latitude: $0.stopLat! as Double, longitude: $0.stopLong! as Double)
    var yy = filterArray.map({$0.coordinate.latitude})
    
    var ii = filterArray.filter({$0.coordinate.latitude == x.coordinate.latitude && $0.coordinate.longitude == x.coordinate.longitude})
    
   
    if(ii.count != 0)
    {
        return true
    }
    else{
        return false
    }
    
  
    
}


//print (getArray2)

let locationManager = CLLocationManager()


locationManager.location

let ll1 = CLLocation(latitude: 40.8537810, longitude: -74.0162710)

let ll2 = CLLocation(latitude: 39.376359, longitude: -74.537871)
let ll21 = CLLocation(latitude: 39.390589, longitude: -74.522791)
let ll22 = CLLocation(latitude: 39.42373, longitude: -74.500402)

let l4 = CLLocation(latitude: 40.881938, longitude: -74.041823)
var ll3 = ll1.distanceFromLocation(l4 )


var lstBusStopTime = [StopTime]()

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

 var stop = stops.map({$0.stopID})

*/

/******** POC to filter Stop Time********************************/
/*
var filteredStopTime = lstBusStopTime.filter
{
    let mappedTime = $0.arrivalTime > "07:00:00" && $0.arrivalTime < "08:11:00"
    let stopTimeStop = $0.stopID!
    
      let stopFiltered = stops.filter{
        
        $0.stopID == stopTimeStop
    }
    
    if(stopFiltered.count != 0 && mappedTime)
    {
        return true
    }
    else{
        return false
    }

}


var filteredStopTime1 = lstBusStopTime.filter
    {
        let mappedTime = $0.arrivalTime > "07:00:00" && $0.arrivalTime < "08:11:00"
        
       /* func ass(a : [StopTime])
        {
            
        }*/
        
        if (!mappedTime)
        {
            return false
        }
       
        print(mappedTime)
        
        let stopTimeStop =  $0.stopID!
        
        let stopFiltered = stops.filter{
            
            $0.stopID == stopTimeStop
        }
        
        if(stopFiltered.count != 0 && mappedTime)
        {
            return true
        }
        else{
            return false
        }
        
}

*/



//print(ll3 * 0.000621371)
//print(l4)
/*
let dateSetting = NSDateComponents()

dateSetting.timeZone = NSTimeZone(name:  "America/New_York")
dateSetting.day = 06
dateSetting.hour = 10
dateSetting.minute = 40
dateSetting.month = 9
dateSetting.year = 2016

let userCalendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)

let location = CLLocation(latitude: 40.8537810, longitude: -74.0162710)

let filterDateTme = userCalendar?.dateFromComponents(dateSetting)!

//print(232)
//print(filterDateTme)
let sourceDate = NSDate();
let sourceTimeZone = NSTimeZone(abbreviation: "GMT")!;
let destinationTimeZone = NSTimeZone.systemTimeZone();
//print(destinationTimeZone)
//print(sourceTimeZone)
//print(NSDate())

*/

/********** POC 2 Get current lat & long *******/
 
 /*


var ll3 = ll1.distanceFromLocation(ll2)

//print(ll3 * 0.000621371)

ll3 = ll1.distanceFromLocation(ll21)

//print(ll3 * 0.000621371)
ll3 = ll1.distanceFromLocation(ll22)
//print(ll3 * 0.000621371)
*/

/*********** POC 3 - Given address string or Zip code, get lat & long */////////


let address = "1 Infinite Loop"

var coder = CLGeocoder()
/*
coder.geocodeAddressString("1 infinite loop, cupertino, ca") { (placemarks, error) -> Void in
    
    if let firstPlacemark = placemarks?[0] {
        print(firstPlacemark)
    }
}

*/

 /*   CLGeocoder().geocodeAddressString("07660", completionHandler: { (placemarks, error) in
        if error != nil {
            print(90)
            print(error)
            return
        }
        else{
            print(88)
        }
        
        print(placemarks?.count)
        if placemarks?.count > 0 {
            let placemark = placemarks?[0]
            let location = placemark?.location
            let coordinate = location?.coordinate
            print("\nlat: \(coordinate!.latitude), long: \(coordinate!.longitude)")
            if placemark?.areasOfInterest?.count > 0 {
                let areaOfInterest = placemark!.areasOfInterest![0]
                print(areaOfInterest)
            } else {
                print("No area of interest found.")
            }
        }
    })

XCPSetExecutionShouldContinueIndefinitely()

*/





/*
let dateFormatter1 = NSDateFormatter()
dateFormatter1.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
dateFormatter1.timeZone = NSTimeZone(name: "UTC")
let date1 = dateFormatter1.dateFromString("2015-04-01T11:42:00")// create   date from string
//print(date1)
// change to a readable time format and change to local time zone
dateFormatter1.dateFormat = "EEE, MMM d, yyyy - h:mm a"
dateFormatter1.timeZone = NSTimeZone.localTimeZone()
let timeStamp = dateFormatter1.stringFromDate(date1!)
//print(dateFormatter1.timeZone)
//print(timeStamp)

dateFormatter1.dateFormat = "HH:mm:ss"
let date2 = dateFormatter1.dateFromString("07:16:00")
let date3 = dateFormatter1.dateFromString("07:15:00")


print(date2!)
print(dateFormatter1.timeZone)
//print(dateFormatter1.stringFromDate(date2!))

//if (dateFormatter1.stringFromDate(date2!) > dateFormatter1.stringFromDate(date3!))
    if("19:14:00" > "07:15:00")
{
   // print(99)
}
else{
    //print(11)
}

let dateString2 = "07:10:00"

//print(dateString2.toDateTime())
let formatter = NSDateFormatter()
formatter.dateFormat = "HH:mm"
let hour = 08
let minutes = 32
let time = formatter.dateFromString("\(hour):\(minutes)")!
let finalTime = formatter.stringFromDate(time)
//print(time)
//print(finalTime)


*/
/*
extension NSDate {
    func add(_ minutes: Int) -> Date {
        let calendar = Calendar.current
        var comps = DateComponents()
        comps.minute = minutes
        // return calendar.date (byAdding: comps, to: self, options: [])! //ToDo
        
        return calendar.date(byAdding: comps, to: self as Date)!
        //date( (byAdding: .minute, value: minutes, to: self, options: [])!
    }
    
}
*/
/*

let date2 = NSDate();
// "Apr 1, 2015, 8:53 AM" <-- local w//ithout seconds

var formatter2 = NSDateFormatter();
formatter2.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ";
let defaultTimeZoneStr = formatter2.stringFromDate(date2);
//print(defaultTimeZoneStr)


let dateSetting = NSDateComponents()
dateSetting.day = 06
dateSetting.hour = 7
dateSetting.minute = 40
dateSetting.month = 9
dateSetting.year = 2016
dateSetting.timeZone = NSTimeZone(name:  "America/New_York")
let gregorianCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
let date3 = gregorianCalendar!.dateFromComponents(dateSetting)
*/
//print(date3)




