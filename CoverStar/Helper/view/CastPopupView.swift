//
//  CastPopupView.swift
//  PopkonAir
//
//  Created by Steven on 21/10/2016.
//  Copyright © 2016 roy. All rights reserved.
//

import UIKit

struct ButtonAction {
    var ok      : ()->Void = {}
    var cancel  : ()->Void = {}
}

class CastPopupView: PopupView {
    
    ///ContentLabel Default Height
    private let defaultHeight = 24

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var pwTextFiled: OneLineTextField!
    
    @IBOutlet weak var okButton: RoundButton!
    @IBOutlet weak var cancelButton: RoundButton!
    
    
    var buttonAction : ButtonAction = ButtonAction()
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    let contentText = "방송을 시청하시기 전 아래의 내용을 반드시 확인하시기 바랍니다.\n\n1. 본 정보내용은 청소년에게 유해한 정보를 포함하고 있어 정보통신망 이용촉진 및 정보보호등에 관한 법률 및 청소년 보호법의 규정에 의하여 만 19세 미만의 청소년이 이용할 수 없습니다.\n\n2. 방송을 시청하면서 불법 유해정보라 판단되는 내용이 있다면 즉시 『신고』 버튼을 눌러 방송신고를 진행해 주시기 바랍니다."
    //MARK: - Class Func
    class func instanceFromNib() -> CastPopupView {
        return (Bundle.main.loadNibNamed("CastPopupView", owner: self, options: nil)![0] as? CastPopupView)!
    }
    
    //MARK: - UI Setup
    func setup(cast:CastInfo, castMember: CastMemberInfo) {
        
        roomNameLabel.text = cast.castTitle
        nicknameLabel.text = cast.nickName
        profileImageView.sd_setImage(with: URL(string: cast.profileImage))
        
        self.self.contentLabel.text = contentText
        
        //Update Frame
        self.updateFrame()
    }
    
    func updateFrame() {
        
        let size = self.contentLabel.sizeThatFits(CGSize(width: 280, height: 400))
        
        //Update Frame
        let heightChanged = Int(size.height) - defaultHeight
        
        if 210 + heightChanged != Int(self.frame.height) {
            let newFrame = CGRect(x: 0, y: 0, width: Int(self.frame.width), height: 210 + heightChanged + 10)
            self.frame = newFrame
        }
    }
    
    
    
    @IBAction func okAction(_ sender: AnyObject) {
        buttonAction.ok()
    }

    @IBAction func cancelAction(_ sender: AnyObject) {
        buttonAction.cancel()
    }
}

extension CastPopupView : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text!.count > 0 {
            buttonAction.ok()
        }
        
        return true
    }

}
