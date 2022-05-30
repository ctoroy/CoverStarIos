//
//  MainViewController.swift
//  CoverStar
//
//  Created by taehan park on 2022/04/01.
//

import UIKit

class IntroViewController: UIViewController {
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnJoin: UIButton!
    
    override func viewDidLoad() {
        Static.userId = appData.string(forKey: "userID")!
        Static.userPwd = appData.string(forKey: "userPwd")!
        
        let upw = appData.string(forKey: "userPw")!
        
        print("appData.string(forKey: userPw)=" + appData.string(forKey: "userPw")!)
        print("Static.userPwd=" + Static.userPwd)

        print("upw:" + upw)
        
        if Static.userId != "" {
            
            print("User Id:" + Static.userId)
            
            popupManager.showLoadingView()
            
            httpTool.login(userID: Static.userId, userPw: upw) { (succeed, resultInfo) in
            
                popupManager.hideLoadingView()
            
                if succeed {
                    dispatchMain.async {
                        self.performSegue(withIdentifier: "homeToMain", sender: self)
                    }
                }
            }
        }
    }
        
    @IBAction func btnLogin_Click(_ sender: AnyObject) {
        let uid:String = appData.string(forKey: "userId")!
        if(uid == ""){
            performSegue(withIdentifier: "loginFirst", sender: self)
        }else{
            performSegue(withIdentifier: "login", sender: self)
        }
    }
    
    @IBAction func btnJoin_Click(_ sender: AnyObject) {
        performSegue(withIdentifier: "join", sender: self)
    }
}
