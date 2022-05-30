//
//  MainViewController.swift
//  CoverStar
//
//  Created by taehan park on 2022/04/19.
//

import UIKit

class NoticeViewController: UIViewController {
    
    @IBOutlet weak var bBtnBack: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bBtnBack.action = #selector(backButtonPressed(sender:))
    }
    
    @objc func backButtonPressed(sender: UIBarButtonItem) {
        self.presentingViewController?.dismiss(animated: true, completion:nil)
    }
}
