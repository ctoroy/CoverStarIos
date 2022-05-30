//
//  searchViewController.swift
//  CoverStar
//
//  Created by taehan park on 2022/05/29.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var bBtnBack: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bBtnBack.action = #selector(backButtonPressed(sender:))
    }
    
    @objc func backButtonPressed(sender: UIBarButtonItem) {
        self.presentingViewController?.dismiss(animated: true, completion:nil)
    }
}
