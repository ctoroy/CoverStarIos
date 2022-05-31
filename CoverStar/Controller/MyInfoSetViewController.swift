//
//  MyInfoSetViewController.swift
//  CoverStar
//
//  Created by taehan park on 2022/04/17.
//

import UIKit
import Alamofire
import SwiftyJSON

class MyInfoSetViewCOntroller: BaseViewController {
    
    @IBOutlet weak var bBtnBack: UIBarButtonItem!
    @IBOutlet weak var txtNickName: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var btnImageSet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("userId="+Static.userId.replace("+", ""))
        print("countryCode="+Static.countryCode)
        print("countryNo="+Static.countryNo)
        print("phoneNumber="+Static.userId.replace("+", ""))
        
        imgProfile.layer.cornerRadius = imgProfile.frame.height/2
        imgProfile.layer.borderWidth = 1
        imgProfile.layer.borderColor = UIColor.clear.cgColor
        // 뷰의 경계에 맞춰준다
        imgProfile.clipsToBounds = true
        
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
                view.addGestureRecognizer(tap)
        
        txtNickName.borderStyle = .none
                let border = CALayer()
                border.frame = CGRect(x: 0, y: txtNickName.frame.size.height-1, width: txtNickName.frame.width, height: 1)
        border.backgroundColor = UIColor.black.cgColor
        txtNickName.layer.addSublayer((border))
        
        txtNickName.addDoneButtonToKeyboard(myAction:  #selector(self.txtNickName.resignFirstResponder))
        self.txtNickName.becomeFirstResponder()
        
        bBtnBack.action = #selector(backButtonPressed(sender:))
    }
    
    @objc func backButtonPressed(sender: UIBarButtonItem) {
        self.presentingViewController?.dismiss(animated: true, completion:nil)
    }
    
    @IBAction func btnNextClick(_ sender: UIButton) {
        if txtNickName.text == "" {
            let alert = UIAlertController(title: "필수 입력", message: "닉네임을 입력해 주셔야 합니다.", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "확인", style: .default) { [self]
                (action:UIAlertAction!) in
                // Code in this block will trigger when OK button tapped.
                
                self.txtNickName.becomeFirstResponder()
                }

            // add an action (button)
            alert.addAction(OKAction)

            // show the alert
            self.present(alert, animated: true, completion: nil)
        }else{
            Static.userName = txtNickName.text!
            self.performSegue(withIdentifier: "refferCode", sender: nil)
        }
        
    }
    
    @IBAction func setImage(_ sender: Any) {
        self.showSelectImageActionSheet { (image) in

            self.imgProfile.image = image?.cropToCircle()
            let imageData = (self.imgProfile.image?.jpegData(compressionQuality: 0.8))!
            
            Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "imgFile", fileName: Static.userId.replace("+", "") + ".jpg", mimeType: "image/jpg")
            },usingThreshold: UInt64.init()
            ,to: Static.apiUrl + "common/uploadImage"
            ,method: .post){ (result) in
                        switch result {
                        case .success(let upload, _, _):
                            upload.uploadProgress(closure: { (progress) in
                                print("Upload Progress: \(progress.fractionCompleted)")
                            })

                            upload.responseString { response in
                                print("Success")
                                print(response)
                                
                                let resultString = NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue)! as String
                                let json = JSON(resultString.data(using: .utf8)!)
                                Static.userProfileImage = json["data"]["imgUrl"].stringValue
                                print(Static.userProfileImage)
                            }

                        case .failure(let encodingError):
                            print("Error")
                            print(encodingError)
                        }
                    }
                }
    }
    
    func documentDirectoryPath() -> URL? {
        let path = FileManager.default.urls(for: .documentDirectory,
                                            in: .userDomainMask)
        return path.first
    }
    
    func savePng(_ image: UIImage) {
        if let pngData = image.pngData(),
           let path = documentDirectoryPath()?.appendingPathComponent(Static.userId + ".png") {
            print("path=\(path)")
            try? pngData.write(to: path)
        }
    }
}
