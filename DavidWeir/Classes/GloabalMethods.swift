//
//  GloabalMethods.swift
//  DavidWeir
//
//  Created by Hardik Davda on 4/7/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit

class GloabalMethods: NSObject {
    
var Grid = [DashboardGrid]()
var About = [AboutUsContent]()
var TestimonialList = [TestimonilalList]()
var HomeOpenList = [HomeOpenData]()
var requestApprisalForm = [RequestAppraisalData]()
var buyerInquiryForm = [BuyerInqiryData]()
var propertyListData = [DropDownListData]()
var bedroomListData = [DropDownListData]()
var stateListData = [DropDownListData]()
    var suburbListData = [DropDownListData]()
var priceListData = [DropDownListData]()
    func CreateGrid(with image : UIImage ,Title : String , SubTitle : String){
        
    }
    
    func CreateGridArray(completion:(([DashboardGrid])->())?) {
        
        let cmd1 = DashboardGrid(strImage: #imageLiteral(resourceName: "Icon_About"), strTitle: "About", strSubTitle: "David Weir")
        Grid.append(cmd1)
        
        let cmd2 = DashboardGrid(strImage: #imageLiteral(resourceName: "Icon_MyProperty"), strTitle: "View", strSubTitle: "My Properties")
        Grid.append(cmd2)
        
        let cmd3 = DashboardGrid(strImage: #imageLiteral(resourceName: "Icon_MyHomeOpen"), strTitle: "My", strSubTitle: "Home Open")
        Grid.append(cmd3)
        
        let cmd4 = DashboardGrid(strImage: #imageLiteral(resourceName: "Icon_ApprisalRequest"), strTitle: "Request", strSubTitle: "Appraisal")
        Grid.append(cmd4)
        
        let cmd5 = DashboardGrid(strImage: #imageLiteral(resourceName: "Buyer_1"), strTitle: "Enquiry", strSubTitle: "Buyer")
        Grid.append(cmd5)
        
        let cmd6 = DashboardGrid(strImage: #imageLiteral(resourceName: "Icon_Testimonial"), strTitle: "Client", strSubTitle: "Testimonials")
        Grid.append(cmd6)
        
        DispatchQueue.main.async {
            completion?(self.Grid)
        }
        
    }
    
    func AboutUsText(completion:(([AboutUsContent])->())?) {

        let cmd = AboutUsContent(strContent : "")
        About.append(cmd)
        
        let cmd1 = AboutUsContent(strContent : "Real estate expert, author, public speaker and trainer David Weir and his team aim to exceed your expectations. Having personally sold over 1,700 properties since 2001 in Perth's northern suburbs, David was born and bred in Nollamara; the place he still calls home.\n\nNo-one knows Nollamara properties like he does.\nDavid's commitment, passion and high energy is inspiring and has seen David receive multiple awards including REIWA Master Salesperson and resulted in him being in the REIWA's top ten salesperson by number of sales.\n\nBeing an active member of the community, David's professional commitment to his clients to achieve only the very best results for them means he makes a personal guarantee to you that others won't.\n\n “If at any stage during the marketing of your property my team does not deliver on our commitments as agreed to, we will cancel the listing agreement with 24 hours notice.“\n\nA service guarantee he puts in writing and is signed by the licensee, all designed to give you peace of mind that your property really is in the hands of the best of the best.\n\nIn order to provide you with a six-star experience David has invested heavily in himself and his team.\n\nCoached by the best in the world in advanced negotiation skills David's proven track record shows he knows how to negotiate hard for every dollar for his clients and your house will NOT be undersold.\n\nWith tailored innovative and fresh marketing to ensure your house receives maximum exposure, access to hundreds of active and qualified buyers, his personal guarantee of stress free service and unmatched knowledge of the local market... when you list with David Weir and his team you know you will get only the very best result.")
        About.append(cmd1)
        
        
        DispatchQueue.main.async {
            completion?(self.About)
        }
    }
    
     func HomeOpenList(completion:(([HomeOpenData])->())?) {
//        let url = NSURL(string: "https://retptyltd.com/webservice_ios/pts_home_list.php" as String)

        let url = NSURL(string: "https://retptyltd.com/webservice_pts/pts_home_list.php" as String)
        var request = URLRequest(url: url as! URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var parameter : NSString = NSString()
        parameter = "email="
        parameter = parameter.appending("davidweir@slpwa.com.au") as NSString
//        parameter = parameter.appending("kamlesh@technobrave.com") as NSString
        request.httpBody = parameter.data(using: String.Encoding.utf8.rawValue)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
                // let responseObject = try JSONSerialization.jsonObject(with: data)
                //print(responseObject)
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    let status = parsedData["status"] as! Bool
                    if(!status){
                        let field = parsedData["msg"] as! String
                       var Error : String!
                        Error = (field as NSString) as String!
                        print(Error)
                    }else{
                        let field = parsedData["info"] as! [[String:Any]]
                        print(field)
                         for blog in field {
                        var cmd = HomeOpenData(strPropertyAddress: blog["property_address"] as! String,
                                               strDay: blog["day"] as! String,
                                               strBookDate: blog["booking_date"] as! String,
                                               strTime: "",
                                               strTimeTo : blog["to_time"] as! String,
                                               strTimeFrom : blog["from_time"] as! String   )
                                                cmd.strTime = cmd.strTimeFrom.appending(" To ").appending(cmd.strTimeTo)
                                              self.HomeOpenList.append(cmd)
                        }
                    }
                }
                DispatchQueue.main.async {
                    completion?(self.HomeOpenList)
                }
                
            }
        }
        task.resume()

//        DispatchQueue.main.async {
//            completion?(self.HomeOpenList)
//        }
    }
    
    func RequestAppraisalForm(completion:(([RequestAppraisalData])->())?) {
        let textplaceholder : NSArray = ["Enter Name","Enter Email","Enter Phone","Enter Location"]
        
        let cmd = RequestAppraisalData(strTitle: "Personal Info:", ListPlaceHolder: textplaceholder)
        self.requestApprisalForm.append(cmd)
      
        let textplaceholder1 : NSArray = ["Property,Bedrooms,Bathrooms"]
        
        let cmd1 = RequestAppraisalData(strTitle: "Property Info:", ListPlaceHolder: textplaceholder1)
        self.requestApprisalForm.append(cmd1)
        
        let textplaceholder2 : NSArray = ["Type your comments"]
        let cmd2 = RequestAppraisalData(strTitle: "Comments:", ListPlaceHolder: textplaceholder2)
        self.requestApprisalForm.append(cmd2)
        
        let textplaceholder3 : NSArray = ["Type your comments"]
        let cmd3 = RequestAppraisalData(strTitle: "", ListPlaceHolder: textplaceholder3)
        self.requestApprisalForm.append(cmd3)
//        Comments
//        Type your comments
        DispatchQueue.main.async {
            completion?(self.requestApprisalForm)
        }
    }
    
    
    func BuyerInquiryForm(completion:(([BuyerInqiryData])->())?) {
        //Cell 1
        let textplaceholder : NSArray = ["Please Enter your first Name *","Please Enter your Last Name *","Please enter your Mobile Number *","Please Enter Your Email","Special Request"]
         let Question1 : NSArray = [""]
        let img  = UIImage()
        let cmd = BuyerInqiryData(strTitle: "Personal Info:", ListPlaceHolder: textplaceholder, strQuestion: Question1,imgYes: img,imgNo : img,imgI : img,imgL : img, imgN : img, imgF : img,imgO : img)
        
        //Cell 2
        let textplaceholder2 : NSArray = ["State,Suburb,Property Type,Bedroom,Bathroom,Garage"]
        let cmd2 = BuyerInqiryData(strTitle: "Property Info:", ListPlaceHolder: textplaceholder2, strQuestion: Question1,imgYes: img,imgNo : img,imgI : img,imgL : img, imgN : img, imgF : img,imgO : img)
        
        //Cell 3
        let textplaceholder3 : NSArray = ["Min - Price,Max - Price"]
        let cmd3 = BuyerInqiryData(strTitle: "Price Range:", ListPlaceHolder: textplaceholder3, strQuestion: Question1,imgYes: img,imgNo : img,imgI : img,imgL : img, imgN : img, imgF : img,imgO : img)
        
        
        //Cell 4
        let textplaceholder4 : NSArray = ["Will you be selling a property to make this purchase?","Would you like to know what your property could be worth in today's market?","Would you be interested in gaining a low interest loan or reducing your existing mortgage interest rate?","Would you like to recive a quote on our property management services?"]
        let Question4 : NSArray = ["Will you be selling a property to make this purchase?","Would you like to know what your property could be worth in today's market?","Would you be interested in gaining a low interest loan or reducing your existing mortgage interest rate?","Would you like to receive a quote on our property management services?"]

        let cmd4 = BuyerInqiryData(strTitle: "Property Info:", ListPlaceHolder: textplaceholder4, strQuestion: Question4,imgYes: #imageLiteral(resourceName: "Feedbackgreen_btn"),imgNo : #imageLiteral(resourceName: "Feedbackplan_btn"),imgI : img,imgL : img, imgN : img, imgF : img,imgO : img)
        
        let textplaceholder5 : NSArray = [""]
        let Question5 : NSArray = ["Where did you hear about this property?"]
        
        let cmd5 = BuyerInqiryData(strTitle: "", ListPlaceHolder: textplaceholder5, strQuestion: Question5,imgYes: img,imgNo : img,imgI : #imageLiteral(resourceName: "Feedbackplan_btn"),imgL : #imageLiteral(resourceName: "Feedbackplan_btn"), imgN : #imageLiteral(resourceName: "Feedbackplan_btn"), imgF : #imageLiteral(resourceName: "Feedbackplan_btn"),imgO : #imageLiteral(resourceName: "Feedbackgreen_btn"))
        
        let textplaceholder6 : NSArray = [""]
        let Question6 : NSArray = ["Where did you hear about this property?"]
        
        let cmd6 = BuyerInqiryData(strTitle: "", ListPlaceHolder: textplaceholder6, strQuestion: Question6,imgYes: img,imgNo : img,imgI : img,imgL : img, imgN : img, imgF : img,imgO : img)
        
        self.buyerInquiryForm.append(cmd)
        self.buyerInquiryForm.append(cmd2)
        self.buyerInquiryForm.append(cmd3)
        self.buyerInquiryForm.append(cmd4)
        self.buyerInquiryForm.append(cmd5)
        self.buyerInquiryForm.append(cmd6)
        //        Comments
        //        Type your comments
        DispatchQueue.main.async {
            completion?(self.buyerInquiryForm)
        }
    }
    
    
    func RequestAppraisalFormSubmit(url : String , parameter : String,completion:((NSString)->())?) {
        
        let url = NSURL(string: url as String)
        var message = NSString()
        //        let url = NSURL(string: "https://retptyltd.com/webservice_pts/pts_home_list.php" as String)
        var request = URLRequest(url: url as! URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var parameters : NSString = NSString()
        parameters = parameter as NSString
        //        parameter = parameter.appending("alex@slpqld.com.au") as NSString
       // parameter = parameter.appending("kamlesh@technobrave.com") as NSString
        request.httpBody = parameters.data(using: String.Encoding.utf8.rawValue)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
                // let responseObject = try JSONSerialization.jsonObject(with: data)
                //print(responseObject)
                
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    let status = parsedData["status"] as! Bool
                    if(!status){
                        let field = parsedData["msg"] as! String
                        message = parsedData["msg"] as! NSString
                        var Error : String!
                        Error = (field as NSString) as String!
                        print(Error)
                    }else{
//                        let field = parsedData["info"] as! [[String:Any]]
                       message = parsedData["info"] as! NSString
//                        print(field)
                    }
                }
                DispatchQueue.main.async {
                    completion?(message)
                }
                
            }
        }
        task.resume()
    }
    
    //RequestAppraisal
    //https://retptyltd.com/webservice_pts/pts_home_list.php?email=alex@slpqld.com.au
    
    func TestimonialListData(completion:(([TestimonilalList])->())?) {
        let cmd0 = TestimonilalList(strTitle: "“Testimonial“", strContent: "Very, very happy with the David Weir Team, would highly recommend them to anyone!", strDate: "22 November 2016", strAuthour: "Laura Gallagher")
        self.TestimonialList.append(cmd0)
        
        let cmd = TestimonilalList(strTitle: "“Testimonial“", strContent: "I would like to thank you for the excellent work you did on the sale of my house. I appreciate the professionalism that you showed during the whole process and also the rapid result you had in selling the house in just two weeks. It has been a pleasure to do business with you and your company", strDate: "16 November 2016", strAuthour: "Cornelia Lodder")
        self.TestimonialList.append(cmd)
        
        let cmd1 = TestimonilalList(strTitle: "“Testimonial“", strContent: "A very high standard, very good price achieved & marketing. Excellent communication.", strDate: "15 November 2016", strAuthour: "Thomas Grady")
        self.TestimonialList.append(cmd1)
        
        let cmd2 = TestimonilalList(strTitle: "“Testimonial“", strContent: "Exceptional Service. Anita and I would recommend David and his team highly when you are seeking to purchase your next home. David's professionalism and his happy mannerism was very comforting. Nothing that you would request ever seemed an issue with David nor with the team.", strDate: "11 November 2016", strAuthour: "Maria & Anita Viola")
        self.TestimonialList.append(cmd2)
        
        let cmd3 = TestimonilalList(strTitle: "“Testimonial“", strContent: "Myself and Lisa are pretty happy as we sold our property at our acceptable price in a short period of time. I really appreciate your great effort and expertise. I understand it’s not easy to sell property at the moment, we got the right person, and the right team - will let all my friends know of David Weir “Mr Nollamara“ and his great team regarding to buying or selling property.", strDate: "3 November 2016", strAuthour: "Bruce Zhang & Lisa Li")
        self.TestimonialList.append(cmd3)
        
        let cmd4 = TestimonilalList(strTitle: "“Testimonial“", strContent: "Thank you also for your efforts with the sale of my property. Over the last 35 years I have bought and sold nearly 20 properties and I can say without doubt that this latest sale has been the most stress free of all. I was very impressed by your professional and friendly approach to the marketing of my property, so much so that I have recommended you to a friend of mine who will be selling her property.", strDate: "27 October 2016", strAuthour: "Anne Macleod")
        self.TestimonialList.append(cmd4)
        
        let cmd5 = TestimonilalList(strTitle: "“Testimonial“", strContent: "Excellent, very professional, friendly! Perfect!", strDate: "26 October 2016", strAuthour: "Inga Carr")
        self.TestimonialList.append(cmd5)
        
        let cmd6 = TestimonilalList(strTitle: "“Testimonial“", strContent: "A big thank you to David Weir. Working with David made selling my place an easy and pleasant experience. I knew he was in my corner and he got me the price I wanted. I highly recommend him and his assistant Terryn. Thanks so much.", strDate: "19 October 2016", strAuthour: "Tania McGaffin")
        self.TestimonialList.append(cmd6)
        
        let cmd7 = TestimonilalList(strTitle: "“Testimonial“", strContent: "I wanted to thank you for your professionalism you have demonstrated over the years that we have had business dealings with you and your team - I would have no reservations about recommending you to anyone wishing to sell their property or buy another one. I am sure that we would not have had the success that we did without your knowledge, skill and tenacity as well as your honesty - your reputation certainly does go before you and you are not only “Mr Nollamara“ but our “Mr Realestate“ too.", strDate: "18 October 2016", strAuthour: "Linda Davies")
        self.TestimonialList.append(cmd7)
        
        let cmd8 = TestimonilalList(strTitle: "“Testimonial“", strContent: "When you sign David Weir to sell your home you get more bang for your buck! Not only do you get a true professional in David but you also get Terryn and together they form an awesome team! In all my previous dealings be it commercial, agricultural or residential real estate never has any one or team provided me with better service - I have no hesitation in recommending David.", strDate: "18 October 2016", strAuthour: "Mike Hart")
        self.TestimonialList.append(cmd8)
        
        let cmd9 = TestimonilalList(strTitle: "“Testimonial“", strContent: "Friendly, attentive team. Helpful advice on how to best present the property. Team Weir were great a pain free process done in tight time frame.", strDate: "5 October 2016", strAuthour: "Gregory & Ellen Jones")
        self.TestimonialList.append(cmd9)
        
        let cmd10 = TestimonilalList(strTitle: "“Testimonial“", strContent: "If you're selling in Nollamara, David is the agent you want. Unmatched in his knowledge of the local market and buyer psychology, David is a no-nonsense operator who will go the extra mile for his vendors. After being told we could get an unrealistically high price for our house by a competitor, we had David do an appraisal. We implemented the advice he gave us re improving the property and it sold after 1 home open at a price we were happy with. Two thumbs up.", strDate: "29 September 2016", strAuthour: "Sarah Robb")
        self.TestimonialList.append(cmd10)
        
        let cmd11 = TestimonilalList(strTitle: "“Testimonial“", strContent: "We highly recommend David to any prospective sellers. He showed a level of professionalism second to none. The team was always available to us and we trusted them implicitly. Combined with the fact that David was able to sell our home for more than we thought we experienced a very easy transition to our new home.", strDate: "16 September 2016", strAuthour: "Rodney & Debra Ogden")
        self.TestimonialList.append(cmd11)
        
        let cmd12 = TestimonilalList(strTitle: "“Testimonial“", strContent: "Many thanks for making the sale of my property in a slow market happen so quickly. I had already bought my new house and would have struggled if my own home didn't sell within a month. With David's reassurance and advice in preparing for home opens, it all went smoothly. Terryn arranged a wonderful advertising campaign assisting with any queries I had and I had many. They provided me with all the assistance I needed not only as a seller but in my purchase which was with another agent. I am very grateful to them both.", strDate: "16 September 2016", strAuthour: "Marcella Cranny-Connelly")
        self.TestimonialList.append(cmd12)

        let cmd13 = TestimonilalList(strTitle: "“Testimonial“", strContent: "David is the best! David sold 2 of our investment properties in Nollamara in the last year. Both were sold within 2 weeks! We advise any buyer or seller in and around Nollamara to contact David, you won't regret it!", strDate: "14 September 2016", strAuthour: "Martin & Trish Lentz")
        self.TestimonialList.append(cmd13)
        
        let cmd14 = TestimonilalList(strTitle: "“Testimonial“", strContent: "Very prompt and professional, ticked all the boxes. I felt very confident and assured, very thrilled!", strDate: "26 August 2016", strAuthour: "Gay Clarke")
        self.TestimonialList.append(cmd14)
        
        let cmd15 = TestimonilalList(strTitle: "“Testimonial“", strContent: "Fantastic. Nothing to improve on!", strDate: "18 August 2016", strAuthour: "Laurence & Joy Dewar")
        self.TestimonialList.append(cmd15)
        
        
        DispatchQueue.main.async {
            completion?(self.TestimonialList)
        }
    
    }
    
    func PropertyList(completion:(([DropDownListData])->())?){
//        "House"
//        "Apartment and Unit"
//        "Town house"
//        "Villa"
//        "Land"
//        "Acreage"
//        "Rural"
//        "Block of Units"
//        "Retirement Living"

        let cmd1 = DropDownListData(Drp_Id: "1", Drp_StateId: "1", Drp_Name: "House", IsSelect: "NO")
        let cmd2 = DropDownListData(Drp_Id: "2", Drp_StateId: "2", Drp_Name: "Apartment and Unit", IsSelect: "NO")
        let cmd3 = DropDownListData(Drp_Id: "3", Drp_StateId: "3", Drp_Name: "Town house", IsSelect: "NO")
        let cmd4 = DropDownListData(Drp_Id: "4", Drp_StateId: "4", Drp_Name: "Villa", IsSelect: "NO")
        let cmd5 = DropDownListData(Drp_Id: "5", Drp_StateId: "5", Drp_Name: "Land", IsSelect: "NO")
        let cmd6 = DropDownListData(Drp_Id: "6", Drp_StateId: "6", Drp_Name: "Acreage", IsSelect: "NO")
        let cmd7 = DropDownListData(Drp_Id: "7", Drp_StateId: "7", Drp_Name: "Rural", IsSelect: "NO")
        let cmd8 = DropDownListData(Drp_Id: "8", Drp_StateId: "8", Drp_Name: "Block of Units", IsSelect: "NO")
        let cmd9 = DropDownListData(Drp_Id: "9", Drp_StateId: "9", Drp_Name: "Retirement Living", IsSelect: "NO")
        self.propertyListData.append(cmd1)
        self.propertyListData.append(cmd2)
        self.propertyListData.append(cmd3)
        self.propertyListData.append(cmd4)
        self.propertyListData.append(cmd5)
        self.propertyListData.append(cmd6)
        self.propertyListData.append(cmd7)
        self.propertyListData.append(cmd8)
        self.propertyListData.append(cmd9)
        
        DispatchQueue.main.async {
            completion?(self.propertyListData)
        }
    }
    
    func PriceList(completion:(([DropDownListData])->())?){
        //        "House"
        //        "Apartment and Unit"
        //        "Town house"
        //        "Villa"
        //        "Land"
        //        "Acreage"
        //        "Rural"
        //        "Block of Units"
        //        "Retirement Living"
        
        let cmd1 = DropDownListData(Drp_Id: "1", Drp_StateId: "1", Drp_Name: "$50,000", IsSelect: "NO")
        let cmd2 = DropDownListData(Drp_Id: "2", Drp_StateId: "2", Drp_Name: "$100,000", IsSelect: "NO")
        let cmd3 = DropDownListData(Drp_Id: "3", Drp_StateId: "3", Drp_Name: "$150,000", IsSelect: "NO")
        let cmd4 = DropDownListData(Drp_Id: "4", Drp_StateId: "4", Drp_Name: "$200,000", IsSelect: "NO")
        let cmd5 = DropDownListData(Drp_Id: "5", Drp_StateId: "5", Drp_Name: "$250,000", IsSelect: "NO")
        let cmd6 = DropDownListData(Drp_Id: "6", Drp_StateId: "6", Drp_Name: "$300,000", IsSelect: "NO")
        let cmd7 = DropDownListData(Drp_Id: "7", Drp_StateId: "7", Drp_Name: "$350,000", IsSelect: "NO")
        let cmd8 = DropDownListData(Drp_Id: "8", Drp_StateId: "8", Drp_Name: "$400,000", IsSelect: "NO")
        let cmd9 = DropDownListData(Drp_Id: "9", Drp_StateId: "9", Drp_Name: "$450,000", IsSelect: "NO")
        
        let cmd11 = DropDownListData(Drp_Id: "1", Drp_StateId: "11", Drp_Name: "$500,000", IsSelect: "NO")
        let cmd12 = DropDownListData(Drp_Id: "2", Drp_StateId: "12", Drp_Name: "$550,000", IsSelect: "NO")
        let cmd13 = DropDownListData(Drp_Id: "3", Drp_StateId: "13", Drp_Name: "$600,000", IsSelect: "NO")
        let cmd14 = DropDownListData(Drp_Id: "4", Drp_StateId: "14", Drp_Name: "$650,000", IsSelect: "NO")
        let cmd15 = DropDownListData(Drp_Id: "5", Drp_StateId: "15", Drp_Name: "$700,000", IsSelect: "NO")
        let cmd16 = DropDownListData(Drp_Id: "6", Drp_StateId: "16", Drp_Name: "$750,000", IsSelect: "NO")
        let cmd17 = DropDownListData(Drp_Id: "7", Drp_StateId: "17", Drp_Name: "$800,000", IsSelect: "NO")
        let cmd18 = DropDownListData(Drp_Id: "8", Drp_StateId: "18", Drp_Name: "$850,000", IsSelect: "NO")
        let cmd19 = DropDownListData(Drp_Id: "9", Drp_StateId: "19", Drp_Name: "$900,000", IsSelect: "NO")
        
        let cmd21 = DropDownListData(Drp_Id: "1", Drp_StateId: "21", Drp_Name: "$950,000", IsSelect: "NO")
        let cmd22 = DropDownListData(Drp_Id: "2", Drp_StateId: "22", Drp_Name: "$1000,000", IsSelect: "NO")
        let cmd23 = DropDownListData(Drp_Id: "3", Drp_StateId: "23", Drp_Name: "$1250,000", IsSelect: "NO")
        let cmd24 = DropDownListData(Drp_Id: "4", Drp_StateId: "24", Drp_Name: "$1500,000", IsSelect: "NO")
        let cmd25 = DropDownListData(Drp_Id: "5", Drp_StateId: "25", Drp_Name: "$1750,000", IsSelect: "NO")
        let cmd26 = DropDownListData(Drp_Id: "6", Drp_StateId: "26", Drp_Name: "$2,000,000", IsSelect: "NO")
        let cmd27 = DropDownListData(Drp_Id: "7", Drp_StateId: "27", Drp_Name: "$2,500,000", IsSelect: "NO")
        let cmd28 = DropDownListData(Drp_Id: "8", Drp_StateId: "28", Drp_Name: "$3,000,000", IsSelect: "NO")
        let cmd29 = DropDownListData(Drp_Id: "9", Drp_StateId: "29", Drp_Name: "$4,000,000", IsSelect: "NO")
        
        let cmd31 = DropDownListData(Drp_Id: "8", Drp_StateId: "38", Drp_Name: "$5,000,000", IsSelect: "NO")
        let cmd32 = DropDownListData(Drp_Id: "9", Drp_StateId: "39", Drp_Name: "$10,000,000", IsSelect: "NO")
        
        self.priceListData.append(cmd1)
        self.priceListData.append(cmd2)
        self.priceListData.append(cmd3)
        self.priceListData.append(cmd4)
        self.priceListData.append(cmd5)
        self.priceListData.append(cmd6)
        self.priceListData.append(cmd7)
        self.priceListData.append(cmd8)
        self.priceListData.append(cmd9)
        
        self.priceListData.append(cmd11)
        self.priceListData.append(cmd12)
        self.priceListData.append(cmd13)
        self.priceListData.append(cmd14)
        self.priceListData.append(cmd15)
        self.priceListData.append(cmd16)
        self.priceListData.append(cmd17)
        self.priceListData.append(cmd18)
        self.priceListData.append(cmd19)
        
        self.priceListData.append(cmd21)
        self.priceListData.append(cmd22)
        self.priceListData.append(cmd23)
        self.priceListData.append(cmd24)
        self.priceListData.append(cmd25)
        self.priceListData.append(cmd26)
        self.priceListData.append(cmd27)
        self.priceListData.append(cmd28)
        self.priceListData.append(cmd29)
        
        self.priceListData.append(cmd31)
        self.priceListData.append(cmd32)
        
        DispatchQueue.main.async {
            completion?(self.priceListData)
        }
    }
    

    
    func BedroomList(completion:(([DropDownListData])->())?){
        let cmd1 = DropDownListData(Drp_Id: "1", Drp_StateId: "1", Drp_Name: "1", IsSelect: "NO")
        let cmd2 = DropDownListData(Drp_Id: "2", Drp_StateId: "2", Drp_Name: "2", IsSelect: "NO")
        let cmd3 = DropDownListData(Drp_Id: "3", Drp_StateId: "3", Drp_Name: "3", IsSelect: "NO")
        let cmd4 = DropDownListData(Drp_Id: "4", Drp_StateId: "4", Drp_Name: "4", IsSelect: "NO")
        let cmd5 = DropDownListData(Drp_Id: "5", Drp_StateId: "5", Drp_Name: "5", IsSelect: "NO")
        self.bedroomListData.append(cmd1)
        self.bedroomListData.append(cmd2)
        self.bedroomListData.append(cmd3)
        self.bedroomListData.append(cmd4)
        self.bedroomListData.append(cmd5)
    
        DispatchQueue.main.async {
            completion?(self.bedroomListData)
        }
    }
    
  func StateListAll(completion:(([DropDownListData])->())?){
    let url = NSURL(string: "https://retptyltd.com/webservice_ios/buyer_feedback/state.php" as String)
    var message = NSString()
    //        let url = NSURL(string: "https://retptyltd.com/webservice_pts/pts_home_list.php" as String)
    var request = URLRequest(url: url as! URL)
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    //var parameters : NSString = NSString()
   // parameters = parameter as NSString
    //        parameter = parameter.appending("alex@slpqld.com.au") as NSString
    // parameter = parameter.appending("kamlesh@technobrave.com") as NSString
    //request.httpBody = parameters.data(using: String.Encoding.utf8.rawValue)
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            print(error!)                                 // some fundamental network error
            return
        }
        do {
             let responseObject = try JSONSerialization.jsonObject(with: data)
            print(responseObject)
            
            if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                let status = parsedData["status"] as! Bool
                if(!status){
                    let field = parsedData["msg"] as! String
                    message = parsedData["msg"] as! NSString
                    var Error : String!
                    Error = (field as NSString) as String!
                    print(Error)
                }else{
                    //                        let field = parsedData["info"] as! [[String:Any]]
//                    message = parsedData["info"] as! NSString
                    let field = parsedData["info"] as! [[String:Any]]
                    for blog in field {
                        let cmd = DropDownListData(Drp_Id: blog["id"] as! String!, Drp_StateId: blog["state_name"] as! String!, Drp_Name: blog["state_name"] as! String!, IsSelect: "NO")
                        self.stateListData.append(cmd)
                    }
                }
            }
            DispatchQueue.main.async {
                completion?(self.stateListData)
            }
        }catch{
            
        }
    }
    task.resume()

    
//        DispatchQueue.main.async {
//            completion?(self.stateListData)
//        }
    }
    
    func SuburbListAll(completion:(([DropDownListData])->())?){
        let url = NSURL(string: "https://retptyltd.com/webservice_ios/buyer_feedback/suburb.php" as String)
        var message = NSString()
        //        let url = NSURL(string: "https://retptyltd.com/webservice_pts/pts_home_list.php" as String)
        var request = URLRequest(url: url as! URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        //var parameters : NSString = NSString()
        // parameters = parameter as NSString
        //        parameter = parameter.appending("alex@slpqld.com.au") as NSString
        // parameter = parameter.appending("kamlesh@technobrave.com") as NSString
        //request.httpBody = parameters.data(using: String.Encoding.utf8.rawValue)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
                let responseObject = try JSONSerialization.jsonObject(with: data)
                print(responseObject)
                
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    let status = parsedData["status"] as! Bool
                    if(!status){
                        let field = parsedData["msg"] as! String
                        message = parsedData["msg"] as! NSString
                        var Error : String!
                        Error = (field as NSString) as String!
                        print(Error)
                    }else{
                        self.suburbListData = [DropDownListData]()
                        
                        //                        let field = parsedData["info"] as! [[String:Any]]
                        //                    message = parsedData["info"] as! NSString
                        let field = parsedData["info"] as! [[String:Any]]
                        for blog in field {
                            let cmd = DropDownListData(Drp_Id: blog["state_id"] as! String!, Drp_StateId: blog["state_id"] as! String!, Drp_Name: blog["suburb_name"] as! String!, IsSelect: "NO")
                            self.suburbListData.append(cmd)
                        }
                    }
                }
                DispatchQueue.main.async {
                    completion?(self.suburbListData)
                }
            }catch{
                
            }
        }
        task.resume()
        
        
        //        DispatchQueue.main.async {
        //            completion?(self.stateListData)
        //        }
    }

    
//    StateList

    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
}

class TableViewHelper {
    
    class func EmptyMessage(message:String, viewController:UITableView) {
        let messageLabel = UILabel(frame: CGRect(x: 0,y: 0,width: viewController.frame.size.width,height: viewController.frame.size.height))
        messageLabel.text = message
        messageLabel.textColor = UIColor.black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 20)
        messageLabel.sizeToFit()
        
        viewController.backgroundView = messageLabel;
        viewController.separatorStyle = .none;
    }
}

extension UIColor{
    func NavigationBar() -> UIColor {
        return GloabalMethods().hexStringToUIColor(hex: "FF771B")
    }
//#FF771B
}
