//
//  PopView.swift
//  DelegateDemo
//
//  Created by Hardik Davda on 2/17/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit

protocol CloseDropDownDelegate{
    func SelectedValue(time:NSInteger)
    func SelectList(list:[DropDownListData])
    
//    @objc optional func SelectedList(List:DropDownListData)
}

class PopView: UIView {
    var delegate:CloseDropDownDelegate?
   // var btn:UIButton! = UIButton()
    var view:UIView! = UIView()
    var viewHeader:UIView! = UIView()
    var lblTitle:UILabel! = UILabel()
    var btnDone:UIButton! = UIButton()
    let tableView: UITableView = UITableView()
    var DropDownList = [DropDownListData]()
    var toWhere = String()
    var X = Int()
    var Y = Int()
    var W = Int()
    var H = Int()
    //let searchController = UISearchController(searchResultsController: nil)

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        //lf.addCustomView()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animationController(frame : CGRect, whereTo : String, title : String, List: [DropDownListData]) -> UIView {
        DropDownList = [DropDownListData]()
               self.toWhere = whereTo
        X = Int(frame.origin.x)
        Y = Int(frame.origin.y)
        W = Int(frame.size.width)
        H = Int(frame.size.height)
        if self.toWhere == "Macro"{
           // H = List.count * 44
            view.backgroundColor = GloabalMethods().hexStringToUIColor(hex: "EEEEEE")
             self.view.backgroundColor  = UIColor.white
        }else{
            if List.count > 5{
                H = 220
            } else{
                H = List.count * 44
            }
            view.backgroundColor = GloabalMethods().hexStringToUIColor(hex: "F7F7F7")
        }
        self.layer.borderWidth = 0

        self.frame = CGRect(x: X, y: Y, width: W, height: H)
        view.frame = CGRect(x: 0, y: 0, width: W, height: H)
        self.layer.cornerRadius = 10.0
       // self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 0
        self.layer.shadowColor = UIColor.white.cgColor;
       // self.layer.shadowOffset = CGSize(width: 1.0, height: 2.0);
        self.layer.shadowRadius = 5.0;
        self.layer.shadowOpacity = 1;
        self.clipsToBounds = true
  
        view.layer.cornerRadius = 10.0
        //view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 0
        view.layer.shadowColor = UIColor.black.cgColor;
      //  view.layer.shadowOffset = CGSize(width: 1.0, height: 2.0);
        view.layer.shadowRadius = 5.0;
        view.layer.shadowOpacity = 0.4;
        //view.clipsToBounds = true
        tableView.frame = CGRect(x: 0, y: 40, width: W, height: H-40)
        viewHeader.frame =  CGRect(x: 0, y: 0, width: W, height: 40)
        viewHeader.backgroundColor = UIColor().NavigationBar()
//        let lblTitle = UILabel(frame: CGRect(x: 3, y: 0, width: W-20, height: 40))
        if self.toWhere == "Multiple"{
            lblTitle.frame = CGRect(x: 10, y: 0, width: W-20, height: 40)
            lblTitle.textAlignment = .left
            
        }else{
            lblTitle.frame = CGRect(x: 0, y: 0, width: W, height: 40)
            lblTitle.textAlignment = .center
        }
        
        lblTitle.font =  UIFont.systemFont(ofSize: 14) //UIFont(name:"", size: 12)
        lblTitle.textColor = UIColor.white
        
        lblTitle.text = title
        viewHeader.addSubview(lblTitle)
        
        if self.toWhere == "Multiple"{
            btnDone = UIButton(frame: CGRect(x: W-70, y: 6, width: 64 , height: 32))
//                    btnDone.backgroundColor = UIColor.green
//                    btnDone.setTitle("Click Me", for: .normal)
                    btnDone.setImage(#imageLiteral(resourceName: "Done"), for: .normal)

                    btnDone.addTarget(self, action: #selector(PopView.Done), for: .touchUpInside)
                    btnDone.tag = 1
                    viewHeader.addSubview(btnDone)
        }else{
//            tableView.frame = CGRect(x: 0, y: 0, width: W, height: H)
        }
        self.view.addSubview(viewHeader)
//        tableView.frame = CGRect(x: 0, y: 0, width: W, height: H)//(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height-40)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.clear
        self.view.addSubview(tableView)
        self.DropDownList = List
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
        
        //tableView.reloadData()
        //searchController.searchResultsUpdater = self
      //  searchController.dimsBackgroundDuringPresentation = false
       // definesPresentationContext = true
//        var viewSearch : UIView = UIView()
//        viewSearch.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 44)
//        viewSearch = searchController.searchBar
//        self.addSubview(viewSearch)
      //  tableView.tableHeaderView = searchController.searchBar
        
        self.backgroundColor = UIColor.white
        self.addSubview(view)        
       
//        let btn = UIButton(frame: CGRect(x: 100, y: 120, width: 100, height: 50))
//        btn.backgroundColor = UIColor.green
//        btn.setTitle("Click Me", for: .normal)
//        btn.addTarget(self, action: #selector(PopView.timer), for: .touchUpInside)
//        btn.tag = 1
//        view.addSubview(btn)

//        let label: UILabel = UILabel()
//        label.frame = CGRect(x: 0, y: 100, width: 500, height: 100)
//        label.backgroundColor=UIColor.blue
//        label.textAlignment = NSTextAlignment.center
//        label.text = "test label"
//        view.addSubview(label)
        return self
    }
    func Done() {
        btnDone.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        //DropDownList = [DropDownListData]()
        tableView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        self.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        lblTitle.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        viewHeader.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        delegate?.SelectList(list: DropDownList)
    }
    func timer() {
        print("Hey is working")
        tableView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        self.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        delegate?.SelectedValue(time: 10)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}

extension PopView:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //NSLog("sections")
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      //  NSLog("rows")
        return self.DropDownList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // NSLog("get cell")
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        let img = UIImageView(frame: CGRect(x: W - 30, y: 12, width: 15, height: 15))
        img.image = nil
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.textAlignment = .center
        cell.textLabel!.text = DropDownList[indexPath.row].Drp_Name
        if self.toWhere == "Multiple"{
            if DropDownList[indexPath.row].IsSelect == "YES"{
                img.image = #imageLiteral(resourceName: "Ttick")
            }else{
                img.image = nil
            }
        }
        cell.addSubview(img)
        if self.toWhere == "Macro"{
            cell.textLabel!.textColor = UIColor.black
            cell.textLabel!.font = UIFont.systemFont(ofSize: 13.0)
            cell.textLabel?.textAlignment = .left
        }else{
            cell.textLabel!.textColor = UIColor.blue
        }
        
        let lblMacroTitle = UILabel(frame: CGRect(x: 0, y: 43, width: self.W, height: 1))
        lblMacroTitle.backgroundColor = GloabalMethods().hexStringToUIColor(hex: "EFEFEF")//UIColor().lineColor()
   //     lblMacroTitle.backgroundColor = GlobalMethods().hexStringToUIColor(hex: "F7F7F7")
        cell.addSubview(lblMacroTitle)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        var gre = Float()
        gre = 44.0
        return CGFloat(gre)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if self.toWhere == "Multiple"{
            if DropDownList[indexPath.row].IsSelect == "YES"{
                DropDownList[indexPath.row].IsSelect = "NO"
            }else{
                DropDownList[indexPath.row].IsSelect = "YES"
            }
            let indexPath = NSIndexPath(row: indexPath.row , section: indexPath.section)
            tableView.reloadRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.fade)
        
        }else{
            NSLog("%d",indexPath.row)
            DropDownList = [DropDownListData]()
            tableView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            self.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            lblTitle.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            viewHeader.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            delegate?.SelectedValue(time: indexPath.row)
            self.tableView.reloadData()
        }
    }
}

