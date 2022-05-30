//
//  authCompleteViewController.swift
//  CoverStar
//
//  Created by taehan park on 2022/04/05.
//

import UIKit
import FirebaseAuth

class AuthCompleteViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var bBtnBack: UIBarButtonItem!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnResend: UIButton!
    @IBOutlet weak var txtFPhoneNumber: UITextField!
    
    var seconds = 180
    var timer = Timer()
    var verificationID = appData.string(forKey: "authVerificationID")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let localeID = Locale.preferredLanguages.first
        let deviceLocale = (Locale(identifier: localeID!).languageCode)!
        
        Auth.auth().languageCode = deviceLocale
        
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = .white
        config.background.strokeColor = UIColor(red: 244/255.0, green: 87/255.0, blue: 134/255.0, alpha: 1)
        config.background.strokeWidth = 2.0
        btnResend.configuration = config
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
                view.addGestureRecognizer(tap)
        
        bBtnBack.action = #selector(backButtonPressed(sender:))
        
        txtFPhoneNumber.delegate = self
        
        txtFPhoneNumber.borderStyle = .none
                let border = CALayer()
                border.frame = CGRect(x: 0, y: txtFPhoneNumber.frame.size.height-1, width: txtFPhoneNumber.frame.width, height: 1)
        border.backgroundColor = UIColor.black.cgColor
        txtFPhoneNumber.layer.addSublayer((border))
        txtFPhoneNumber.keyboardType = .numberPad
        
        txtFPhoneNumber.addDoneButtonToKeyboard(myAction:  #selector(self.txtFPhoneNumber.resignFirstResponder))
        self.txtFPhoneNumber.becomeFirstResponder()
        
        runTimer()
    }
    
    func timeString(time:TimeInterval) -> String {
//        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i 남음",minutes, seconds)
    }
    
    func runTimer() {
//        btnResend.isEnabled = false
         timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if seconds < 1 {
              timer.invalidate()
              btnResend.isEnabled = true
         } else {
              seconds -= 1
             lblTimer.text = timeString(time: TimeInterval(seconds))
         }
    }
    @IBAction func btnResendClick(_ sender: Any) {
        print("userId=" + Static.userId)
        print(verificationID as Any)
        
        txtFPhoneNumber.text = ""
        
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(Static.userId, uiDelegate: nil) { verificationID, error in
              if let error = error {
                  print(error)
                  let alert = UIAlertController(title: "오류", message: "인증번호 전송 오류.", preferredStyle: .alert)
                  
                  let OKAction = UIAlertAction(title: "확인", style: .default) { [self]
                      (action:UIAlertAction!) in
                      // Code in this block will trigger when OK button tapped.
                      print("Ok button tapped")
                      self.txtFPhoneNumber.becomeFirstResponder()
                      }
                  alert.addAction(OKAction)
                  self.present(alert, animated: true, completion: nil)
                return
              }else{
                  print("veri3="+verificationID! as Any)
                  appData.set(verificationID, forKey: "authVerificationID")
                  Static.veriId = verificationID!
              }
              
          }
        
        seconds = 180
        runTimer()
    }
    
    @IBAction func btnNextClick(_ sender: Any) {
        
        if txtFPhoneNumber.text != "" {
            
//            verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
            
            print("veri2A="+appData.string(forKey: "authVerificationID")!)
            print("veri2S="+Static.veriId)
            print("ver2=" + verificationID!)
            
            let credential = PhoneAuthProvider.provider().credential(
                withVerificationID: Static.veriId ,
                verificationCode: txtFPhoneNumber.text!)
                
            Auth.auth().signIn(with: credential) { (authResult, error) in
              if let error = error {
                 print("ㅜㅜㅜㅜㅜㅜㅜ",error.localizedDescription)
                  
                  let alert = UIAlertController(title: "인증번호 오류", message: "인증번호가 틀립니다. 다시 인증해 주세요.", preferredStyle: .alert)
                  
                  let OKAction = UIAlertAction(title: "확인", style: .default) { [self]
                      (action:UIAlertAction!) in
                      // Code in this block will trigger when OK button tapped.
                      txtFPhoneNumber.text = ""
                      seconds = 180
                      timer.invalidate()
                      runTimer()
                      self.txtFPhoneNumber.becomeFirstResponder()
                      }

                  // add an action (button)                                            
                  alert.addAction(OKAction)
                    // show the alert
                  self.present(alert, animated: true, completion: nil)
              } else {
                  print(authResult?.user as Any)
                  self.performSegue(withIdentifier: "myInfoSet", sender: self)
              }
            }
            
        }else{
            let alert = UIAlertController(title: "필수 입력", message: "인증번호를 입력해 주세요.", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "확인", style: .default) { [self]
                (action:UIAlertAction!) in
                // Code in this block will trigger when OK button tapped.
                txtFPhoneNumber.text = ""
                seconds = 180
                runTimer()
                self.txtFPhoneNumber.becomeFirstResponder()
                }

            // add an action (button)
            alert.addAction(OKAction)

            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func backButtonPressed(sender: UIBarButtonItem) {
        
        self.presentingViewController?.dismiss(animated: true, completion:nil)
    }
}
