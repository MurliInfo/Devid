//
//  RequestAppraisal.swift
//  DavidWeir
//
//  Created by Hardik Davda on 4/11/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit

class RequestAppraisal: UIViewController,CloseDropDownDelegate{
//    internal func SelectList(list: [DropDownListData]) {
//    
//    }

@IBOutlet var table : UITableView!
    @IBOutlet var viewPopUp : UIView!
    @IBOutlet var viewPopUpAdd : UIView!
    @IBOutlet var tableBottom: NSLayoutConstraint!
    
    var dropdown = PopView()
    var DropDownView : UIView = UIView()
    var requestApprisalForm = [RequestAppraisalData]()
    var FrameTable = CGRect()
    
var propertyListData = [DropDownListData]()
var bedroomListData = [DropDownListData]()
var bedroom = String()
var bathroom = String()
var property = String()
var SELECTED = String()
    
    // Nitesh
    var strName : String = ""
    var strEmail : String = ""
    var strPhone : String = ""
    var strLocation : String = ""

    var strBed : String = ""
    var strBath : String = ""
    
    
    // End
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewPopUp.isHidden = true
        self.navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = UIColor().NavigationBar()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
       bedroom = ""
         bathroom = ""
        property = ""
        FrameTable = table.frame
        
        let center = NotificationCenter.default
        center.addObserver(self,
                           selector: #selector(keyboardWillShow(notification:)),
                           name: .UIKeyboardWillShow,
                           object: nil)
        
        center.addObserver(self,
                           selector: #selector(keyboardWillHide(notification:) ),
                           name: .UIKeyboardWillHide,
                           object: nil)
        
        GloabalMethods().RequestAppraisalForm(completion: { (demo) in
            DispatchQueue.main.async {
                self.requestApprisalForm = demo
                self.table.reloadData()
            }
        })
        GloabalMethods().BedroomList(completion: { (demo) in
            DispatchQueue.main.async {
                self.bedroomListData = demo
            }
        })
        GloabalMethods().PropertyList(completion: { (demo) in
            DispatchQueue.main.async {
                self.propertyListData = demo
            }
        })
        // Do any additional setup after loading the view.
    }
    func AllArray()  {
       
    }
   
    // MARK: - Dropdown Delagete
    
    func SelectedValue(time:NSInteger){
        viewPopUp.isHidden = true

        if SELECTED == "Bed"{
            let ind = IndexPath(row: 0, section: 1)                            //Other
            let cell   = self.table.cellForRow(at: ind) as! CustomCell
            cell.txtBedrooms.text = self.bedroomListData[time].Drp_Name
            strBed = self.bedroomListData[time].Drp_Name
        }else
        if SELECTED == "Bath"{
            let ind = IndexPath(row: 0, section: 1)                            //Other
            let cell   = self.table.cellForRow(at: ind) as! CustomCell
            cell.txtBathroom.text = self.bedroomListData[time].Drp_Name
            strBath = self.bedroomListData[time].Drp_Name
        }else
        if SELECTED == "Property"{
            let ind = IndexPath(row: 0, section: 1)                            //Other
            let cell   = self.table.cellForRow(at: ind) as! CustomCell
            cell.txtType.text = self.propertyListData[time].Drp_Name
        }
    }
    
    internal func SelectList(list: [DropDownListData]) {
        self.propertyListData = list
        viewPopUp.isHidden = true
        var count = 0
        property = ""
        for  i in 0..<self.propertyListData.count{
            if propertyListData[i].IsSelect == "YES"{
            print(propertyListData[i].Drp_Id)
                count = count+1
                if count == 1{
                    property = property.appending(propertyListData[i].Drp_Name)
                }else{
                    property = property.appending(",").appending(propertyListData[i].Drp_Name)
                }
            }
        }
        let ind = IndexPath(row: 0, section: 1)                            //Other
        let cell   = self.table.cellForRow(at: ind) as! CustomCell
         cell.txtType.text = String(count).appending(" Type")
        print(property)
        
    }
    
//    func SelectList(list:DropDownListData){
//        
//    }
//    
    @IBAction func SelectBed(_ sender: Any) {
        viewPopUp.isHidden = false
        
        self.view.endEditing(true)
//        if !self.DropDownView.isDescendant(of: self.viewPopUpAdd){
            if self.bedroomListData.count > 0 {
                SELECTED = "Bed"
                let frame = CGRect(x: 0, y:0, width: viewPopUpAdd.frame.size.width, height: viewPopUpAdd.frame.size.height)
                dropdown.delegate = self
                dropdown.removeFromSuperview()
                DropDownView = dropdown.animationController(frame: frame,whereTo : "Demo", title : "Select Bedroom",List: self.bedroomListData)
                self.viewPopUpAdd.addSubview(DropDownView)
                dropdown.delegate = self
            }
//        }
//    else{
//            viewPopUp.isHidden = true
//            
//            self.DropDownView.removeFromSuperview()
//        }
    
//        let ind = IndexPath(row: 0, section: 1)                            //Other
//        let cell   = self.table.cellForRow(at: ind) as! CustomCell
//       cell.txtBedrooms.text = "5"
      
        
        //let indexPath = NSIndexPath(row: 0 , section: 1)
        //table.reloadRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.fade)
        
    }

    @IBAction func SelectBath(_ sender: Any) {
        viewPopUp.isHidden = false
        
        self.view.endEditing(true)
        //        if !self.DropDownView.isDescendant(of: self.viewPopUpAdd){
        if self.bedroomListData.count > 0 {
            SELECTED = "Bath"
            let frame = CGRect(x: 0, y:0, width: viewPopUpAdd.frame.size.width, height: viewPopUpAdd.frame.size.height)
            dropdown.delegate = self
            dropdown.removeFromSuperview()
            DropDownView = dropdown.animationController(frame: frame,whereTo : "Demo", title : "Select Bathroom", List: self.bedroomListData)
            self.viewPopUpAdd.addSubview(DropDownView)
            dropdown.delegate = self
        }
        //SELECTED = "Bath"
    }
    
    @IBAction func SelectProperty(_ sender: Any) {
        viewPopUp.isHidden = false

        SELECTED = "Property"
        self.view.endEditing(true)
        //        if !self.DropDownView.isDescendant(of: self.viewPopUpAdd){
        if self.propertyListData.count > 0 {
            SELECTED = "Property"
            let frame = CGRect(x: 0, y:0, width: viewPopUpAdd.frame.size.width, height: viewPopUpAdd.frame.size.height)
            dropdown.delegate = self
            dropdown.removeFromSuperview()
            DropDownView = dropdown.animationController(frame: frame,whereTo : "Multiple", title : "Select Property",List: self.propertyListData)
            self.viewPopUpAdd.addSubview(DropDownView)
            dropdown.delegate = self
        }
        
    }
    
    @IBAction func Testing(_ sender: Any) {
//        self.getValue(section: 00, index: 00)
//    }
//    
//    func getValue(section: Int ,index : Int){

//        let ind = IndexPath(row: 0, section:  0)                     // Name
//        let cell = self.table.cellForRow(at: ind) as! CustomCell
//        
//        let ind1 = IndexPath(row: 1, section: 0)                        //Email
//        let cell1 = self.table.cellForRow(at: ind1) as! CustomCell
//        
//        let ind2 = IndexPath(row: 2, section: 0)                        //Phone
//        let cell2 = self.table.cellForRow(at: ind2) as! CustomCell
//        
//        let ind3 = IndexPath(row: 3, section: 0)                        //Location
//        let cell3 = self.table.cellForRow(at: ind3) as! CustomCell
//        
//        let ind4 = IndexPath(row: 0, section: 1)                          //Property Info
//        let cell4 = self.table.cellForRow(at: ind4) as! CustomCell
//        
        let ind5 = IndexPath(row: 0, section: 2)                            //comments
        let cell5 = self.table.cellForRow(at: ind5) as! CustomCell
        
        print("Name: \(self.strName)")
        print("Email: \(self.strEmail)")
        print("Phone: \(self.strPhone)")
        print("Location: \(self.strLocation)")

        
//        let ind6 = IndexPath(row: 2, section: 0)
//        let cell6 = self.table.cellForRow(at: ind6) as! CustomCell
//        
//        let ind7 = IndexPath(row: 3, section: 0)
//        let cell7 = self.table.cellForRow(at: ind7) as! CustomCell
//        
        
        if self.strName == ""{
            self.showAlertMessage(title: "", message: "Please fill First Name")
        }else if self.strEmail == ""{
            self.showAlertMessage(title: "", message: "Please fill Proper Email Address")
        }else
        if !GloabalMethods().isValidEmail(testStr: self.strEmail){
            self.showAlertMessage(title: "", message: "Please fill Proper Email Address")
        }else
        if self.strPhone == ""{
            self.showAlertMessage(title: "", message: "Please fill Mobile Number")
        }else{
            var parameter = ("consultant_username=David Weir")
//                .appending("&consultant_email=").appending("harshil@technobrave.com")
                .appending("&consultant_email=").appending("davidweir@slpwa.com.au")
                .appending("&name=").appending(self.strName)
                .appending("&phone=").appending(self.strPhone)
                .appending("&mail=").appending(self.strEmail)
                .appending("&location=").appending(self.strLocation)
                .appending("&property_type=").appending(property)
                .appending("&no_of_bedrooms=").appending(strBed)
                .appending("&no_of_bathrooms=").appending(strBath)
            if cell5.txtComments.text == "Type your comment"{
               parameter = parameter.appending("&comments=").appending("-")
            }else{
                parameter = parameter.appending("&comments=").appending(cell5.txtComments.text!)
            }
            
            let url = "https://retptyltd.com/webservice_pts/personal_app/send_buyer_register_email.php"
            
            GloabalMethods().RequestAppraisalFormSubmit(url: url, parameter: parameter, completion: { (demo) in
                self.showAlertMessage(title: "", message: demo)
                
                self.navigationController?.popViewController(animated: true)
            })
        }
        
    }
    
    func keyboardWillShow(notification: NSNotification) {
        //            print("Keyboar will appear")
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
          self.tableBottom.constant = 0.0
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            print("Keyboar will appear\(keyboardFrame.size.height)")
            self.tableBottom.constant += keyboardFrame.size.height
//            var fram = self.table.frame
//            fram.size.height = self.FrameTable.size.height - keyboardFrame.size.height
//            self.table.frame = fram
        })
    }

    func keyboardWillHide(notification: NSNotification) {
        print("keyboarhide")
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
             self.tableBottom.constant = 0.0
//            self.table.frame = self.FrameTable
        })
    }
    
    func showAlertMessage(title : NSString,message : NSString) {
        let alert = UIAlertController(title: title as String, message: message as String, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension RequestAppraisal : UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let textFieldText: NSString = (textField.text ?? "") as NSString
        let txtAfterUpdate = textFieldText.replacingCharacters(in: range, with: string)
        
        if textField.tag == 0 {
            strName = txtAfterUpdate
        }
        else if textField.tag == 1 {
            strEmail = txtAfterUpdate
        }
        else if textField.tag == 2 {
            strPhone = txtAfterUpdate
        }
        else if textField.tag == 3 {
            strLocation = txtAfterUpdate
        }
        
        return true
    }
}

extension RequestAppraisal : UITableViewDataSource,UITableViewDelegate{
    public func numberOfSections(in tableView: UITableView) -> Int{
        
        return requestApprisalForm.count
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requestApprisalForm[section].ListPlaceHolder.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell:CustomCell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell! as! CustomCell
            let printData = requestApprisalForm[indexPath.section].ListPlaceHolder[indexPath.row]  as? String
            cell.txtForm.placeholder = printData
            cell.txtForm.tag = indexPath.row
            return cell
        }else if indexPath.section == 1{
            let cell:CustomCell = tableView.dequeueReusableCell(withIdentifier: "cell1") as UITableViewCell! as! CustomCell
            let printData = requestApprisalForm[indexPath.section].ListPlaceHolder[indexPath.row]  as? String
            let fullNameArr = printData?.components(separatedBy: ",")
            cell.txtType.placeholder = fullNameArr?[0]
            cell.txtBedrooms.placeholder = fullNameArr?[1]
            cell.txtBathroom.placeholder = fullNameArr?[2]
//            cell.txtBedrooms.text = bedroom
//            cell.txtBathroom.text = bathroom
//            cell.txtType.text = property
            return cell
        }else if indexPath.section == 2{
            let cell:CustomCell = tableView.dequeueReusableCell(withIdentifier: "cell3") as UITableViewCell! as! CustomCell
            cell.txtComments.text = "Type your comment"
            cell.txtComments.textColor = UIColor.lightGray
            return cell
        }
        else if indexPath.section == 3 {
            let cell:CustomCell = tableView.dequeueReusableCell(withIdentifier: "cell4") as UITableViewCell! as! CustomCell
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        if indexPath.section == 2{
            return  118
        }else if indexPath.section == 1{
            return  74
        }else {
            return 44
        }
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: table.frame.size.width, height: 30))
        
//        if section == 0{
        view.backgroundColor = GloabalMethods().hexStringToUIColor(hex: "EFEFEF")
            let lblTitle = UILabel(frame: CGRect(x: 16, y: 0, width: table.frame.size.width-20, height: 30))
            lblTitle.font =  UIFont.boldSystemFont(ofSize: 14) //UIFont(name:"", size: 12)
            lblTitle.textColor = UIColor.black
            lblTitle.textAlignment = .left
            lblTitle.text = self.requestApprisalForm[section].strTitle
            view.addSubview(lblTitle)
//        }
        return view
    }
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
       if section == 3{
            return 0
       }else{
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if section == (requestApprisalForm.count-1) {
            
            let view : UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.table.frame.size.width, height: 50))
            view.backgroundColor = .clear
            
            let button : UIButton = UIButton(frame: CGRect(x: view.center.x-55, y: view.center  .y-13, width: 110, height: 26))
            button.setTitle("SEND ENQUIRY", for: .normal)
            if #available(iOS 8.2, *) {
                button.titleLabel?.font = UIFont.systemFont(ofSize: 9.1, weight: UIFontWeightSemibold)
            } else {
                // Fallback on earlier versions
            }
            button.addTarget(self, action: #selector(Testing(_:)), for: .touchUpInside)
            button.backgroundColor = .orange
            button.layer.cornerRadius = 2.8
            button.clipsToBounds = true
            button.setTitleColor(.white, for: .normal)
            
            view.addSubview(button)
            
            return view
        }
        
        return nil
    }
    

    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if (requestApprisalForm.count-1) == section {
            return 0
        }else{
            return 00
        }
        
    }

    
    
}
