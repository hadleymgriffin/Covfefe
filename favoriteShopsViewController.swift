//
//  favoriteShopsViewController.swift
//  Covfefe
//
//  Created by Hadley Griffin on 10/30/17.
//  Copyright © 2017 asu. All rights reserved.
//

import UIKit

class favoriteShopsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    
    @IBOutlet weak var favoriteShopsTable: UITableView!
    
    let favCoreData: favShopCoreData = favShopCoreData()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // number of rows based on the coredata storage
        return favCoreData.fetchRecord()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // add each row from coredata fetch results
        let cell = tableView.dequeueReusableCell(withIdentifier: "shopCell", for: indexPath)
        
        if favCoreData.fetchRecord() != 0
        {
            cell.textLabel?.text = favCoreData.fetchResults[indexPath.row].name
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
            
            // delete the selected object from the managed
            // object context
            favCoreData.managedObjectContext.delete(favCoreData.fetchResults[indexPath.row])
            // remove it from the fetch results array
            favCoreData.fetchResults.remove(at:indexPath.row)
            
            do {
                // save the updated managed object context
                try favCoreData.managedObjectContext.save()
            } catch {
                
            }
            // reload the table after deleting a row
            favoriteShopsTable.reloadData()
        }
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toFavDetail"
        {
            
            let selectedIndex: IndexPath = (self.favoriteShopsTable.indexPath(for: sender as! UITableViewCell)!)
            
            let name = favCoreData.fetchResults[selectedIndex.row].name;
            

            let des = segue.destination as! favoriteShopInfoViewController
            des.selectedName = name!
        }
        
    }
    
    @IBAction func returnedFromFavoriteShopInfo(segue: UIStoryboardSegue)
    {
        
        
    }
    
    
  

}
