//
//  UIButton.swift
//  CellTest
//
//  Created by 김종권 on 2020/11/28.
//

import Foundation
import UIKit

public extension UIButton {
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        context.setFillColor(color.cgColor)
        context.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))

        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        self.setBackgroundImage(backgroundImage, for: state)
    }
    
    func allowTextToScale(minFontScale: CGFloat = 0.5, numberOfLines: Int = 1)

    {
    self.titleLabel?.adjustsFontSizeToFitWidth = true

    self.titleLabel?.minimumScaleFactor = minFontScale

    self.titleLabel?.lineBreakMode = .byTruncatingTail

    // Caution! The above causes numberOfLines to become 1,

    // so this next line must be AFTER that one.

    self.titleLabel?.numberOfLines = numberOfLines

    }
    
    func setDynamicFontSize() {
            NotificationCenter.default.addObserver(self, selector: #selector(setButtonDynamicFontSize),
                                                   name: UIContentSizeCategory.didChangeNotification,
                                                   object: nil)
        }
        
    @objc func setButtonDynamicFontSize() {
        setButtonTextSizeDynamic(button: self, textStyle: .callout)
    }
    
    func setButtonTextSizeDynamic(button: UIButton, textStyle: UIFont.TextStyle) {
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: textStyle)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
    }
}


