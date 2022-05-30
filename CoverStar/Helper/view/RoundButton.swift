//
//  RoundButton.swift
//  PopkonAir
//
//  Created by Steven on 25/10/2016.
//  Copyright © 2016 roy. All rights reserved.
//

import UIKit

class RoundButton: UIButton {

//    @IBInspectable private(set) public var borderColor : UIColor = UIColor.black
    //*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
//        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
        self.layer.masksToBounds = true
    }
    //*/

//    func setBorder(with color : UIColor) {
//        borderColor = color
//        
////        self.layer.borderColor = borderColor.cgColor
//    }
    
}
