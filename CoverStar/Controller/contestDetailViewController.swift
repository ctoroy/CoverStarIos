//
//  contestDetail.swift
//  CoverStar
//
//  Created by taehan park on 2022/06/06.
//

import UIKit

class contestDetailViewController:UIViewController {
    
    @IBOutlet weak var naviItem: UINavigationItem!
    @IBOutlet weak var imgThumbnail: UIImageView!
    @IBOutlet weak var bbtnLeft: UIBarButtonItem!
    @IBOutlet weak var lblVote: UILabel!
    @IBOutlet weak var imgVote: UIImageView!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var btnVote: UIButton!
    //    @IBOutlet weak var bbtnRight: UIBarButtonItem!
    
    override func viewDidLoad() {
        bbtnLeft.action = #selector(backButtonPressed(sender:))
        btnVote.layer.cornerRadius = 5;
        btnVote.layer.borderWidth = 1;
        btnVote.layer.borderColor = UIColor(named: "anychat_pink")?.cgColor
        
    }
    
    @objc func backButtonPressed(sender: UIBarButtonItem) {
        self.presentingViewController?.dismiss(animated: true, completion:nil)
    }
}
