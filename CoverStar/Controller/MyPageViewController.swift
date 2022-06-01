//
//  MyPageViewController.swift
//  CoverStar
//
//  Created by taehan park on 2022/05/29.
//

import UIKit
import Kingfisher

class MyPaegViewViewController: UIViewController {
    
    @IBOutlet weak var lblMyName: UILabel!
    @IBOutlet weak var imgMyFace: UIImageView!
    @IBOutlet weak var lblStar: UILabel!
    @IBOutlet weak var btnDeposit: UIButton!
    @IBOutlet weak var bBtnSetting: UIBarButtonItem!
    @IBOutlet weak var bBtnMessage: UIBarButtonItem!
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            print("Static.userProfileImage=" + Static.userProfileImage)
            guard let url = URL(string: Static.userProfileImage) else { return }
            
            self.imgMyFace.layer.cornerRadius = self.imgMyFace.frame.height/2
            self.imgMyFace.layer.masksToBounds = false
            self.imgMyFace.layer.borderWidth = 1
            self.imgMyFace.layer.borderColor = UIColor.clear.cgColor
            // 뷰의 경계에 맞춰준다
            self.imgMyFace.clipsToBounds = true
            
            let cornerImageProcessor = RoundCornerImageProcessor(cornerRadius: 30)
            self.imgMyFace.kf.indicatorType = .activity
            self.imgMyFace.kf.setImage(
              with: url,
              placeholder: nil,
              options: [
                .transition(.fade(1.2)),
                .forceTransition,
                .processor(cornerImageProcessor)
              ],
              completionHandler: nil)
            
            self.lblMyName.text = Static.userName
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bBtnSetting.action = #selector(settingButtonPressed(sender:))
    }
    
    @objc func settingButtonPressed(sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "myToSetting", sender: nil)
    }
}
