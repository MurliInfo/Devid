//
//  ViewController.swift
//  DavidWeir
//
//  Created by Hardik Davda on 4/7/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate{
    @IBOutlet var collectionGrid : UICollectionView!
    @IBOutlet var viewGrid : UIView!
    var GridList = [DashboardGrid]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        GloabalMethods().CreateGridArray(completion: { (demo) in
            DispatchQueue.main.async {
               self.GridList = demo
                print(demo)
                self.collectionGrid.reloadData()
            }
          })
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    @IBAction func Share(_ sender: Any){
        let text  : String = "Hi, It's Devid Weir here. I would like you to download my iCard Business app. If you have an iPhone click here: https://itunes.apple.com/us/app/david-weir/id1230378575?ls=1&mt=8.\n if you have an Android click here : https://play.google.com/store/apps/details?id=com.slp.davidweir "
        let  activityItems = [text]
        let activityController  : UIActivityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        let excludedActivitiesTypes = [UIActivityType.print,
                                       UIActivityType.assignToContact,
                                       UIActivityType.saveToCameraRoll,
                                       UIActivityType.addToReadingList,
                                       UIActivityType.postToVimeo,
                                       UIActivityType.postToFlickr]
        activityController.popoverPresentationController?.sourceView = self.view
        activityController.excludedActivityTypes = excludedActivitiesTypes
        self.present(activityController, animated: true, completion: nil)
    }

    @IBAction func webSite(_ sender: Any) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "WebDataView") as! WebDataView
        secondViewController.strUrl = "http://www.davidweir.com.au"
        secondViewController.strTitle = "Website"
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
   
    @IBAction func MakeCall(_ sender: Any) {
        let mobile = ("telprompt://0402930908")
        guard let number = URL(string: mobile) else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(number, options: [:], completionHandler: nil)
        }
    }
    @IBAction func SendEmail(_ sender: Any) {
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        composeVC.setToRecipients(["davidweir@slpwa.com.au"])
        composeVC.setSubject("")
        composeVC.setMessageBody("", isHTML: false)
        self.present(composeVC, animated: true, completion: nil)
    }
    
    func mailComposeController(controller: MFMailComposeViewController,
                               didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismiss(animated: true, completion: nil)
    }

    @IBAction func FaceBookSocial(_ sender: Any) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "WebDataView") as! WebDataView
        secondViewController.strUrl = "https://www.facebook.com/davidweirrealestate"
        secondViewController.strTitle = "Facebook"
        
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    func CurrentListings(){
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "WebDataView") as! WebDataView
        secondViewController.strUrl = "http://m.sellleaseproperty.com.au/search/consultantListings/777"
        secondViewController.strTitle = "Current Listings"
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    func RecentSales(){
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "WebDataView") as! WebDataView
        secondViewController.strUrl = "http://m.sellleaseproperty.com.au/search/consultantSales/777"
        secondViewController.strTitle = "Recent Sales"
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


extension ViewController : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.GridList.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionCell
        cell.imgIcone.image = self.GridList[indexPath.row].strImage
        cell.lblTitle.text = self.GridList[indexPath.row].strTitle
        cell.lblSubTitle.text = self.GridList[indexPath.row].strSubTitle
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "AboutUs") as! AboutUs
            self.navigationController?.pushViewController(secondViewController, animated: true)
        } else if indexPath.row == 1{
            let alert:UIAlertController=UIAlertController(title: "Options:", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
            let cameraAction = UIAlertAction(title: "Current Listings", style: UIAlertActionStyle.default){
                UIAlertAction in
                self.CurrentListings()
            }
            let gallaryAction = UIAlertAction(title: "Recent sales", style: UIAlertActionStyle.default){
                UIAlertAction in
                self.RecentSales()
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel){
                UIAlertAction in
            }
            // Add the actions
          
            alert.addAction(cameraAction)
            alert.addAction(gallaryAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }else if indexPath.row == 2{
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeOpen") as! HomeOpen
            self.navigationController?.pushViewController(secondViewController, animated: true)
        }else if indexPath.row == 3{
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "RequestAppraisal") as! RequestAppraisal
            self.navigationController?.pushViewController(secondViewController, animated: true)
        }else if indexPath.row == 4{
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "BuyerEnquiry") as! BuyerEnquiry
            self.navigationController?.pushViewController(secondViewController, animated: true)
        }else if indexPath.row == 5{
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "Testimonial") as! Testimonial
            self.navigationController?.pushViewController(secondViewController, animated: true)
        }
    }

    
//    AboutUs
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
//        let originalString: String = CCList[indexPath.row].CC_Address
//        let myString: NSString = originalString as NSString
//        let size: CGSize = myString.size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14.0)])
//        
//        var width = size.width+36
//        
//        if (size.width+36)>69{
//            width = size.width+36
//        }else{
//            width = 70
//        }
//        return CGSize(width: width , height: 36);
        
        print((viewGrid.frame.size.width/3))
        return CGSize(width: (viewGrid.frame.size.width/3)-20 , height: (viewGrid.frame.size.height/2)-20)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    
        return CGSize(width: 10, height: 10);
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
       
        if section == 0 || section == 3{
            return UIEdgeInsets(top: 10, left: 10, bottom: 5, right: 10)
        }else{
            return UIEdgeInsets(top: 10, left: 0, bottom: 5, right: 10)
        }
        //return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    }
}


