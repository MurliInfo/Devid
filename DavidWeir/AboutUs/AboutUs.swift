//
//  AboutUs.swift
//  DavidWeir
//
//  Created by Hardik Davda on 4/10/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit

class AboutUs: UIViewController {
    @IBOutlet var table : UITableView!
    
    var AboutList = [AboutUsContent]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = UIColor().NavigationBar()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        
        //self.table.contentInset = UIEdgeInsets.zero

        self.table.estimatedRowHeight = 80
        self.table.rowHeight = UITableViewAutomaticDimension
        
        self.table.setNeedsLayout()
        self.table.layoutIfNeeded()

        self.table.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        GloabalMethods().AboutUsText(completion: { (demo) in
            DispatchQueue.main.async {
                self.AboutList = demo
                print(demo)
                self.table.reloadData()
            }
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension AboutUs : UITableViewDataSource,UITableViewDelegate{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AboutList.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          var cell:CustomCell = CustomCell ()
        
        if indexPath.row == 0{
            cell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell! as! CustomCell
        }else{
            cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as UITableViewCell! as! CustomCell
            cell.lblContant.text = AboutList[indexPath.row].strContent
        }
        
        return cell
    }
}
