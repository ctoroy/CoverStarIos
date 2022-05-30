//
//  UITextField.swift
//  CoverStar
//
//  Created by taehan park on 2022/04/21.
//

import Foundation
import UIKit

public extension UITextField{

func addDoneButtonToKeyboard(myAction:Selector?){
    let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
    doneToolbar.barStyle = UIBarStyle.default

    let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    let done: UIBarButtonItem = UIBarButtonItem(title: "확인", style: UIBarButtonItem.Style.done, target: self, action: myAction)
    done.tintColor = UIColor(named: "anychat_pink")

    var items = [UIBarButtonItem]()
    items.append(flexSpace)
    items.append(done)

    doneToolbar.items = items
    doneToolbar.sizeToFit()

    self.inputAccessoryView = doneToolbar
 }
}
