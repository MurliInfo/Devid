//
//  Testimonial.swift
//  DavidWeir
//
//  Created by Hardik Davda on 4/10/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit

class Testimonial: UIViewController {
    @IBOutlet var table : UITableView!
    var TestimonialList = [TestimonilalList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = UIColor().NavigationBar()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        
        //self.table.contentInset = UIEdgeInsets.zero
        
        self.table.estimatedRowHeight = 50
        self.table.rowHeight = UITableViewAutomaticDimension
        
        self.table.setNeedsLayout()
        self.table.layoutIfNeeded()
        
        self.table.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        GloabalMethods().TestimonialListData(completion: { (demo) in
            DispatchQueue.main.async {
                self.TestimonialList = demo
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

extension Testimonial : UITableViewDataSource,UITableViewDelegate{
     public func numberOfSections(in tableView: UITableView) -> Int    {
        return TestimonialList.count
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1// TestimonialList.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let printData = TestimonialList[indexPath.section]
        let cell:CustomCell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell! as! CustomCell
        cell.backgroundColor = GloabalMethods().hexStringToUIColor(hex: "f7f7f7")
        cell.layer.borderWidth = 1
        cell.layer.borderColor = GloabalMethods().hexStringToUIColor(hex: "eeeeee").cgColor
        cell.lblTitle.text = printData.strTitle
        cell.lblDate.text = printData.strDate
        cell.lblDescription.text = printData.strContent
        cell.lblAuthour.text = printData.strAuthour
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 10
    }
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        let viewHeader = UIView(frame: CGRect(x: 0, y: 0, width: table.frame.size.width, height: 10))
        viewHeader.backgroundColor = UIColor.clear
        return viewHeader
    }
}
