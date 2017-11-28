//
//  mapViewController.swift
//  Covfefe
//
//  Created by Hadley Griffin on 10/30/17.
//  Copyright © 2017 asu. All rights reserved.
//

import UIKit
import MapKit

class mapViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    
    @IBOutlet weak var placesTable: UITableView!
  
    @IBOutlet weak var city: UITextField!
    
    @IBOutlet weak var map: MKMapView!
    
    let locationManager = CLLocationManager()
    
    var searchD : searchData = searchData()

    var latitude : CLLocationDegrees?
    
    var long : CLLocationDegrees?
    
    var correctCity : String?
    
    var thisMatchingItems: [MKMapItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        refreshUI()
        // Do any additional setup after loading the view.
        
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    func refreshUI()
    { DispatchQueue.main.async
        { self.placesTable.reloadData() }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches.count
    }
    
    // Creates each cell of the table
    func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = matches[indexPath.row].getName();
        
        return cell;
    }
    
    @IBAction func search(_ sender: Any) {
      
            
        //refreshUI()
        
        let geoCoder = CLGeocoder();
        
        var addressString:String = ""
  
        //get the city location
        
        if let x = self.city.text, !x.isEmpty
        {
            addressString = self.city.text!
        }
        else
        {
            print("No city was entered")
        }
        
        
        //locate city and show city on map
        CLGeocoder().geocodeAddressString(addressString, completionHandler:
            {(placemarks, error) in
                
                if error != nil {
                    print("Geocode failed: \(error!.localizedDescription)")
                }
                else if placemarks!.count > 0 {
                    
                    let placemark = placemarks![0]
                    
                    let location = placemark.location
                    print (location)
                    
                    let coords = location!.coordinate
                    
                    self.long = coords.longitude
                    
                    self.latitude = coords.latitude
                    
                    geoCoder.reverseGeocodeLocation(location!, completionHandler: { (placemarks, error) -> Void in
                        
                        // Place details
                        var placeMark: CLPlacemark!
                        placeMark = placemarks?[0]
                        
                        // Address dictionary
                        print(placeMark.addressDictionary as Any)
                        
                        // Location name
                        if let locationName = placeMark.addressDictionary!["Name"] as? NSString {
                            print(locationName)
                        }
                       
                        // City
                        if let city = placeMark.addressDictionary!["City"] as? NSString {
                            print(city)
                            self.correctCity = city as String
                        }
                        
                    })

                    
                    print(location)
                    
                    let span = MKCoordinateSpanMake(0.05, 0.05)
                    
                    let region = MKCoordinateRegion(center: placemark.location!.coordinate, span: span)
                    
                    self.map.setRegion(region, animated: true)
                    
                    
                    //set annotation to point type
                    let ani = MKPointAnnotation()
                    
                    ani.coordinate = placemark.location!.coordinate
                    
                    //show city name in annotation
                    ani.title = placemark.locality
                    
                    ani.subtitle = placemark.subLocality
                    
                    //add annotations to app
                    self.map.addAnnotation(ani)
                    
                }
        })

        

    
        
        
    }
    
    
    @IBAction func findShops(_ sender: Any) {
        
        let allAnnotations = self.map.annotations
        
        self.map.removeAnnotations(allAnnotations)
        
        let geoCoder = CLGeocoder();
        
    
                
            
                    let coordinates = CLLocationCoordinate2D ( latitude: self.latitude!, longitude: self.long!)
                    
                    //set span and region for places to be searced
                    let span: MKCoordinateSpan = MKCoordinateSpanMake(0.035, 0.035)
                    
                    let region: MKCoordinateRegion = MKCoordinateRegionMake(coordinates, span)
                    
                    //show region on map view
                    self.map.setRegion(region, animated: true)
                    
                    let localRequest = MKLocalSearchRequest()
                    
                    
                    
                    
                    //search for places
                    
                    localRequest.naturalLanguageQuery = "coffee"
                    
                    localRequest.region = self.map.region
                    
                    let search = MKLocalSearch(request: localRequest)
                    
        search.start{ (search, error) -> Void in
            
            //store searched items in an array
            
            
            self.searchD.add(response: (search?.mapItems)!)
            
            self.thisMatchingItems = (search?.mapItems)!
            
            //for each matching place, print the place name in console and display annotation on map
            for i in 1...(self.thisMatchingItems.count - 1)
            {
                let place = self.thisMatchingItems[i].placemark
                
                //create point type annotation
                let ani = MKPointAnnotation()
                
                ani.coordinate = place.location!.coordinate
                
                //show place name in annotation
                ani.title = place.name
                
                //add annotation to map
                self.map.addAnnotation(ani)
            }
            DispatchQueue.main.async
                { self.placesTable.reloadData() }
        }
        
    
    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "toShopInfo"
        {
            for i in matches
            {
                print (i.getName())
            }
            
            
            let selectedIndex: IndexPath = (self.placesTable.indexPath(for: sender as! UITableViewCell)!)
        
        
            let name = matches[selectedIndex.row].getName();
        
            let shopIndex = selectedIndex.row;
        
        
            let des = segue.destination as! shopInfoViewController
            des.shopIndex = shopIndex
            des.shopCity = correctCity
            des.selectedName = name
        }
        
    }
    
    @IBAction func returnedFromShopInfo(segue: UIStoryboardSegue)
    {
        
        
    }
    

    // move the view upwards as keyboard appears
    func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y -= 150
    }
    
    // move the keyboard back as keyboard disapears
    
    func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y += 150
    }
    
    // make the keyboard disapear as user touches outside the  text boxes
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        self.city.resignFirstResponder()
      
    }
 

}
