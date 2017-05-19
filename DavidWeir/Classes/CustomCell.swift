//
//  CustomCell.swift
//  DavidWeir
//
//  Created by Hardik Davda on 4/10/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell ,UITextFieldDelegate,UITextViewDelegate {
    @IBOutlet var lblContant: UILabel!

    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblDescription: UILabel!
    @IBOutlet var lblAuthour: UILabel!
    
    @IBOutlet var lblAddress: UILabel!
    @IBOutlet var lblDay: UILabel!
    @IBOutlet var lblTime: UILabel!
    @IBOutlet var lblQuestions: UILabel!
    
    @IBOutlet var txtForm: UITextField!
    @IBOutlet var txtComments: UITextView!
    @IBOutlet var txtType: UITextField!
    @IBOutlet var txtBedrooms: UITextField!
    @IBOutlet var txtBathroom: UITextField!
    @IBOutlet var txtState: UITextField!
    @IBOutlet var txtSuburb: UITextField!
    @IBOutlet var txtGarage: UITextField!
    @IBOutlet var txtMinPrice: UITextField!
    @IBOutlet var txtMaxPrice: UITextField!
    @IBOutlet var txtOther: UITextField!
    
    @IBOutlet var imgYes: UIImageView!
    @IBOutlet var imgNo: UIImageView!
    @IBOutlet var imgI: UIImageView!
    @IBOutlet var imgL: UIImageView!
    @IBOutlet var imgN: UIImageView!
    @IBOutlet var imgF: UIImageView!
    @IBOutlet var imgO: UIImageView!
    @IBOutlet var imgOther: UIImageView!
    
    @IBOutlet var btnYes: UIButton!
    @IBOutlet var btnNo: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //        self.txtComments.delegate = self
//        
//        self.txtComments.text = "Type your comments"
//        self.txtComments.textColor = UIColor.lightGray
//        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
   
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if  txtComments.textColor == UIColor.lightGray {
            
            txtComments.text = nil
            txtComments.textColor = UIColor.black
        }
        //lbl.backgroundColor = .orange
        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == ""{
            self.txtComments.text = "Type your comments"
            self.txtComments.textColor = UIColor.lightGray
        }
//        lbl.backgroundColor = .groupTableViewBackground
        
    }
    

}
