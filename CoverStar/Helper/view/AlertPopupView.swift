//
//  AlertPopupView.swift
//  PopkonAir
//
//  Created by Steven on 24/10/2016.
//  Copyright © 2016 roy. All rights reserved.
//

import UIKit

class AlertPopupView: PopupView {

    let defaultWidth = UIScreen.main.bounds.width - 40
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    ///ContentLabel Default Height
    private let defaulLabeltHeight = 20
    private let defualtViewHeight = 98
    
    private var buttonTitles : [String] = []
    private var buttonActions : [()->Void] = []
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet private weak var okButton: UIButton!
    @IBOutlet private weak var cancelButton: UIButton!
    
    //MARK: - Class Func
    class func instanceFromNib() -> AlertPopupView {
        return (Bundle.main.loadNibNamed("AlertPopupView", owner: self, options: nil)![0] as? AlertPopupView)!
    }
    
    //MARK: - UI Setup
    func setup(content:String ,buttonTitles : [String] = []) {
    
        self.contentLabel.text = content

        
        if buttonTitles.count == 0 {
            self.buttonTitles = ["확인"]
        }else {
            self.buttonTitles = buttonTitles
        }
        
        for i in 0...1 {
            
            if i == 0 {
                self.okButton.setTitle(self.buttonTitles[i], for: .normal)
            }else if i == 1 {
                if self.buttonTitles.count>1 {
                    self.cancelButton.setTitle(self.buttonTitles[i], for: .normal)
                }else {
                    self.cancelButton.isHidden = true
                }
            }
        }
        
        
        self.updateFrame()
        
    }
    
    func updateFrame() {
        
        let size = self.contentLabel.sizeThatFits(CGSize(width: defaultWidth-16, height: 400))
        
        //Update Frame
        //get label height changed
        var heightChanged = max(0, Int(size.height) - defaulLabeltHeight)
        //check if is over max height size
        heightChanged = min(Int(UIScreen.main.bounds.height - 128) - defualtViewHeight, heightChanged)
        
        if defualtViewHeight + heightChanged != Int(self.frame.height) {
            let newFrame = CGRect(x: 0, y: 0, width: Int(defaultWidth), height: defualtViewHeight + heightChanged + 10)
            self.frame = newFrame
        }
    }
    
    func setButtonTitles(titles : [String]) {
        if titles.count == 0 {
            buttonTitles = ["확인"]
        }else {
            buttonTitles = titles
        }
        
        okButton.setTitle(buttonTitles[0], for: .normal)
        
        if buttonTitles.count == 1 {
            cancelButton.isHidden = true
        }else {
            cancelButton.isHidden = false
            cancelButton.setTitle(buttonTitles[1], for: .normal)
        }
    }
    func setButtonActions(actions : [()->Void]) {
        buttonActions = actions
    }
    
    //MARK: - IBActions
    @IBAction func cancelAction(_ sender: AnyObject) {
        self.hide()
        if self.buttonActions.count > 1 {
            self.buttonActions[1]()
        }
    }
    @IBAction func okAction(_ sender: AnyObject) {
        self.hide()
        if self.buttonActions.count > 0 {
            self.buttonActions[0]()
        }
    }
    

}
