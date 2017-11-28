//
//  drinkInfoViewController.swift
//  Covfefe
//
//  Created by Hadley Griffin on 10/31/17.
//  Copyright © 2017 asu. All rights reserved.
//

import UIKit

class drinkInfoViewController: UIViewController {

    @IBOutlet weak var caloriesText: UITextView!
    @IBOutlet weak var priceText: UITextView!
    @IBOutlet weak var nameText: UITextView!
    
    var name : String = ""
    var price: String = ""
    var calories : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        nameText.text = name
        priceText.text = price
        caloriesText.text = calories
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
