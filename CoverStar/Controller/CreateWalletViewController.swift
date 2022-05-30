//
//  CreateWalletViewController.swift
//  CoverStar
//
//  Created by taehan park on 2022/04/18.
//

import UIKit

class CreateWalletViewController: UIViewController {
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var bBtnBack: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bBtnBack.action = #selector(backButtonPressed(sender:))
        
    }
    
    @IBAction func btnNextClick(_ sender: UIButton) {
        self.performSegue(withIdentifier: "setCoinPwd", sender: nil)
    }
    
    
    @objc func backButtonPressed(sender: UIBarButtonItem) {
    
    self.presentingViewController?.dismiss(animated: true, completion:nil)
    }
}
