//
//  BlurView.swift
//  PopkonAir
//
//  Created by Steven on 24/10/2016.
//  Copyright © 2016 roy. All rights reserved.
//

import UIKit


class BlurView: UIView {

    let blurViewAlpha : CGFloat = 0.5
    
    /*네
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    class func standard() -> BlurView {
        
        let blurView = BlurView(frame: UIScreen.main.bounds)
        blurView.backgroundColor = UIColor.black
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        
        return blurView
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = UIScreen.main.bounds
    }
}

//MARK: - Show & Hide
extension BlurView {
    
    func showInView(parentView : UIView) {

        if self.superview == nil {
            
            self.frame = UIScreen.main.bounds
            self.alpha = 0
            
            parentView.addSubview(self)
            
            UIView.animate(withDuration: 0.25) {
                self.alpha = self.blurViewAlpha
            }
        }
        
    }
    
    func hide() {
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 0
        }) { (finished) in
            self.alpha = self.blurViewAlpha
            self.removeFromSuperview()
        }
    }
}
