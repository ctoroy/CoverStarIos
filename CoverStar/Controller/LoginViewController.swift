//
//  LoginViewController.swift
//  CoverStar
//
//  Created by taehan park on 2022/04/01.
//

import UIKit
import DialCountries

class LoginViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var ivIcon: UIImageView!
    @IBOutlet weak var btnCountrySelect: UIButton!
    @IBOutlet weak var bBtnLeftItem: UIBarButtonItem!
    @IBOutlet weak var lblWelcome: UILabel!
    @IBOutlet weak var txtFPhoneNumber: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    
    let obj = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
                view.addGestureRecognizer(tap)

        
        let userName:String = obj.string(forKey: "userName")!
        
        if(userName != ""){
            lblWelcome.text = userName + lblWelcome.text!
        }
        
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
        
        self.txtFPhoneNumber.becomeFirstResponder()
        
        let url = URL(string: "https://d3fq0wmt9zn6f5.cloudfront.net/roy.jpg")
        do
        { let data = try Data(contentsOf: url!)
            ivIcon.image = UIImage(data: data)
        } catch {}
    }
    
    func finalChk(){
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
            performSegue(withIdentifier: "loginPwdCheck", sender: self)
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == txtFPhoneNumber {
//        finalChk()
        }

        return true
    }
    
    @IBAction func btnCountrySelectClick(_ sender: Any) {
     
        let localeID = Locale.preferredLanguages.first
        let deviceLocale = (Locale(identifier: localeID!).languageCode)!
        
        print("deviceLocale:" + deviceLocale)
        
            DispatchQueue.main.async {
                
                let cv = DialCountriesController(locale: Locale(identifier: deviceLocale))
                cv.delegate = self
                cv.show(vc: self)
            }
    }
    
    @IBAction func btnNextClick(_ sender: Any) {
        finalChk()
    }
    
    @objc func backButtonPressed(sender: UIBarButtonItem) {
        
        self.presentingViewController?.dismiss(animated: true, completion:nil)
    }
}

extension LoginViewController: DialCountriesControllerDelegate {
    func didSelected(with country: Country) {
        var innerText:String = ""
        innerText = country.name + "(" + country.code + ")" + country.dialCode!
        print(innerText)
        btnCountrySelect.setTitle(innerText, for: .normal)
    }
}
