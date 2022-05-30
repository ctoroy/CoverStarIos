//
//  TitleAndPwInputPopupView.swift
//  Celuv
//
//  Created by Steven on 23/01/2017.
//  Copyright © 2017 roy. All rights reserved.
//

import UIKit

class TitleAndPwInputPopupView: PopupView {

    private let defualtViewSize = CGSize(width: 280, height: 190)
    
    @IBOutlet var contView: UIView!
    
    @IBOutlet weak var titleTextField: OneLineTextField!
    @IBOutlet weak var pwTextField: OneLineTextField!
    
    var onOkAction : (_ title : String, _ pw : String?)->Void = {title , pw in}
    var onCancelAction : ()->Void = {}
    
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    //MARK: - Class Func

    override init(frame: CGRect) {
        super.init(frame: frame)
        initFromXIB()
    }
    
    init() {
        super.init(frame: CGRect(origin: CGPoint.zero, size: defualtViewSize))
        
        initFromXIB()
        self.frame = CGRect(origin: CGPoint.zero, size: defualtViewSize)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initFromXIB()
        
        self.frame = CGRect(origin: CGPoint.zero, size: defualtViewSize)
    }
    
    private func initFromXIB() {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "TitleAndPwInputPopupView", bundle: bundle)
        contView = nib.instantiate(withOwner: self, options: nil)[0] as? UIView
        contView.frame = bounds
        contView.autoresizingMask = [.flexibleBottomMargin,.flexibleHeight,.flexibleLeftMargin,.flexibleRightMargin,.flexibleTopMargin,.flexibleWidth]
        
        self.addSubview(contView)
        
        titleTextField.lineColor.normal = #colorLiteral(red: 0.9803921569, green: 0.2156862745, blue: 0.4862745098, alpha: 1)
        pwTextField.lineColor.normal = #colorLiteral(red: 0.9803921569, green: 0.2156862745, blue: 0.4862745098, alpha: 1)
        titleTextField.lineMargin = 0
        pwTextField.lineMargin = 0
    }

    
    //MARK: - IBActions
    @IBAction func cancelAction(_ sender: AnyObject) {
        self.hide()
        onCancelAction()
    }
    @IBAction func okAction(_ sender: AnyObject) {
        self.hide()
        
        onOkAction(titleTextField.text!, pwTextField.text)
    }

}
