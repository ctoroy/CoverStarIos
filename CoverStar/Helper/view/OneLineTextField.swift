//
//  OneLineTextField.swift
//  PopkonAir
//
//  Created by Steven on 27/10/2016.
//  Copyright © 2016 roy. All rights reserved.
//

import UIKit


struct LineColor {
    var normal: UIColor = UIColor.colorWithRGBHexString("#c9a617")
    var edit : UIColor = UIColor.colorWithRGBHexString("#fa377c")
}

class OneLineTextField: UITextField {
    
    
    var lineColor : LineColor = LineColor()
    @IBInspectable var lineMargin : CGFloat = 10  {
        didSet {
            self.layoutSubviews()
        }
    }
    
    @IBInspectable var lineWidth : CGFloat = 2
    
    fileprivate var bottomBorder = CALayer()
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        bottomBorder.borderColor = lineColor.normal.cgColor
        bottomBorder.borderWidth = lineWidth
        bottomBorder.frame = CGRect(x: -lineMargin, y: self.bounds.height - lineWidth, width: self.bounds.width+lineMargin*2, height: bottomBorder.borderWidth)
        
        if bottomBorder.superlayer == nil {
            self.layer.addSublayer(bottomBorder)
        }
        
        self.clipsToBounds = false
        self.layer.masksToBounds = false
        
        //Cursor Color
        self.tintColor = lineColor.edit
    
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if bottomBorder.superlayer != nil {
            bottomBorder.frame = CGRect(x: -lineMargin, y: self.bounds.height - 2, width: self.bounds.width+lineMargin*2, height: bottomBorder.borderWidth)
            bottomBorder.borderColor = self.isEditing ? lineColor.edit.cgColor : lineColor.normal.cgColor
        }
    }
    
    

}
