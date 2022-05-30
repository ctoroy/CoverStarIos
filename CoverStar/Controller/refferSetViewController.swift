//
//  refferSetViewController.swift
//  CoverStar
//
//  Created by taehan park on 2022/04/18.
//

import UIKit

class refferSetViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var txtRefferCode: UITextField!
    @IBOutlet weak var bBtnBack: UIBarButtonItem!
    @IBOutlet weak var btnNext: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("userId="+Static.userId.replace("+", ""))
        print("phoneNumber="+Static.userId.replace("+", ""))
        print("Static.countryCode="+Static.countryCode)        
        print("Static.countryNo="+Static.countryNo)
        print("Static.userPhoneNumber="+Static.userPhoneNumber)
        print("Static.nickName="+Static.userName)
        print("Static.userProfileImage="+Static.userProfileImage)
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
                view.addGestureRecognizer(tap)
        
        bBtnBack.action = #selector(backButtonPressed(sender:))
        
        txtRefferCode.borderStyle = .none
                let border = CALayer()
                border.frame = CGRect(x: 0, y: txtRefferCode.frame.size.height-1, width: txtRefferCode.frame.width, height: 1)
        border.backgroundColor = UIColor.black.cgColor
        txtRefferCode.layer.addSublayer((border))
        txtRefferCode.keyboardType = .numbersAndPunctuation
        
        txtRefferCode.addDoneButtonToKeyboard(myAction:  #selector(self.txtRefferCode.resignFirstResponder))
        self.txtRefferCode.becomeFirstResponder()
    }

        @IBAction func btnNextClick(_ sender: UIButton) {
            if txtRefferCode.text!.count < 1 {
                self.performSegue(withIdentifier: "createWallet", sender: nil)
            }else{
                checkRecommend(recommend: txtRefferCode.text!)
            }
        }
    
    func checkRecommend(recommend: String) {
        
        popupManager.showLoadingView()
        
        httpTool.checkRecommend(recommend: recommend) { (succeed, resultInfo) in
        
            popupManager.hideLoadingView()
        
            if succeed {
                dispatchMain.async {
                    Static.recommendCode = self.txtRefferCode.text!
                    self.performSegue(withIdentifier: "createWallet", sender: nil)
                }
            }else{
                    let alert = UIAlertController(title: "추천코드오류", message: "잘못된 추천코드 입니다.", preferredStyle: .alert)
                    
                    let OKAction = UIAlertAction(title: "확인", style: .default) {
                        (action:UIAlertAction!) in
                        // Code in this block will trigger when OK button tapped.
                        self.txtRefferCode.resignFirstResponder()
                        }

                    // add an action (button)
                    alert.addAction(OKAction)

                    // show the alert
                    self.present(alert, animated: true, completion: nil)
            }
        }
    }
        
        
        @objc func backButtonPressed(sender: UIBarButtonItem) {
        
        self.presentingViewController?.dismiss(animated: true, completion:nil)
    }

}



