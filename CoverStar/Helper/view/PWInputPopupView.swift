//
//  PWInputPopupView.swift
//  PopkonAir
//
//  Created by Steven on 04/11/2016.
//  Copyright © 2016 roy. All rights reserved.
//

import UIKit

class PWInputPopupView: AlertPopupView {

    private let defaulLabeltHeight = 20
    private let defualtViewHeight = 129
    
    @IBOutlet weak var inputTextField: OneLineTextField!
    
    var buttonActions : [(_ text : String)->Void] = []

    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    //MARK: - Class Func
    override class func instanceFromNib() -> PWInputPopupView {
        return (Bundle.main.loadNibNamed("PWInputPopupView", owner: self, options: nil)![0] as? PWInputPopupView)!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        inputTextField.lineColor.normal = UIColor.colorWithRGBHexString("#fa377c")
        inputTextField.lineMargin = 0

    }
    
    override func updateFrame() {
        
        let size = self.contentLabel.sizeThatFits(CGSize(width: defaultWidth-16, height: 400))
        
        //Update Frame
        var heightChanged = max(0, Int(size.height) - defaulLabeltHeight)
        //check if is over max height size
        heightChanged = min(Int(UIScreen.main.bounds.height - 128) - defualtViewHeight, heightChanged)
        
        if defualtViewHeight + heightChanged != Int(self.frame.height) {
            let newFrame = CGRect(x: 0, y: 0, width: Int(defaultWidth), height: defualtViewHeight + heightChanged + 10)
            self.frame = newFrame
        }
    }
    
    func setButtonActions(actions : [(_ text : String)->Void]) {
        buttonActions = actions
    }
    
    //MARK: - IBActions
    @IBAction override func cancelAction(_ sender: AnyObject) {
        self.hide()
        if self.buttonActions.count > 1 {
            self.buttonActions[1](inputTextField.text!)
        }
    }
    @IBAction override func okAction(_ sender: AnyObject) {
        self.hide()
        if self.buttonActions.count > 0 {
            self.buttonActions[0](inputTextField.text!)
        }
    }

}

extension PWInputPopupView : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.hide()
        if self.buttonActions.count > 0 {
            self.buttonActions[0](inputTextField.text!)
        }
        return true
    }
}
