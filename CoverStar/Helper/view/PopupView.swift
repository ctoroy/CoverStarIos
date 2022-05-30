//
//  PopupView.swift
//  PopkonAir
//
//  Created by Steven on 21/10/2016.
//  Copyright © 2016 roy. All rights reserved.
//

import UIKit

class PopupView: UIView {


}

//MARK: - Show & Hide
extension PopupView {
    func showInView(parentView : UIView) {
        self.alpha = 0
        parentView.addSubview(self)
        UIView.animate(withDuration: 0.25) {
            self.alpha = 1
        }
    }
    
    func hide() {
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 0
        }) { (finished) in
            self.alpha = 1
            self.removeFromSuperview()
        }
    }
}
