//
//  ThreeBtnInputPopupView.swift
//  PopkonAir
//
//  Created by Steven on 11/11/2016.
//  Copyright © 2016 roy. All rights reserved.
//

import UIKit

class ThreeBtnInputPopupView: AlertPopupView {

    private let defaulLabeltHeight = 20
    private let defualtViewHeight = 129
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var inputTextField: OneLineTextField!
    
    @IBOutlet var buttons: [UIButton]!
    
    var buttonActions : [(_ text : String)->Void] = []
    
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    //MARK: - Class Func
    override class func instanceFromNib() -> ThreeBtnInputPopupView {
        return (Bundle.main.loadNibNamed("ThreeBtnInputPopupView", owner: self, options: nil)![0] as? ThreeBtnInputPopupView)!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        inputTextField.lineColor.normal = UIColor.colorWithRGBHexString("#e2e2e2")
        inputTextField.lineMargin = 0
        
    }
    
    //MARK: - UI Setup
    override func setup(content:String ,buttonTitles : [String] = []) {
        
        self.titleLabel.text = content
        
    
        for i in 0..<2 {
            buttons[i].setTitle(buttonTitles[i], for: .normal)
        }
        
    }
    
    func setButtonActions(actions : [(_ text : String)->Void]) {
        buttonActions = actions
    }
    
    //MARK: - IBActions
    @IBAction func button1Action(_ sender: AnyObject) {
        self.hide()
        if self.buttonActions.count > 0 {
            self.buttonActions[0](inputTextField.text!)
        }
    }
    @IBAction func button2Action(_ sender: AnyObject) {
        self.hide()
        if self.buttonActions.count > 1 {
            self.buttonActions[1](inputTextField.text!)
        }
    }
    
    @IBAction func button3Action(_ sender: AnyObject) {
        self.hide()
        if self.buttonActions.count > 2 {
            self.buttonActions[2](inputTextField.text!)
        }
    }

}

extension ThreeBtnInputPopupView : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
}
