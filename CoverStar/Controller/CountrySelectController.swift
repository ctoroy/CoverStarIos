//
//  CountrySelectController.swift
//  CoverStar
//
//  Created by taehan park on 2022/04/05.
//

import UIKit
import DialCountries
import FirebaseAuth

class CountrySelectController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var btnSMSSend: UIButton!
    @IBOutlet weak var bBtnLeftItem: UIBarButtonItem!
    @IBOutlet weak var txtFPhoneNumber: UITextField!
    @IBOutlet weak var btnCountrySelect: UIButton!
    
    var cDCode = ""
    
    var userId:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
                view.addGestureRecognizer(tap)
        
        bBtnLeftItem.action = #selector(backButtonPressed(sender:))
        
        btnCountrySelect.contentHorizontalAlignment = .left
        
        txtFPhoneNumber.delegate = self
        
        txtFPhoneNumber.borderStyle = .none
                let border = CALayer()
                border.frame = CGRect(x: 0, y: txtFPhoneNumber.frame.size.height-1, width: txtFPhoneNumber.frame.width, height: 1)
        border.backgroundColor = UIColor.black.cgColor
        txtFPhoneNumber.layer.addSublayer((border))
        txtFPhoneNumber.keyboardType = .numberPad
        
        txtFPhoneNumber.addDoneButtonToKeyboard(myAction:  #selector(self.txtFPhoneNumber.resignFirstResponder))
        
        self.btnCtn()
        
        self.txtFPhoneNumber.becomeFirstResponder()
    }
    
    @objc func backButtonPressed(sender: UIBarButtonItem) {
        
        self.presentingViewController?.dismiss(animated: true, completion:nil)
    }
    
    @IBAction func btnSMSSendClick(_ sender: Any) {
        if(txtFPhoneNumber.text == ""){
            // create the alert
            let alert = UIAlertController(title: "필수 입력", message: "휴대폰 번호를 입력하셔야 합니다.", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "확인", style: .default) { [self]
                (action:UIAlertAction!) in
                // Code in this block will trigger when OK button tapped.
                print("Ok button tapped");
                self.txtFPhoneNumber.becomeFirstResponder()
                }

            // add an action (button)
            alert.addAction(OKAction)

            // show the alert
            self.present(alert, animated: true, completion: nil)
            
            
        }else{
            
            var cXcode = ""
            var phoneNumber = ""
            
            let localeID = Locale.preferredLanguages.first
            let deviceLocale = (Locale(identifier: localeID!).regionCode)!
            
            Static.countryCode = deviceLocale
            print("Static.countryCode="+Static.countryCode)
            Static.countryNo = cDCode.replace("+", "")
            print("Static.countryNo="+Static.countryNo)
            
            if cDCode != "" {
                cXcode = cDCode
                phoneNumber = cXcode + txtFPhoneNumber.text!
                Static.userId = phoneNumber
                Static.userPhoneNumber = phoneNumber.replace("+", "")
            }else{
                
                cXcode = Common.getCountryPhonceCode(deviceLocale)
                phoneNumber = "+" + cXcode + txtFPhoneNumber.text!
                Static.userId = phoneNumber
                Static.userPhoneNumber = phoneNumber.replace("+", "")
            }
            
            print("Ok button tapped:" + phoneNumber)
            
            PhoneAuthProvider.provider()
              .verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
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
                      print("veri1="+verificationID! as Any)
                      appData.set(verificationID, forKey: "authVerificationID")
                      print("veri1A="+appData.string(forKey: "authVerificationID")!)
                      Static.veriId = verificationID!
                      print("veri1S="+Static.veriId)
                      self.performSegue(withIdentifier: "authComplete", sender: self)
                  }
              }
        }
    }
    
    @IBAction func btnCountrySelectClick(_ sender: Any) {
        self.btnCtn()
    }
    
    func btnCtn(){
        let localeID = Locale.preferredLanguages.first
        let deviceLocale = (Locale(identifier: localeID!).languageCode)!
        
        print("deviceLocale:" + deviceLocale)
        
            DispatchQueue.main.async {
                let cv = DialCountriesController(locale: Locale(identifier: deviceLocale))
                cv.delegate = self
                cv.show(vc: self)
            }
    }
}
    
    

extension CountrySelectController: DialCountriesControllerDelegate {
    func didSelected(with country: Country) {
        var innerText:String = ""
        cDCode = country.dialCode!
        innerText = country.name + "(" + country.code + ")" + country.dialCode!
        print(innerText)
        btnCountrySelect.setTitle(innerText, for: .normal)
    }
}
