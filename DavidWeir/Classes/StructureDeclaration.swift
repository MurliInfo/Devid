//
//  StructureDeclaration.swift
//  DavidWeir
//
//  Created by Hardik Davda on 4/7/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import Foundation
import UIKit

struct DashboardGrid{
    var strImage : UIImage!
    var strTitle : String
    var strSubTitle : String
}

struct AboutUsContent{
    var strContent : String
}

struct TestimonilalList{
    
    var strTitle : String
    var strContent : String
    var strDate : String
    var strAuthour : String

}
struct HomeOpenData {
    var strPropertyAddress : String
    var strDay : String
    var strBookDate : String
    var strTime : String
    var strTimeTo : String
    var strTimeFrom : String
}

struct RequestAppraisalData {
    var strTitle : String
    var ListPlaceHolder : NSArray
    
}

struct BuyerInqiryData {
    var strTitle : String
    var ListPlaceHolder : NSArray
    var strQuestion : NSArray
    var imgYes : UIImage!
    var imgNo : UIImage!
    var imgI : UIImage!
    var imgL : UIImage!
    var imgN : UIImage!
    var imgF : UIImage!
    var imgO : UIImage!

}

struct DropDownListData{
    var Drp_Id : String!
    var Drp_StateId : String!
    var Drp_Name : String!
    var IsSelect : String!
}

struct StateList{
    var Id : String!
    var StateName : String!
}

struct SuburbList{
    var Id : String!
    var StateId : String!
    var SuburbName : String
}


