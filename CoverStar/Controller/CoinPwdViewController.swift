//
//  CoinPwdViewController.swift
//  CoverStar
//
//  Created by taehan park on 2022/04/18.
//

import UIKit

class CoinPwdViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var bBtnBack: UIBarButtonItem!
    @IBOutlet weak var txtP1: UITextField!
    @IBOutlet weak var txtP2: UITextField!
    @IBOutlet weak var txtP3: UITextField!
    @IBOutlet weak var txtP4: UITextField!
    @IBOutlet weak var txtP5: UITextField!
    @IBOutlet weak var txtP6: UITextField!
    @IBOutlet weak var txtP7: UITextField!
    @IBOutlet weak var txtP8: UITextField!
    @IBOutlet weak var txtP9: UITextField!
    @IBOutlet weak var txtP10: UITextField!
    @IBOutlet weak var txtP11: UITextField!
    @IBOutlet weak var txtP12: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var imgChk: UIImageView!
    
    let characterLimit = 1
    
    override func viewDidLoad() {
        
        print("userId="+Static.userId.replace("+", ""))
        print("phoneNumber="+Static.userId.replace("+", ""))
        print("Static.countryCode="+Static.countryCode)
        print("Static.countryNo="+Static.countryNo)
        print("Static.userPhoneNumber="+Static.userPhoneNumber)
        print("Static.nickName="+Static.nickName)
        print("Static.userProfileImage="+Static.userProfileImage)
        print("Static.recommendCode="+Static.recommendCode)
        print("Static.pushIde="+Static.pushId)
        
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
                view.addGestureRecognizer(tap)
    
        imgChk.isHidden = false
        
        txtP1.keyboardType = .numberPad
        txtP2.keyboardType = .numberPad
        txtP3.keyboardType = .numberPad
        txtP4.keyboardType = .numberPad
        txtP5.keyboardType = .numberPad
        txtP6.keyboardType = .numberPad
        
        txtP7.keyboardType = .numberPad
        txtP8.keyboardType = .numberPad
        txtP9.keyboardType = .numberPad
        txtP10.keyboardType = .numberPad
        txtP11.keyboardType = .numberPad
        txtP12.keyboardType = .numberPad
        
        txtP1.addTarget(self, action: #selector(PasswdAuthViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        txtP2.addTarget(self, action: #selector(PasswdAuthViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        txtP3.addTarget(self, action: #selector(PasswdAuthViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        txtP4.addTarget(self, action: #selector(PasswdAuthViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        txtP5.addTarget(self, action: #selector(PasswdAuthViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        txtP6.addTarget(self, action: #selector(PasswdAuthViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        txtP7.addTarget(self, action: #selector(PasswdAuthViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        txtP8.addTarget(self, action: #selector(PasswdAuthViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        txtP9.addTarget(self, action: #selector(PasswdAuthViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        txtP10.addTarget(self, action: #selector(PasswdAuthViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        txtP11.addTarget(self, action: #selector(PasswdAuthViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        txtP12.addTarget(self, action: #selector(PasswdAuthViewController.textFieldDidEnd(_:)), for: UIControl.Event.editingChanged)
        
        txtP1.addTarget(self, action: #selector(myTextFieldDidChange(_:)), for: .editingChanged)
        txtP2.addTarget(self, action: #selector(myTextFieldDidChange(_:)), for: .editingChanged)
        txtP3.addTarget(self, action: #selector(myTextFieldDidChange(_:)), for: .editingChanged)
        txtP4.addTarget(self, action: #selector(myTextFieldDidChange(_:)), for: .editingChanged)
        txtP5.addTarget(self, action: #selector(myTextFieldDidChange(_:)), for: .editingChanged)
        txtP6.addTarget(self, action: #selector(myTextFieldDidChange(_:)), for: .editingChanged)
        txtP7.addTarget(self, action: #selector(myTextFieldDidChange(_:)), for: .editingChanged)
        txtP8.addTarget(self, action: #selector(myTextFieldDidChange(_:)), for: .editingChanged)
        txtP9.addTarget(self, action: #selector(myTextFieldDidChange(_:)), for: .editingChanged)
        txtP10.addTarget(self, action: #selector(myTextFieldDidChange(_:)), for: .editingChanged)
        txtP11.addTarget(self, action: #selector(myTextFieldDidChange(_:)), for: .editingChanged)
        txtP12.addTarget(self, action: #selector(myTextFieldDidChange(_:)), for: .editingChanged)
        
        txtP1.becomeFirstResponder()
        
        bBtnBack.action = #selector(backButtonPressed(sender:))
        
//        imgChk.action = #selector(imgChkPressed(sender:))
    }
    
    @objc func myTextFieldDidChange(_ textField: UITextField) {
        textField.text = String(textField.text!.prefix(self.characterLimit))
    }
    
    @IBAction func btnNextClick(_ sender: UIButton) {

        if(Static.userPwd != ""){
            Static.userPwd = ""
        }
        Static.userPwd += txtP1.text ?? ""
        Static.userPwd += txtP2.text ?? ""
        Static.userPwd += txtP3.text ?? ""
        Static.userPwd += txtP4.text ?? ""
        Static.userPwd += txtP5.text ?? ""
        Static.userPwd += txtP6.text ?? ""
        
        var curCoin = "0"
        
        if(Static.recommendCode != ""){
            curCoin = "3"
        }
        
        self.join(userId : Static.userPhoneNumber,
                  nickName : Static.nickName,
                  userPwd : Static.userPwd,
                  userProfileImage : Static.userProfileImage,
                  pushId : Static.pushId,
                  device : "2",
                  userDialCode : Static.countryNo,
                  userNation : Static.countryCode,
                  curCoin : curCoin,
                  recommendKey : Static.recommendCode,
                  coinPwd : Static.userPwd)
    }
    
    @objc func textFieldDidEnd(_ textField: UITextField) {
        if textField == txtP12 {
            view.endEditing(true)
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
            if textField == txtP1 {
                print("txtP1")
                if (textField.text?.count)! >= 1 {
                    print("txtP1inner")
                    txtP2?.becomeFirstResponder()
                }
            }else if textField == txtP2 {
                print("txtP2")
                if (textField.text?.count)! >= 1 {
                    print("txtP2inner")
                    txtP3.becomeFirstResponder()
                }
            }else if textField == txtP3 {
                print("txtP3")
                if (textField.text?.count)! >= 1 {
                    txtP4.becomeFirstResponder()
                }
            }else if textField == txtP4 {
                if (textField.text?.count)! >= 1 {
                    txtP5.becomeFirstResponder()
                }
            }else if textField == txtP5 {
                if (textField.text?.count)! >= 1 {
                    txtP6.becomeFirstResponder()
                }
            }else if textField == txtP6 {
                if (textField.text?.count)! >= 1 {
                    txtP7.becomeFirstResponder()
                }
            }else if textField == txtP7 {
                if (textField.text?.count)! >= 1 {
                    txtP8.becomeFirstResponder()
                }
            }else if textField == txtP8 {
                if (textField.text?.count)! >= 1 {
                    txtP9.becomeFirstResponder()
                }
            }else if textField == txtP9 {
                if (textField.text?.count)! >= 1 {
                    txtP10.becomeFirstResponder()
                }
            }else if textField == txtP10 {
                if (textField.text?.count)! >= 1 {
                    txtP11.becomeFirstResponder()
                }
            }else if textField == txtP11 {
                if (textField.text?.count)! >= 1 {
                    txtP12.becomeFirstResponder()
                }
            }
        }
    
    @objc func backButtonPressed(sender: UIBarButtonItem) {
        self.presentingViewController?.dismiss(animated: true, completion:nil)
    }
    
    func join(userId : String,
              nickName : String,
              userPwd : String,
              userProfileImage : String,
              pushId : String,
              device : String,
              userDialCode : String,
              userNation : String,
              curCoin : String,
              recommendKey : String,
              coinPwd : String) {
        
        popupManager.showLoadingView()
        
        httpTool.join(userId: userId,
                      nickName : nickName,
                      userPwd : userPwd,
                      userProfileImage : userProfileImage,
                      pushId : pushId,
                      device : device,
                      userDialCode : userDialCode,
                      userNation : userNation,
                      curCoin : curCoin,
                      recommendKey : recommendKey,
                      coinPwd : coinPwd) { (succeed, resultInfo) in
        
            popupManager.hideLoadingView()
        
            if succeed {
                dispatchMain.async {
                    self.performSegue(withIdentifier: "completeRegist", sender: nil)
                }
            }else{
                    let alert = UIAlertController(title: "회원가입오류", message: "관리자에게 문의 바랍니다.", preferredStyle: .alert)
                    
                    let OKAction = UIAlertAction(title: "확인", style: .default) {
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
