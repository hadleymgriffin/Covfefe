//
//  favoriteShopInfoViewController.swift
//  Covfefe
//
//  Created by Hadley Griffin on 10/31/17.
//  Copyright © 2017 asu. All rights reserved.
//

import UIKit

class favoriteShopInfoViewController: UIViewController {

    @IBOutlet weak var shopNameText: UITextView!
    
    @IBOutlet weak var phoneText: UITextView!
    
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var visitSiteButton: UIButton!
    
    var website : String = ""
    
    var selectedName : String = ""
    
    var favCoreData : favShopCoreData = favShopCoreData()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        shopNameText.text = selectedName
        
        let record = favCoreData.find(sentName: selectedName)
        
        shopNameText.text = record.name
        
        phoneText.text = record.phone
        
        website = record.url
        
        if (website == "No website found")
        {
            visitSiteButton.isHidden = true
            buttonView.isHidden = true
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
       
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "toWeb2"
        {
            let des = segue.destination as! WKWebViewController2
            des.website = website
            
        }
        
    }
    
    @IBAction func returnedFromFavoriteDrink(segue: UIStoryboardSegue)
    {
        
        
    }
    
    
    @IBAction func returnedFromWeb2(segue: UIStoryboardSegue)
    {
        
        
    }



}
