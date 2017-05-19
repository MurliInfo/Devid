//
//  HomeOpen.swift
//  DavidWeir
//
//  Created by Hardik Davda on 4/10/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit

class HomeOpen: UIViewController {
    var HomeOpenList = [HomeOpenData]()
    @IBOutlet var table : UITableView!
    var NoData = NSString()//No Data Available
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = UIColor().NavigationBar()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        NoData = ""
        //self.table.contentInset = UIEdgeInsets.zero
        
//        self.table.estimatedRowHeight = 80
//        self.table.rowHeight = UITableViewAutomaticDimension
//        
//        self.table.setNeedsLayout()
//        self.table.layoutIfNeeded()
//        
//        self.table.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        GloabalMethods().HomeOpenList(completion: { (demo) in
            DispatchQueue.main.async {
                self.HomeOpenList = demo
                print(demo)
                self.NoData = "No Data Available"
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


    extension HomeOpen : UITableViewDataSource,UITableViewDelegate{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.HomeOpenList.count > 0 {
            TableViewHelper.EmptyMessage(message: "", viewController: self.table)
            return self.HomeOpenList.count
        } else {
            TableViewHelper.EmptyMessage(message: NoData as String, viewController: self.table)
            return 0
        }
       // return HomeOpenList.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CustomCell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell! as! CustomCell
        let printData = HomeOpenList[indexPath.row]
        cell.lblAddress.text = printData.strPropertyAddress
        cell.lblDate.text = printData.strBookDate
        cell.lblDay.text = printData.strDay
        cell.lblTime.text = printData.strTime
        return cell
    }
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: table.frame.size.width, height: 40))
        view.backgroundColor = UIColor().NavigationBar()
        let lblTitle = UILabel(frame: CGRect(x: 0, y: 0, width: table.frame.size.width, height: 40))
        lblTitle.font =  UIFont.boldSystemFont(ofSize: 16) //UIFont(name:"", size: 12)
        lblTitle.textColor = UIColor.white
        lblTitle.textAlignment = .center
        lblTitle.text = "Dashboard"
        view.addSubview(lblTitle)
        return view
    }
     public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
            return 40
    }

}
