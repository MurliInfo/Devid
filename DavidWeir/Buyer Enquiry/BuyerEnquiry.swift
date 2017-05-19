//
//  BuyerEnquiry.swift
//  DavidWeir
//
//  Created by Hardik Davda on 4/11/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit

class BuyerEnquiry: UIViewController,CloseDropDownDelegate {
    
    @IBOutlet var table : UITableView!
    @IBOutlet var viewPopUp : UIView!
    @IBOutlet var viewPopUpAdd : UIView!
//    @IBOutlet var tableBotam: NSLayoutConstraint!
    @IBOutlet var viewBottom: NSLayoutConstraint!
    
    var dropdown = PopView()
    var DropDownView : UIView = UIView()
    var propertyListData = [DropDownListData]()
    var stateListData = [DropDownListData]()
    var suburbListData = [DropDownListData]()
    var suburbListDataPrint = [DropDownListData]()

    var buyerInquiryForm = [BuyerInqiryData]()
    var priceListData = [DropDownListData]()
    var bedroomListData = [DropDownListData]()

    var property = String()
    var suburb = String()
    var FrameTable = CGRect()
    var SELECTION = String()
    var Q1 = String()
    var Q2 = String()
    var Q3 = String()
    var Q4 = String()
    var Q5 = String()
    var IQY1 = UIImage()
    var IQN1 = UIImage()
    var IQY2 = UIImage()
    var IQN2 = UIImage()
    var IQY3 = UIImage()
    var IQN3 = UIImage()
    var IQY4 = UIImage()
    var IQN4 = UIImage()
    
    
    var IQI = UIImage()
    var IQL = UIImage()
    var IQN = UIImage()
    var IQF = UIImage()
    var IQO = UIImage()
    
    var strName : String = ""
    var strLastName : String = ""
    var strEmail : String = ""
    var strPhone : String = ""
    var strRequest : String = ""
    var strOther : String = ""
    
    var strState : String = ""
    var strSuburb : String = ""
    var strProperty : String = ""
    var strBedrooms : String = ""
    var strBathroom : String = ""
    var strGarage : String = ""
    
    var strPriceMin : String = ""
    var strPriceMax : String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewPopUp.isHidden = true
        self.navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = UIColor().NavigationBar()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        
        self.table.estimatedRowHeight = 88
        self.table.rowHeight = UITableViewAutomaticDimension
        
        self.table.setNeedsLayout()
        self.table.layoutIfNeeded()
        
        self.table.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        Q1 = "YES"
        Q2 = "YES"
        Q3 = "YES"
        Q4 = "YES"
        IQY1 = #imageLiteral(resourceName: "Feedbackgreen_btn")
        IQN1 = #imageLiteral(resourceName: "Feedbackplan_btn")
        IQY2 = #imageLiteral(resourceName: "Feedbackgreen_btn")
        IQN2 = #imageLiteral(resourceName: "Feedbackplan_btn")
        IQY3 = #imageLiteral(resourceName: "Feedbackgreen_btn")
        IQN3 = #imageLiteral(resourceName: "Feedbackplan_btn")
        IQY4 = #imageLiteral(resourceName: "Feedbackgreen_btn")
        IQN4 = #imageLiteral(resourceName: "Feedbackplan_btn")
        
        IQI = #imageLiteral(resourceName: "Feedbackplan_btn")
        IQL = #imageLiteral(resourceName: "Feedbackplan_btn")
        IQN = #imageLiteral(resourceName: "Feedbackplan_btn")
        IQF = #imageLiteral(resourceName: "Feedbackplan_btn")
        IQO = #imageLiteral(resourceName: "Feedbackgreen_btn")
        
        Q5 = "Other"
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
        
        GloabalMethods().BuyerInquiryForm(completion: { (demo) in
            DispatchQueue.main.async {
                self.buyerInquiryForm = demo
                self.table.reloadData()
            }
        })
         GloabalMethods().StateListAll(completion: { (demo) in
            DispatchQueue.main.async {
                self.stateListData = demo
            }
         })
        GloabalMethods().SuburbListAll(completion: { (demo) in
            DispatchQueue.main.async {
                self.suburbListData = demo
            }
        })
        
        GloabalMethods().PriceList(completion: { (demo) in
            DispatchQueue.main.async {
                self.priceListData = demo
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
    }
    
     // MARK: - Proprty Info: Selection section

    @IBAction func PropertyInfoSelectDropDown(_ sender: Any) {
        self.view.endEditing(true)

        let btn = sender
         viewPopUp.isHidden = false
        if (btn as AnyObject).tag == 1{
            SELECTION = "State"
            self.view.endEditing(true)
            if self.bedroomListData.count > 0 {
                SELECTION = "State"
                let frame = CGRect(x: 0, y:0, width: viewPopUpAdd.frame.size.width, height: viewPopUpAdd.frame.size.height)
                dropdown.delegate = self
                dropdown.removeFromSuperview()
                DropDownView = dropdown.animationController(frame: frame,whereTo : "Demo", title : "Select State",List: self.stateListData)
                self.viewPopUpAdd.addSubview(DropDownView)
                dropdown.delegate = self
            }
        }
        //Multiple
        if (btn as AnyObject).tag == 2{
            
            self.view.endEditing(true)
            if self.strState == ""{
                viewPopUp.isHidden = true
                self.showAlertMessage(title: "", message: "Please Select first State")
            }else{
                
                if self.suburbListDataPrint.count > 0 {
                    viewPopUp.isHidden = false
                    SELECTION = "Suburb"
                    let frame = CGRect(x: 0, y:0, width: viewPopUpAdd.frame.size.width, height: viewPopUpAdd.frame.size.height)
                    dropdown.delegate = self
                    dropdown.removeFromSuperview()
                    DropDownView = dropdown.animationController(frame: frame,whereTo : "Multiple", title : "Select Suburb",List: self.suburbListDataPrint)
                    self.viewPopUpAdd.addSubview(DropDownView)
                    dropdown.delegate = self
                }
            }
        }
        
        if (btn as AnyObject).tag == 3{
            viewPopUp.isHidden = false
           self.view.endEditing(true)
            if self.bedroomListData.count > 0 {
                SELECTION = "PropertyType"
                let frame = CGRect(x: 0, y:0, width: viewPopUpAdd.frame.size.width, height: viewPopUpAdd.frame.size.height)
                dropdown.delegate = self
                dropdown.removeFromSuperview()
                DropDownView = dropdown.animationController(frame: frame,whereTo : "Multiple", title : "Select Property Type",List: self.propertyListData)
                self.viewPopUpAdd.addSubview(DropDownView)
                dropdown.delegate = self
            }
        }
        
        if (btn as AnyObject).tag == 4{
            viewPopUp.isHidden = false
            
            self.view.endEditing(true)
            if self.bedroomListData.count > 0 {
                SELECTION = "Bedroom"
                let frame = CGRect(x: 0, y:0, width: viewPopUpAdd.frame.size.width, height: viewPopUpAdd.frame.size.height)
                dropdown.delegate = self
                dropdown.removeFromSuperview()
                DropDownView = dropdown.animationController(frame: frame,whereTo : "Demo", title : "Select Bedroom",List: self.bedroomListData)
                self.viewPopUpAdd.addSubview(DropDownView)
                dropdown.delegate = self
            }
        }
        
        if (btn as AnyObject).tag == 5{
            self.view.endEditing(true)
            if self.bedroomListData.count > 0 {
                SELECTION = "Bathroom"
                let frame = CGRect(x: 0, y:0, width: viewPopUpAdd.frame.size.width, height: viewPopUpAdd.frame.size.height)
                dropdown.delegate = self
                dropdown.removeFromSuperview()
                DropDownView = dropdown.animationController(frame: frame,whereTo : "Demo", title : "Select Bathroom",List: self.bedroomListData)
                self.viewPopUpAdd.addSubview(DropDownView)
                dropdown.delegate = self
            }
        }
        
        if (btn as AnyObject).tag == 6{
            self.view.endEditing(true)
            if self.bedroomListData.count > 0 {
                SELECTION = "Garage"
                let frame = CGRect(x: 0, y:0, width: viewPopUpAdd.frame.size.width, height: viewPopUpAdd.frame.size.height)
                dropdown.delegate = self
                dropdown.removeFromSuperview()
                DropDownView = dropdown.animationController(frame: frame,whereTo : "Demo", title : "Select Garage",List: self.bedroomListData)
                self.viewPopUpAdd.addSubview(DropDownView)
                dropdown.delegate = self
            }
        }
    }

    // MARK: - ProprPrice Range Selection section
    
    @IBAction func PriceRangeSelectDropDown(_ sender: Any) {
        self.view.endEditing(true)

        viewPopUp.isHidden = false
        let btn = sender
        if (btn as AnyObject).tag == 2{
            SELECTION = "MinPrice"
            self.view.endEditing(true)
            if self.priceListData.count > 0 {
                SELECTION = "MinPrice"
                let frame = CGRect(x: 0, y:0, width: viewPopUpAdd.frame.size.width, height: viewPopUpAdd.frame.size.height)
                dropdown.delegate = self
                dropdown.removeFromSuperview()
                DropDownView = dropdown.animationController(frame: frame,whereTo : "Demo", title : "Select MinPrice",List: self.priceListData)
                self.viewPopUpAdd.addSubview(DropDownView)
                dropdown.delegate = self
            }
            
        }else
        if (btn as AnyObject).tag == 1{
            SELECTION = "MaxPrice"
                print(" MaxPrice\((btn as AnyObject).tag)")
            self.view.endEditing(true)
            //        if !self.DropDownView.isDescendant(of: self.viewPopUpAdd){
            if self.priceListData.count > 0 {
                SELECTION = "MaxPrice"
                let frame = CGRect(x: 0, y:0, width: viewPopUpAdd.frame.size.width, height: viewPopUpAdd.frame.size.height)
                dropdown.delegate = self
                dropdown.removeFromSuperview()
                DropDownView = dropdown.animationController(frame: frame,whereTo : "Demo", title : "Select MaxPrice",List: self.priceListData)
                self.viewPopUpAdd.addSubview(DropDownView)
                dropdown.delegate = self
            }
        }
    }

    // MARK: - filter suburb using state

    func FilterSuburb()  {
        self.suburbListDataPrint = [DropDownListData]()
        for  i in 0..<self.suburbListData.count{
            if suburbListData[i].Drp_StateId == strState{
                let cmd = suburbListData[i]
                self.suburbListDataPrint.append(cmd)
            }
        }
    }
    
    // MARK: - Dropdown Delagete
  
    func SelectedValue(time:NSInteger){
        viewPopUp.isHidden = true
        
        if SELECTION == "State"{
            let ind = IndexPath(row: 0, section: 1)                            //Other
            let cell   = self.table.cellForRow(at: ind) as! CustomCell
            cell.txtState.text = self.stateListData[time].Drp_Name
            strState = self.stateListData[time].Drp_Name
            self.FilterSuburb()
        }else
        if SELECTION == "Suburb"{
            strSuburb = ""
        }else
        if SELECTION == "PropertyType"{
            strProperty = ""
        }else
        if SELECTION == "Bedroom"{
            let ind = IndexPath(row: 0, section: 1)                            //Other
            let cell   = self.table.cellForRow(at: ind) as! CustomCell
            cell.txtBedrooms.text = self.bedroomListData[time].Drp_Name
            strBedrooms = self.bedroomListData[time].Drp_Name
        }else
        if SELECTION == "Bathroom"{
            let ind = IndexPath(row: 0, section: 1)                            //Other
            let cell   = self.table.cellForRow(at: ind) as! CustomCell
            cell.txtBathroom.text = self.bedroomListData[time].Drp_Name
            strBathroom = self.bedroomListData[time].Drp_Name
        }else
        if SELECTION == "Garage"{
            let ind = IndexPath(row: 0, section: 1)                            //Other
            let cell   = self.table.cellForRow(at: ind) as! CustomCell
            cell.txtGarage.text = self.bedroomListData[time].Drp_Name
            strGarage = self.bedroomListData[time].Drp_Name
        }else
        if SELECTION == "MinPrice"{
            let ind = IndexPath(row: 0, section: 2)                            //Other
            let cell   = self.table.cellForRow(at: ind) as! CustomCell
            cell.txtMinPrice.text = self.priceListData[time].Drp_Name
            strPriceMin = self.priceListData[time].Drp_Name
        }else
        if SELECTION == "MaxPrice"{
            let ind = IndexPath(row: 0, section: 2)                            //Other
            let cell   = self.table.cellForRow(at: ind) as! CustomCell
            cell.txtMaxPrice.text = self.priceListData[time].Drp_Name
            strPriceMax = self.priceListData[time].Drp_Name
        }
 
    }

    internal func SelectList(list: [DropDownListData]) {
        viewPopUp.isHidden = true
        var count = 0
        if SELECTION == "Suburb"{
            suburbListDataPrint = list
            strSuburb = ""
            for  i in 0..<self.suburbListDataPrint.count{
                if suburbListDataPrint[i].IsSelect == "YES"{
                    count = count+1
                    if count == 1{
                        strSuburb = strSuburb.appending(suburbListDataPrint[i].Drp_Name)
                        
                    }else{
                        strSuburb = strSuburb.appending(",").appending(suburbListDataPrint[i].Drp_Name)
                    }
                }
            }
            let ind = IndexPath(row: 0, section: 1)                            //Other
            let cell   = self.table.cellForRow(at: ind) as! CustomCell
            cell.txtSuburb.text = String(count).appending(" Suburb")
        }else
        if SELECTION == "PropertyType"{
            strProperty = ""
            property = ""
            self.propertyListData = list
            for  i in 0..<self.propertyListData.count{
                if propertyListData[i].IsSelect == "YES"{
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
    }

    // MARK: - Question selection section 1 to 4

    @IBAction func Question1(_ sender: Any) {
        self.view.endEditing(true)

        let btn = sender
        if (btn as AnyObject).tag == 1{
            Q1 = "YES"
            IQY1 = #imageLiteral(resourceName: "Feedbackgreen_btn")
            IQN1 = #imageLiteral(resourceName: "Feedbackplan_btn")
            let indexPath = NSIndexPath(row: 0 , section: 3)
            table.reloadRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.fade)
        }else
        if (btn as AnyObject).tag == 2{
            Q2 = "YES"
            IQY2 = #imageLiteral(resourceName: "Feedbackgreen_btn")
            IQN2 = #imageLiteral(resourceName: "Feedbackplan_btn")
            let indexPath = NSIndexPath(row: 1 , section: 3)
            table.reloadRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.fade)
        }else
        if (btn as AnyObject).tag == 3{
            Q3 = "YES"
            IQY3 = #imageLiteral(resourceName: "Feedbackgreen_btn")
            IQN3 = #imageLiteral(resourceName: "Feedbackplan_btn")
            let indexPath = NSIndexPath(row: 2 , section: 3)
            table.reloadRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.fade)
        }else
        if (btn as AnyObject).tag == 4 {
            Q4 = "YES"
            IQY4 = #imageLiteral(resourceName: "Feedbackgreen_btn")
            IQN4 = #imageLiteral(resourceName: "Feedbackplan_btn")
            let indexPath = NSIndexPath(row: 3 , section: 3)
            table.reloadRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.fade)
        }else
        if (btn as AnyObject).tag == 11{
            Q1 = "NO"
            IQY1 = #imageLiteral(resourceName: "Feedbackplan_btn")
            IQN1 = #imageLiteral(resourceName: "Feedbackgreen_btn")
            let indexPath = NSIndexPath(row: 0 , section: 3)
            table.reloadRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.fade)
        }else
        if (btn as AnyObject).tag == 12{
            Q2 = "NO"
            IQY2 = #imageLiteral(resourceName: "Feedbackplan_btn")
            IQN2 = #imageLiteral(resourceName: "Feedbackgreen_btn")
            let indexPath = NSIndexPath(row: 1 , section: 3)
            table.reloadRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.fade)
        }else
        if (btn as AnyObject).tag == 13{
            Q3 = "NO"
            IQY3 = #imageLiteral(resourceName: "Feedbackplan_btn")
            IQN3 = #imageLiteral(resourceName: "Feedbackgreen_btn")
            let indexPath = NSIndexPath(row: 2 , section: 3)
            table.reloadRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.fade)
        }else
        if (btn as AnyObject).tag == 14 {
            Q4 = "NO"
            IQY4 = #imageLiteral(resourceName: "Feedbackplan_btn")
            IQN4 = #imageLiteral(resourceName: "Feedbackgreen_btn")
            let indexPath = NSIndexPath(row: 3 , section: 3)
            table.reloadRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.fade)
        }
    }

    // MARK: - Question selection section 5

    @IBAction func Question5(_ sender: Any) {
        self.view.endEditing(true)

        let btn = sender
        print(" Question5\((btn as AnyObject).tag)")
        IQI = #imageLiteral(resourceName: "Feedbackplan_btn")
        IQL = #imageLiteral(resourceName: "Feedbackplan_btn")
        IQN = #imageLiteral(resourceName: "Feedbackplan_btn")
        IQF = #imageLiteral(resourceName: "Feedbackplan_btn")
        IQO = #imageLiteral(resourceName: "Feedbackplan_btn")
        
        if (btn as AnyObject).tag == 1{
            IQI = #imageLiteral(resourceName: "Feedbackgreen_btn")
            Q5 = "Internet"
        }else
        if (btn as AnyObject).tag == 2{
            IQL = #imageLiteral(resourceName: "Feedbackgreen_btn")
        Q5 = "Latterbox Flyer"
        }else
        if (btn as AnyObject).tag == 3{
            IQN = #imageLiteral(resourceName: "Feedbackgreen_btn")
            Q5 = "Newspaper"
        }else
        if (btn as AnyObject).tag == 4{
            IQF = #imageLiteral(resourceName: "Feedbackgreen_btn")
            Q5 = "Friend or Relative"
        }else
        if (btn as AnyObject).tag == 5{
            IQO = #imageLiteral(resourceName: "Feedbackgreen_btn")
            Q5 = "Other"
        }
        let indexPath = NSIndexPath(row: 0 , section: 4)
        table.reloadRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.fade)
    }
    @IBAction func SubmitDataDemo(_ sender: Any){
    }

    // MARK: - Submit Data to web

    @IBAction func SubmitData(_ sender: Any) {
        self.view.endEditing(true)

        if strName == ""{
            self.showAlertMessage(title: "", message: "Please fill First Name")
        }else
        if strLastName == ""{
            self.showAlertMessage(title: "", message: "Please fill Last Name")
        }else
        if strPhone == ""{
            self.showAlertMessage(title: "", message: "Please fill Mobile Number")
        }else
        if strEmail != "" && !GloabalMethods().isValidEmail(testStr: self.strEmail){
                self.showAlertMessage(title: "", message: "Please fill Proper Email Address")
        }else if Q5 == "Other" && strOther == ""{
            self.showAlertMessage(title: "", message: "Please write somthing about where you heard about this property.")
        }else{
            var parameter = ("consultant_username=David Weir")
//                .appending("&consultant_email=").appending("harshil@technobrave.com")
                .appending("&consultant_email=").appending("davidweir@slpwa.com.au")
                .appending("&bfb_firstname=").appending(self.strName)
                 .appending("&bfb_lastname=").appending(self.strLastName)
                .appending("&bfb_mobile=").appending(self.strPhone)
                if strEmail == ""{
                    parameter = parameter.appending("&bfb_email=").appending("-") //  if not than  pass -
                }else{
                    parameter = parameter.appending("&bfb_email=").appending(strEmail)
                }
                    parameter = parameter.appending("&bfb_special_request=").appending(strRequest)
                        .appending("&bfb_state=").appending(strState)
                        .appending("&bfb_suburb=").appending(strSuburb)
                        .appending("&bfb_property_type=").appending(property)
                        .appending("&bfb_bedrooms=").appending(strBedrooms)
                        .appending("&bfb_bathroom=").appending(strBathroom)
                        .appending("&bfb_garage=").appending(strGarage)
                        .appending("&bfb_price_range_min=").appending(strPriceMin)
                        .appending("&bfb_price_range_max=").appending(strPriceMax)
                        .appending("&bfb_question_purchase=").appending(Q1)       //q1
                        .appending("&bfb_question_market=").appending(Q2)         //q2
                        .appending("&bfb_question_intrested=").appending(Q3)      //q3
                        .appending("&bfb_question_quote=").appending(Q4)          // q4
                        .appending("&bfb_question_here_property=").appending(Q5)  // q5
                if Q5 == "Other"{
                    parameter = parameter.appending("&bfb_other=").appending(strOther)  //if not than -
                }else{
                    parameter = parameter.appending("&bfb_other=").appending("-")
                }
                print(parameter)
            let url = "https://retptyltd.com/webservice_pts/personal_app/send_buyer_add_email.php"
            
            GloabalMethods().RequestAppraisalFormSubmit(url: url, parameter: parameter, completion: { (demo) in
                self.showAlertMessage(title: "Add Buyer", message: demo)
                
                self.navigationController?.popViewController(animated: true)
            })
        }
    }
    
    func keyboardWillShow(notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
          self.viewBottom.constant = 0.0
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.viewBottom.constant += keyboardFrame.size.height
        })
    }
    
    func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.viewBottom.constant = 0.0
        })
    }

    func showAlertMessage(title : NSString,message : NSString) {
        let alert = UIAlertController(title: title as String, message: message as String, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension BuyerEnquiry : UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let textFieldText: NSString = (textField.text ?? "") as NSString
        let txtAfterUpdate = textFieldText.replacingCharacters(in: range, with: string)
        
        if textField.tag == 0 {
            strName = txtAfterUpdate
        }
        else if textField.tag == 1 {
            strLastName = txtAfterUpdate
        }
        else if textField.tag == 2 {
            strPhone = txtAfterUpdate
        }
        else if textField.tag == 3 {
            strEmail = txtAfterUpdate
        }
        else if textField.tag == 4 {
            strRequest = txtAfterUpdate
        }
        else if textField.tag == 41 {
            strOther = txtAfterUpdate
        }
        return true
    }
}

extension BuyerEnquiry : UITableViewDataSource,UITableViewDelegate{
    
    public func numberOfSections(in tableView: UITableView) -> Int{
        print(buyerInquiryForm.count)
        return buyerInquiryForm.count
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return buyerInquiryForm[section].ListPlaceHolder.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let printData = buyerInquiryForm[indexPath.section]
        
         if indexPath.section == 0{
            let cell:CustomCell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell! as! CustomCell
            cell.txtForm.placeholder =  printData.ListPlaceHolder[indexPath.row] as? String
            cell.txtForm.tag = indexPath.row
            return cell
        }else
        if indexPath.section == 1{
            let cell:CustomCell = tableView.dequeueReusableCell(withIdentifier: "cell1") as UITableViewCell! as! CustomCell
            return cell
        }else
        if indexPath.section == 2{
            let cell:CustomCell = tableView.dequeueReusableCell(withIdentifier: "cell2") as UITableViewCell! as! CustomCell
            return cell
        }else
        if indexPath.section == 3{
            let cell:CustomCell = tableView.dequeueReusableCell(withIdentifier: "cell3") as UITableViewCell! as! CustomCell
            cell.lblQuestions.text = printData.strQuestion[indexPath.row] as? String
                cell.btnYes.tag = indexPath.row + 1
                cell.btnNo.tag = indexPath.row + 11
            if indexPath.row == 0{
                cell.imgYes.image = IQY1
                cell.imgNo.image = IQN1
            }
            if indexPath.row == 1{
                cell.imgYes.image = IQY2
                cell.imgNo.image = IQN2
            }
            if indexPath.row == 2{
                cell.imgYes.image = IQY3
                cell.imgNo.image = IQN3
            }
            if indexPath.row == 3{
                cell.imgYes.image = IQY4
                cell.imgNo.image = IQN4
            }
            
            return cell
        }else
        if indexPath.section == 4{
            let cell:CustomCell = tableView.dequeueReusableCell(withIdentifier: "cell4") as UITableViewCell! as! CustomCell
              cell.lblQuestions.text = printData.strQuestion[indexPath.row] as? String
                cell.imgI.image = IQI
                cell.imgL.image = IQL
                cell.imgN.image = IQN
                cell.imgF.image = IQF
                cell.imgO.image = IQO
             if Q5 == "Other"{
                cell.txtOther.isHidden = false
                cell.imgOther.isHidden = false
             }else{
                cell.txtOther.isHidden = true
                cell.imgOther.isHidden = true
            }
            return cell
        }else{
            let cell:CustomCell = tableView.dequeueReusableCell(withIdentifier: "cell5") as UITableViewCell! as! CustomCell
            return cell
        }
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        if indexPath.section == 0{
            return  50
        }else if indexPath.section == 1{
            return 90
        }else if indexPath.section == 2{
            return 50
        }else if indexPath.section == 3{
            return 86
        }else if indexPath.section == 4{
            return 164
        }else{
            return 50
        }
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: table.frame.size.width, height: 44))
        
        view.backgroundColor = GloabalMethods().hexStringToUIColor(hex: "EFEFEF")
        let lblTitle = UILabel(frame: CGRect(x: 16, y: 0, width: table.frame.size.width-20, height: 44))
        lblTitle.font =  UIFont.boldSystemFont(ofSize: 14) //UIFont(name:"", size: 12)
        lblTitle.textColor = UIColor.black
        lblTitle.textAlignment = .left
        lblTitle.text = self.buyerInquiryForm[section].strTitle
        view.addSubview(lblTitle)
        return view
    }
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        if section == 3 || section == 4 || section == 5{
            return 0
        }else{
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if section == (buyerInquiryForm.count-1) {
            
            let view : UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.table.frame.size.width, height: 50))
            view.backgroundColor = .clear
            
            let button : UIButton = UIButton(frame: CGRect(x: view.center.x-55, y: view.center  .y-13, width: 110, height: 26))
            button.setTitle("SEND ENQUIRY", for: .normal)
            if #available(iOS 8.2, *) {
                button.titleLabel?.font = UIFont.systemFont(ofSize: 9.1, weight: UIFontWeightSemibold)
            } else {

            }
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
        
        if (buyerInquiryForm.count-1) == section {
            return 0
        }else{
            return 00
        }
    }
}
