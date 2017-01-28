//
//  ViewController.swift
//  NJTransit
//
//  Created by Gokul Narasimhan on 8/13/16.
//  Copyright © 2016 GokulNarasimhan. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet var tapView: UIView?
    let tapRec = UITapGestureRecognizer()

   
    lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "GokulNarasimhan.NJTransit" in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()

    
    fileprivate var stops:[Stop] = []
   // var fetchResultController:NSFetchedResultsController<AnyObject>!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        tapRec.addTarget(self, action: #selector(ViewController.showMap))
        tapView!.addGestureRecognizer(tapRec)
        tapView!.isUserInteractionEnabled = true
    }

   

    
    func showMap(){
      /*  let tapAlert = UIAlertController(title: "Tapped", message: "You just tapped the tap view", preferredStyle: UIAlertControllerStyle.Alert)
        tapAlert.addAction(UIAlertAction(title: "OK", style: .Destructive, handler: nil))
        self.presentViewController(tapAlert, animated: true, completion: nil)*/
        
        let mapViewController = storyboard?.instantiateViewController(withIdentifier: "navigatingMapViewController") as! MapViewController
        
        present(mapViewController, animated: true, completion: nil)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

