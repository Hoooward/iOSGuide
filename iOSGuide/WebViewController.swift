//
//  WebViewController.swift
//  iOSGuide
//
//  Created by Howard on 3/7/16.
//  Copyright © 2016 Howard. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    // Properties
    var webView: WKWebView!
    
    // View controller left cycle
    override func loadView() {
        
        webView = WKWebView()
        view = webView
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        let url = NSURL(string: "https://www.bignerdranch.com")!
        
        let webRequest = NSURLRequest(URL: url)
        
        webView.loadRequest(webRequest)
    }
    
}
