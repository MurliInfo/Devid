//
//  WebDataView.swift
//  DavidWeir
//
//  Created by Hardik Davda on 4/10/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit

class WebDataView: UIViewController ,UIWebViewDelegate {
    @IBOutlet var webData : UIWebView!
 
    var strUrl : String = String()
    var strTitle : String = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = UIColor().NavigationBar()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        self.title = strTitle
        print(strUrl)
        //webData.loadRequest(NSURLRequest(url: NSURL(string: "google.ca")! as URL) as URLRequest)
        let url = NSURL (string: strUrl);
        let requestObj = NSURLRequest(url: url! as URL);
        webData.loadRequest(requestObj as URLRequest);
        // Do any additional setup after loading the view.
    }
    
    @IBAction func Back(_ sender: Any) {
        webData.goBack()

    }
    
    @IBAction func Forward(_ sender: Any) {
        webData.goForward()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
