//
//  shopInfoViewController.swift
//  Covfefe
//
//  Created by Hadley Griffin on 10/31/17.
//  Copyright © 2017 asu. All rights reserved.
//

import UIKit


class shopInfoViewController: UIViewController {

   
    @IBOutlet weak var shopNameText: UITextView!
    
    @IBOutlet weak var cityText: UITextView!
    
    @IBOutlet weak var phoneText: UITextView!
    var shopIndex: Int?
    
    @IBOutlet weak var weatherText: UITextView!
    

    @IBOutlet weak var addedIndicator: UITextView!
    
    @IBOutlet weak var buttonView: UIView!
    
    @IBOutlet weak var visitSiteButton: UIButton!
    
    var shopCity: String?
    
    var temp : String?
    
    var degrees : String = " degrees fahrenheit"
    
    var shopPhone: String?
    
    var shopWebsiteAsString: String?
    
    var data : searchData = searchData()
    
    var favCoreData: favShopCoreData = favShopCoreData()
    
    var shopName : String = ""
    
    var selectedName : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        let data: record = self.data.getRecord(selectedName as! NSString)
        
        addedIndicator.isHidden = true;
        
        shopName = data.getName()
        
        shopPhone = data.getPhone()
        
        shopWebsiteAsString = data.getUrl()
        
        shopNameText.text = shopName
        
        phoneText.text = shopPhone
        
        cityText.text = shopCity
        
        weatherText.isHidden = true
        
        if (shopWebsiteAsString == "No website found")
        {
            visitSiteButton.isHidden = true
            buttonView.isHidden = true
        }
        
        
        DispatchQueue.main.async(execute: {
            self.getWeather()
        })
        
    
       
    
        
    }

    
    func getWeather()
    {
        var urlAsString = "https://api.apixu.com/v1/current.json?key=f817d0015071487ca3d32540171911&q="
        
        urlAsString += shopCity!
        let url = URL(string: urlAsString)!
      
        let configuration = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: url, completionHandler: { [weak self] (data: Data?, response: URLResponse?, error: Error?) -> Void in
            // Parse the data in the response and use it
          
            
            var err: NSError?
            var jsonResult = (try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
            if (err != nil) {
                print("JSON Error \(err!.localizedDescription)")
            }
            
            print(jsonResult)
            
            let current = jsonResult["current"] as? [String: Any]
            let temp_f = current?["temp_f"] as? Double
            
            var temperature = temp_f!
            
            self?.temp = String(describing: temperature)
            
            self?.weatherText.text = (self?.temp!)! + (self?.degrees)!
        
            self?.weatherText.isHidden = false
            
        })
        task.resume()
        
    }
    


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    @IBAction func addToFavorites(_ sender: Any) {
        
        favCoreData.save(name: shopName, phone: shopPhone!, url: shopWebsiteAsString!)
        
        addedIndicator.text = shopName + " was added to favorite shops list"
        addedIndicator.isHidden = false
    }
 
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "toWeb"
        {
            let des = segue.destination as! WKWebViewController
            des.website = shopWebsiteAsString
            
        }
        
    }
    
    
    @IBAction func returnedFromWeb(segue: UIStoryboardSegue)
    {
        
        
    }
    


}
