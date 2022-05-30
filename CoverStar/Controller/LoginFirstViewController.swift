//
//  LoginFirstViewController.swift
//  CoverStar
//
//  Created by taehan park on 2022/04/14.
//

import UIKit
import DialCountries

class LoginFirstViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var bBtnLeftItem: UIBarButtonItem!
    @IBOutlet weak var txtFPhoneNumber: UITextField!
    @IBOutlet weak var btnCountrySelect: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    var userId:String = ""
    var cnNumber = ""
    
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

        @IBAction func btnNextClick(_ sender: UIButton) {
            
            let id = txtFPhoneNumber.text!.replacingOccurrences(of: " ", with: "")
            userId = id
            
            if id.isEmpty {
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
                self.performSegue(withIdentifier: "passwdAuth", sender: nil)
            }
        }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let vc = segue.destination as? PasswdAuthViewController {
                vc.userId = cnNumber.replace("+", "") + userId
            }
        }
        
        @objc func backButtonPressed(sender: UIBarButtonItem) {
        
        self.presentingViewController?.dismiss(animated: true, completion:nil)
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

    extension LoginFirstViewController: DialCountriesControllerDelegate {
        func didSelected(with country: Country) {
            var innerText:String = ""
            innerText = country.name + "(" + country.code + ")" + country.dialCode!
            print(innerText)
            cnNumber = country.dialCode!
            btnCountrySelect.setTitle(innerText, for: .normal)
            txtFPhoneNumber.resignFirstResponder()
        }
    }
