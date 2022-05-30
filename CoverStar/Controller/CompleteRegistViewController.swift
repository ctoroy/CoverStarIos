//
//  CompleteRegistViewController.swift
//  CoverStar
//
//  Created by taehan park on 2022/04/19.
//

import UIKit

class CompleteRegistViewController: UIViewController {
    
    @IBOutlet weak var lblReward: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblReward.text = "매월 상금 1,000만원! 12월 파이널 무대 총상금 10억!"
    }
    
    @IBAction func btnNextClick(_ sender: Any) {
        //registToMain
        performSegue(withIdentifier: "registToMain", sender: self)
    }
    
}
