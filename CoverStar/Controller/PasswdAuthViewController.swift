//
//  PasswdAuthViewController.swift
//  CoverStar
//
//  Created by taehan park on 2022/04/15.
//

import UIKit

class PasswdAuthViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var bBtnBack: UIBarButtonItem!
    @IBOutlet weak var txtP1: UITextField!
    @IBOutlet weak var txtP2: UITextField!
    @IBOutlet weak var txtP3: UITextField!
    @IBOutlet weak var txtP4: UITextField!
    @IBOutlet weak var txtP5: UITextField!
    @IBOutlet weak var txtP6: UITextField!
    @IBOutlet weak var lblNoti: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    
    let characterLimit = 1
    var failCnt = 0
    var userId:String = ""
    
    override func viewDidLoad() {
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
                view.addGestureRecognizer(tap)
        
        txtP1.keyboardType = .numberPad
        txtP2.keyboardType = .numberPad
        txtP3.keyboardType = .numberPad
        txtP4.keyboardType = .numberPad
        txtP5.keyboardType = .numberPad
        txtP6.keyboardType = .numberPad
        
        txtP1.addTarget(self, action: #selector(PasswdAuthViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        txtP2.addTarget(self, action: #selector(PasswdAuthViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        txtP3.addTarget(self, action: #selector(PasswdAuthViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        txtP4.addTarget(self, action: #selector(PasswdAuthViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        txtP5.addTarget(self, action: #selector(PasswdAuthViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        txtP6.addTarget(self, action: #selector(PasswdAuthViewController.textFieldDidEnd(_:)), for: UIControl.Event.editingChanged)
        
        txtP1.addTarget(self, action: #selector(myTextFieldDidChange(_:)), for: .editingChanged)
        txtP2.addTarget(self, action: #selector(myTextFieldDidChange(_:)), for: .editingChanged)
        txtP3.addTarget(self, action: #selector(myTextFieldDidChange(_:)), for: .editingChanged)
        txtP4.addTarget(self, action: #selector(myTextFieldDidChange(_:)), for: .editingChanged)
        txtP5.addTarget(self, action: #selector(myTextFieldDidChange(_:)), for: .editingChanged)
        txtP6.addTarget(self, action: #selector(myTextFieldDidChange(_:)), for: .editingChanged)
        
        txtP1.becomeFirstResponder()
        
        bBtnBack.action = #selector(backButtonPressed(sender:))
        
        print("----------------")
        print("userId="+userId)
        print("----------------")
    }
    
    @IBAction func btnNextClick(_ sender: Any) {
        
        var newPwd = ""
        newPwd += txtP1.text ?? ""
        newPwd += txtP2.text ?? ""
        newPwd += txtP3.text ?? ""
        newPwd += txtP4.text ?? ""
        newPwd += txtP5.text ?? ""
        newPwd += txtP6.text ?? ""
        
        if newPwd.count < 6 {
            let alert = UIAlertController(title: "필수 입력", message: "6자리 암호를 모두 입력 하셔야 합니다.", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "확인", style: .default) {
                (action:UIAlertAction!) in
                // Code in this block will trigger when OK button tapped.
                print("Ok button tapped");
                }

            // add an action (button)
            alert.addAction(OKAction)

            // show the alert
            self.present(alert, animated: true, completion: nil)
            
            return
        }else{
            self.sendLogin(id: userId, pw: newPwd)
        }
    }
    
    @objc func myTextFieldDidChange(_ textField: UITextField) {
        textField.text = String(textField.text!.prefix(self.characterLimit))
    }
    
    @objc func textFieldDidEnd(_ textField: UITextField) {
        if textField == txtP6 {
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
            }
        }
    
    @objc func backButtonPressed(sender: UIBarButtonItem) {
        self.presentingViewController?.dismiss(animated: true, completion:nil)
    }
    
    func sendLogin(id: String, pw: String) {
        
        popupManager.showLoadingView()
        
        httpTool.login(userID: id, userPw: pw) { (succeed, resultInfo) in
        
            popupManager.hideLoadingView()
        
            if succeed {
                appData.set(id, forKey: "userID")
                appData.set(pw, forKey: "userPw")
                appData.synchronize()
                Static.userId = id
                
                dispatchMain.async {
                    self.performSegue(withIdentifier: "newToMain", sender: nil)
                }
            }else{
                print("비밀번호가 틀립니다." + pw)
                self.failCnt += 1
                
                if self.failCnt == 5 {
                    
                    let alert = UIAlertController(title: "암호 실패", message: "암호를 5번 잘못 입력하여 앱을 종료 합니다..", preferredStyle: .alert)
                    
                    let OKAction = UIAlertAction(title: "확인", style: .default) {
                        (action:UIAlertAction!) in
                        // Code in this block will trigger when OK button tapped.
                        print("Ok button tapped");
                        UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { exit(0) }
                        }

                    // add an action (button)
                    alert.addAction(OKAction)

                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                    
                }else{
                    self.lblNoti.textColor = UIColor(red: 244/255.0, green: 87/255.0, blue: 134/255.0, alpha: 1)
                    self.lblNoti.text = "비밀번호를 다시 입력해 주세요. \n입력 오류 횟수(\(self.failCnt)/5)"
                    
                    self.txtP1.text = ""
                    self.txtP2.text = ""
                    self.txtP3.text = ""
                    self.txtP4.text = ""
                    self.txtP5.text = ""
                    self.txtP6.text = ""
                    self.txtP1.becomeFirstResponder()
                }
            }
        }
    }
    
}
