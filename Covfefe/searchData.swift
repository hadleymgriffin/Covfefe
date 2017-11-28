//
//  searchData.swift
//  Covfefe
//
//  Created by Hadley Griffin on 11/18/17.
//  Copyright © 2017 asu. All rights reserved.
//

import Foundation

import MapKit

var matches : [record] = []

class searchData
{
    
    
    
    func add(response: [MKMapItem])
    {
        //remove old match array
        var z : Int = matches.count - 1
        
        if (z == -1)
        {
            z = 0
        }
        
        for i in 0...z{
            if matches.count != 0
            {
                matches.remove(at: 0)
            }
 
        }
        //matchingItems = response
        
        for i in response
        {
            
            let place = i.placemark
            
            print(place.name!)
            
            print (i.name!)
            
            
        
            print (i.url)
            print (i.phoneNumber)
            
            
            var name = (i.name!)
            
            var phone: String?
            var url: String?
            
            if let x = i.phoneNumber, !x.isEmpty
            {
                phone = i.phoneNumber!
            }
            else
            {
                phone = "No phone number found"
            }
            
            if i.url != nil
            {
                url =  String(describing: i.url!)
            }
            else
            {
                url = "No website found"
            }
            
            var newEntry = record(n: name, p: phone!, u: url!)
            matches.append(newEntry)
            
        }
    }
    
    func getRecord(_ name:NSString) -> record
    {
        var j: Int = matches.count-1
        var r: record = record(n: " ", p: " " , u: " ")
        
        for i  in 0...j
        {
            if matches[i].getName() == name as String
            {
                r =  matches[i]
            }
        }
        return r
    }
    

    
}

class record
{
    fileprivate var name: String = ""
    fileprivate var phone:String = ""
    fileprivate var url:String = ""
    init (n: String, p: String,  u: String)
    {
        name = n
        phone = p
        url = u
        
    }
    
    internal func getName() -> String
    {
        return name
    }
    
    internal func getPhone() -> String
    {
        return phone
    }
    
    internal func getUrl() -> String
    {
        return url
    }
    
    
}
