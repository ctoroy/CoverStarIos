//
//  myInfoChangeViewController.swift
//  CoverStar
//
//  Created by taehan park on 2022/05/30.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class myInfoChangeViewCOntroller: BaseViewController {
    
    @IBOutlet weak var bBtnBack: UIBarButtonItem!
    @IBOutlet weak var txtNickName: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var btnImageSet: UIButton!
    
    private func downloadImage(with urlString: String) {
      guard let url = URL(string: urlString) else { return }
      let resource = ImageResource(downloadURL: url)
      KingfisherManager.shared.retrieveImage(with: resource,
                                             options: nil,
                                             progressBlock: nil) { result in
        switch result {
        case .success(let value):
          print(value.image)
        case .failure(let error):
          print("Error: \(error)")
        }
      }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("userId="+Static.userId.replace("+", ""))
        print("countryCode="+Static.countryCode)
        print("countryNo="+Static.countryNo)
        print("phoneNumber="+Static.userId.replace("+", ""))
        
        DispatchQueue.main.async {
            
            self.imgProfile.kf.setImage(with: URL(string: Static.userProfileImage), placeholder: nil, options: nil, progressBlock: nil, completionHandler: { result in
                switch result {
                    case .success(let value):
                                print("Image: \(value.image). Got from: \(value.cacheType)")
                    self.imgProfile.image = value.image.cropToCircle()
                    case .failure(let error):
                                print("Error: \(error)")
                    }
                })
        }
        
        txtNickName.text = Static.userName
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
                view.addGestureRecognizer(tap)
        
        txtNickName.borderStyle = .none
                let border = CALayer()
                border.frame = CGRect(x: 0, y: txtNickName.frame.size.height-1, width: txtNickName.frame.width, height: 1)
        border.backgroundColor = UIColor.black.cgColor
        txtNickName.layer.addSublayer((border))
        
        txtNickName.addDoneButtonToKeyboard(myAction:  #selector(self.txtNickName.resignFirstResponder))
       
        
        bBtnBack.action = #selector(backButtonPressed(sender:))
        
    }
    
    @objc func backButtonPressed(sender: UIBarButtonItem) {
        self.presentingViewController?.dismiss(animated: true, completion:nil)
    }
    
    @IBAction func btnNextClick(_ sender: UIButton) {
        if txtNickName.text == "" {
            let alert = UIAlertController(title: "?????? ??????", message: "???????????? ????????? ????????? ?????????.", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "??????", style: .default) { [self]
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
            
            popupManager.showLoadingView()
            
            httpTool.updateUserProfile(userProfileImage: Static.userProfileImage, nickName: Static.userName, userId: Static.userId) { (succeed, resultInfo) in
            
                popupManager.hideLoadingView()
            
                if succeed {
                    dispatchMain.async {
                        let alert = UIAlertController(title: "?????? ??????", message: "????????? ?????? ???????????????.", preferredStyle: .alert)
                        
                        let OKAction = UIAlertAction(title: "??????", style: .default) {
                            (action:UIAlertAction!) in
                            // Code in this block will trigger when OK button tapped.
                            self.presentingViewController?.dismiss(animated: true, completion:nil)
                            }

                        // add an action (button)
                        alert.addAction(OKAction)

                        // show the alert
                        self.present(alert, animated: true, completion: nil)
                    }
                }else{
                        let alert = UIAlertController(title: "?????? ??????", message: "????????? ?????? ???????????????. ?????? ????????? ????????? ????????????.", preferredStyle: .alert)
                        
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
}

