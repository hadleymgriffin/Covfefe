//
//  WKWebViewController2.swift
//  Covfefe
//
//  Created by Hadley Griffin on 11/19/17.
//  Copyright © 2017 asu. All rights reserved.
//

import UIKit
import WebKit

class WKWebViewController2: UIViewController {
    
    var webView2:WKWebView?
    var website : String?
    var fullSite : String = "https://"
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        
        
        
        
        let x = website!
        var found : Bool = false
        var startCopy : Bool = false
        var secondHalf : String = ""
        for i in x.characters
        {
            
            if (startCopy == true)
            {
                secondHalf += String(i)
            }
            
            if(i == "/" && found == false)
            {
                found = true
            }
            else if(i == "/" && found == true)
            {
                startCopy = true
            }
            else{ }
            
        }
        
        
        
        fullSite += secondHalf
        
        
        
        
       
        let screenSize: CGRect = UIScreen.main.bounds
        let myView = UIView(frame: CGRect(x: 0, y: 72, width: screenSize.width, height: screenSize.height-72))
        self.view.addSubview(myView)
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        let configuration  = WKWebViewConfiguration()
        configuration.preferences = preferences
        webView2 = WKWebView(frame : myView.frame , configuration : configuration)
        webView2?.navigationDelegate = self as? WKNavigationDelegate 
        view.addSubview(webView2!)
        webView2?.load(URLRequest(url : URL (string: fullSite)!))
        webView2?.allowsBackForwardNavigationGestures = true
        
        // Do any additional setup after loading the view.
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func back(_ sender: Any) {
        
        webView2?.goBack()
    }
    
    
    @IBAction func forward(_ sender: Any) {
        webView2?.goForward();
    }
    

}
