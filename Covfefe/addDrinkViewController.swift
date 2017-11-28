//
//  addDrinkViewController.swift
//  Covfefe
//
//  Created by Hadley Griffin on 10/31/17.
//  Copyright © 2017 asu. All rights reserved.
//

import UIKit

class addDrinkViewController: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var caloriesText: UITextField!
    @IBOutlet weak var priceText: UITextField!
    
    //create instance of core data file
    var favDrinkCore : favDrinkCoreData = favDrinkCoreData()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    @IBAction func addDrink(_ sender: Any) {
        
        if let x = self.nameText.text, !x.isEmpty, let y = self.priceText.text, !y.isEmpty, let z = self.caloriesText.text, !z.isEmpty
        {
            let name = self.nameText.text!
            let price = self.priceText.text!
            let calories = self.caloriesText.text!
            
            //add drink through the core data file (MVC)
            favDrinkCore.save(name: name, price: price, calories: calories)
            
            self.nameText.text!  = ""
            self.priceText.text! = ""
            self.caloriesText.text! = ""
            
        }
        else
        {
            print ("one or more field empty")
        }
        
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
        self.nameText.resignFirstResponder()
        self.priceText.resignFirstResponder()
        self.caloriesText.resignFirstResponder()
    }
    
    

}
