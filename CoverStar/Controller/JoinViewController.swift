//
//  JoinViewController.swift
//  CoverStar
//
//  Created by taehan park on 2022/05/29.
//

import UIKit

class JoinViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var btnJoin: UIButton!
    @IBOutlet weak var txtMySay: UITextView!
    @IBOutlet weak var txtVodLink: UITextField!
    @IBOutlet weak var bbtnMyPoint: UIBarButtonItem!
    @IBOutlet weak var txtSubTitle: UITextField!
    
    var contestList : [ContestInfo] = []
    var castStartDate = ""
    var castEndDate = ""
    var category = ""
    var castPath = ""
    var profileIamge = ""
    var castType = ""
    var sortMid = ""
    var sortSmall = ""
    var location = ""
    var store = ""
    var product = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
                view.addGestureRecognizer(tap)
        
        txtTitle.delegate = self
        txtVodLink.delegate = self
        txtSubTitle.delegate = self
        
        txtTitle.addDoneButtonToKeyboard(myAction:  #selector(self.txtTitle.resignFirstResponder))
        txtVodLink.addDoneButtonToKeyboard(myAction:  #selector(self.txtVodLink.resignFirstResponder))
        txtSubTitle.addDoneButtonToKeyboard(myAction:  #selector(self.txtSubTitle.resignFirstResponder))
        
        let color = UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0).cgColor
        txtMySay.layer.borderColor = color
        txtMySay.layer.borderWidth = 0.5
        txtMySay.layer.cornerRadius = 5
        
        self.showAlertController(style: UIAlertController.Style.actionSheet,isFirst: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        popupManager.showLoadingView()
        
        httpTool.getCurCoin(userID: Static.userId) { (succeed, resultInfo) in
        
            popupManager.hideLoadingView()
        
            if succeed {
                print("my coin =\(Static.curCoin)")
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                let result = numberFormatter.string(from: NSNumber(value: Static.curCoin))!
                self.bbtnMyPoint.tintColor = UIColor(named: "anychat_pink")
                self.bbtnMyPoint.title = "\(result)STAR"
            }
        }
    }
    
        func showAlertController(style: UIAlertController.Style, isFirst:Bool) {
            
            self.contestList.removeAll()
            popupManager.showLoadingView()
            
            httpTool.loadContestList() { (succeed, contestList, resultInfo) in
                    
                popupManager.hideLoadingView()
                if succeed {
                    self.contestList.append(contentsOf: contestList)
                    print("self.contestList count=\(self.contestList.count)")
                }
                
                let alertController = UIAlertController(title: "?????? ??????", message: "????????? ?????????.", preferredStyle: .actionSheet)
                
                print("contestList count=\(self.contestList.count)")

                for (index, item) in  self.contestList.enumerated(){
                        print("alert add2\(item.contestTitle)")
                    if index == 0{
                        self.btnFilter.setTitle(item.contestTitle, for: .normal)
                    }
                        let superbutton = UIAlertAction(title: item.contestTitle , style: .default, handler: { (action) in
                            print("alert add\(item.contestTitle)")
                            self.btnFilter.setTitle(action.title, for: .normal)
                            
                            self.castStartDate = item.contestStartDate
                            self.castEndDate = item.contestEndDate
                            self.category = item.contestType
                            self.castPath = "\(item.contestId)"
                            let imsi = self.txtVodLink.text?.replace("https://youtu.be/", "")
                            self.profileIamge = "https://img.youtube.com/vi/" + imsi! + "/hqdefault.jpg"
                            self.castType = item.contestType
                            self.sortMid = item.contestAward
                            self.sortSmall = item.contestTitle
                            self.store = item.contestShotDate
                            
                        })
                    
                        self.castStartDate = item.contestStartDate
                        self.castEndDate = item.contestEndDate
                        self.category = item.contestType
                        self.castPath = "\(item.contestId)"
                        let imsi = self.txtVodLink.text?.replace("https://youtu.be/", "")
                        self.profileIamge = "https://img.youtube.com/vi/" + imsi! + "/hqdefault.jpg"
                        self.castType = item.contestType
                        self.sortMid = item.contestAward
                        self.sortSmall = item.contestTitle
                        self.store = item.contestShotDate
                    
                        superbutton.setValue(UIColor(named: "anychat_pink"), forKey: "titleTextColor")
                        alertController.addAction(superbutton)
                    }
                if (isFirst == false){
                    let cancelAction: UIAlertAction
                    cancelAction = UIAlertAction(title: "??????", style: UIAlertAction.Style.cancel, handler: nil)
                    cancelAction.setValue(UIColor(named: "anychat_pink"), forKey: "titleTextColor")
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: { print("Alert controller shown") })
                }
            }
        }
    
    @IBAction func btnFilter_click(_ sender: Any) {
        self.showAlertController(style: UIAlertController.Style.actionSheet,isFirst: false)
    }
            
    @IBAction func btnJoin_Action(_ sender: Any) {
        
        if(self.txtTitle.text == ""){
            let alert = UIAlertController(title: "?????? ??????", message: "??????????????? ?????? ????????? ?????????.", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "??????", style: .default) {
                (action:UIAlertAction!) in
                self.txtTitle.becomeFirstResponder()
                }
            
            alert.addAction(OKAction)
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        if(self.txtSubTitle.text == ""){
            let alert = UIAlertController(title: "?????? ??????", message: "??????????????? ?????? ????????? ?????????.", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "??????", style: .default) {
                (action:UIAlertAction!) in
                    self.txtSubTitle.becomeFirstResponder()
                }
            
            alert.addAction(OKAction)
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        if(self.txtVodLink.text == ""){
            let alert = UIAlertController(title: "?????? ??????", message: "??????????????? ?????? ????????? ?????????.", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "??????", style: .default) {
                (action:UIAlertAction!) in
                    self.txtVodLink.becomeFirstResponder()
                }
            
            alert.addAction(OKAction)
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        let nowDate = Date() // ????????? Date (ex: 2020-08-13 09:14:48 +0000)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        let str = dateFormatter.string(from: nowDate)
        
        let castCode = Static.userId + str
        let castTitle = self.txtTitle.text!
        let category = self.category
        let castPath = self.castPath
        let profileImage = self.profileIamge
        let castType = self.castType
        let castStartDate = self.castStartDate
        let castEndDate = self.castEndDate
        let logoImage = self.txtSubTitle.text!
        let sortBig = self.txtMySay.text!
        let sortMid = self.sortMid
        let sortSmall = self.sortSmall
        let location = self.txtVodLink.text!
        let store = self.store
        let product = ""
        
        let Award = Int(sortMid)!
        
        if(Award < 3000){
            let alert = UIAlertController(title: "????????? ??????", message: "???????????? ??????????????? ?????? ??? ????????? ?????????.", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "?????? ????????? ??????", style: .default) {
                (action:UIAlertAction!) in
                    self.performSegue(withIdentifier: "joinToPoint", sender: nil)
                }
            
            let cancelAction: UIAlertAction
            cancelAction = UIAlertAction(title: "??????", style: UIAlertAction.Style.cancel, handler: nil)

            // add an action (button)
            alert.addAction(OKAction)
            alert.addAction(cancelAction)

            // show the alert
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        
        let alert = UIAlertController(title: "???????????? ??????", message: "3000P??? ????????? ?????? ???????????????????", preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "??????", style: .default) {
            (action:UIAlertAction!) in
            self.joinContest(castCode: castCode, castTitle: castTitle, category: category, castPath: castPath, profileImage: profileImage, castType: castType, castStartDate: castStartDate, castEndDate: castEndDate, logoImage: logoImage, sortBig: sortBig, sortMid: sortMid, sortSmall: sortSmall, location: location, store: store, product: product)
            }
        
        let cancelAction: UIAlertAction
            cancelAction = UIAlertAction(title: "??????", style: UIAlertAction.Style.cancel, handler:
                                        { (action) in
            return
        })

        // add an action (button)
        alert.addAction(OKAction)
        alert.addAction(cancelAction)

        // show the alert
        self.present(alert, animated: true, completion: nil)

    }
    
    func joinContest(castCode : String,
                     castTitle : String,
                     category : String,
                     castPath : String,
                     profileImage : String,
                     castType : String,
                     castStartDate : String,
                     castEndDate : String,
                     logoImage : String,
                     sortBig : String,
                     sortMid : String,
                     sortSmall : String,
                     location : String,
                     store : String,
                     product : String) {
        
        popupManager.showLoadingView()
        
        httpTool.joinContest(castCode : castCode,
                             castTitle : castTitle,
                             category : category,
                             castPath : castPath,
                             profileImage : profileImage,
                             castType : castType,
                             castStartDate : castStartDate,
                             castEndDate : castEndDate,
                             logoImage : logoImage,
                             sortBig : sortBig,
                             sortMid : sortMid,
                             sortSmall : sortSmall,
                             location : location,
                             store : store,
                             product : product) { (succeed, resultInfo) in
        
            popupManager.hideLoadingView()
        
            if succeed {
                dispatchMain.async {
                    let alert = UIAlertController(title: "????????????", message: "????????? ?????? ???????????????.", preferredStyle: .alert)
                    
                    let OKAction = UIAlertAction(title: "??????", style: .default) {
                        (action:UIAlertAction!) in
                        
                        }

                    // add an action (button)
                    alert.addAction(OKAction)

                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                }
            }else{
                    let alert = UIAlertController(title: "????????????", message: "??????????????? ?????? ????????????.", preferredStyle: .alert)
                    
                    let OKAction = UIAlertAction(title: "??????", style: .default) {
                        (action:UIAlertAction!) in
                        // Code in this block will trigger when OK button tapped.
                        }

                    // add an action (button)
                    alert.addAction(OKAction)

                    // show the alert
                    self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
