//
//  favoriteDrinksViewController.swift
//  Covfefe
//
//  Created by Hadley Griffin on 10/31/17.
//  Copyright © 2017 asu. All rights reserved.
//

import UIKit

class favoriteDrinksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var drinkTable: UITableView!
    
    //create instance of favDrinkCoreData
    let favDrinkCore: favDrinkCoreData = favDrinkCoreData()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        drinkTable.reloadData()
        self.loadView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        drinkTable.reloadData()
        self.loadView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // number of rows based on the coredata storage
        return favDrinkCore.fetchRecord()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // add each row from coredata fetch results
        let cell = tableView.dequeueReusableCell(withIdentifier: "drinkCell", for: indexPath)
        
        //populate table by calling info in core data file (MVC)
        if favDrinkCore.fetchRecord() != 0
        {
            cell.textLabel?.text = favDrinkCore.fetchResults[indexPath.row].name
        }
        
        return cell
    }
    
    // delete table entry
    // this method makes each row editable
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    // return the table view style as deletable
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: IndexPath) -> UITableViewCellEditingStyle { return UITableViewCellEditingStyle.delete }
    
    
    // implement delete function
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        
        if editingStyle == .delete
        {
            
            favDrinkCore.managedObjectContext.delete(favDrinkCore.fetchResults[indexPath.row])
            // remove it from the fetch results array
            favDrinkCore.fetchResults.remove(at:indexPath.row)
            
            do {
                // save the updated managed object context
                try favDrinkCore.managedObjectContext.save()
            } catch {
                
            }
            // reload the table after deleting a row
            drinkTable.reloadData()
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDrinkDetail"
        {
            
            let selectedIndex: IndexPath = (self.drinkTable.indexPath(for: sender as! UITableViewCell)!)
            
            let name = favDrinkCore.fetchResults[selectedIndex.row].name;
            let price = favDrinkCore.fetchResults[selectedIndex.row].price;
            let calories = favDrinkCore.fetchResults[selectedIndex.row].calories;
            
            
            let des = segue.destination as! drinkInfoViewController
            des.name = name!
            des.price = price!
            des.calories = calories!
        }
        
    }
    
    @IBAction func returnedFromAddDrink(segue: UIStoryboardSegue)
    {
        
        
    }
    
    @IBAction func returnedFromAddDrinkWithAddedDrink(segue: UIStoryboardSegue)
    {
        drinkTable.reloadData()
        self.loadView()
        
    }
    
    @IBAction func returnedFromDrinkInfo(segue: UIStoryboardSegue)
    {
        drinkTable.reloadData()
        self.loadView()
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
