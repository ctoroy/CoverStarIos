
//
//  PopupManager.swift
//  PopkonAir
//
//  Created by Steven on 21/10/2016.
//  Copyright © 2016 roy. All rights reserved.
//

import UIKit

let loginPolicyContent = "민주종편TV 청소년보호정책\n\n팝콘TV는 청소년들이 유해 정보에 접근할 수 없도록 방지하는 인증 장치 및 관리 조치를 취하고 있으며, 청소년이 건전한 인격체로 성장할 수 있도록 청소년 보호 정책 수립 및 시행에 최선을 다하고 있습니다.\n\n1.팝콘TV는 만 19세 이상의 성인만 방송이 가능합니다.\n\n2.팝콘TV는 아주 작은 욕설이나 음주 흡연도 성인 컨텐츠로 분류되어 청소년의 접근을 차단합니다.\n\n3.팝콘TV의 모든 회원은 본인 인증된 회원이며 청소년의 경우 성인컨텐츠를 엄격하게 차단하여 절대 접근을 할 수 없습니다.\n\n4.팝콘TV는 방송통신심의위원회의 '원스트라이크아웃제도'를 시행 및 준수하고 있으며 청소년의 불법유해정보 유통 근절을 위하여 24시간 실시간 모니터링을 진행하고 있습니다."

let bradcastPolicyContent = "민주종편TV 준수사항\n\n아래 내용의 방송을 하지 않겠습니다.\n\n● 저작권 침해\n● 저속/음란한 방송\n● 사생활, 초상권 침해\n● 욕설/언어폭력\n● 19세 이상 제한 없이 사행성,음주,흡연장면\n● 19세 이상 제한 없이 잔인,폭력적인 장면\n● 공공질서 및 미풍양속에 위배되는 방송\n\n위 내용의 방송이 신고,적발될 경우\n서비스 이용에 제한을 받을 수 있으며,\n이용정지 및 선물받은 팝콘을 취소될 수 있습니다.\n또한, 제재조치와는 별도로 관련법에 의거형사처벌 받거나 손해배상청구를 당할 수 있습니다.\n본 방송에 출연하는 자들에 대하여 해당 BJ가 사전 동의를\n받았음을 전제로 하는바, 만약 동의를 하지 않는 경우에는\n지체 없이 이를 회사에 알려주시기 바랍니다.\n동의시 일주일간 알리지 않습니다."

class PopupManager: NSObject {

    //MARK: - Public Params
    
    var blurView : BlurView = BlurView.standard()
    let loadingView : LoadingView = LoadingView.instanceFromNib()
    
    var popups : [PopupView] = []
    
    var loadingCount = 0
    
    var currentViewController : UIViewController?
    
    static let manager = PopupManager()
    
    
    //MARK: - Alert popup
    
    ///Return AlertPopupView
    func alertView(with title:String) ->AlertPopupView {
        
        let alert : AlertPopupView = AlertPopupView.instanceFromNib()
        
        alert.setup(content: title, buttonTitles: [])
        
        return alert
    }
    
    ///Return ChkAlertView
    func chkAlertView(content: String, chkTitle:String) -> ChkAlertPopupView {
        let alert : ChkAlertPopupView = ChkAlertPopupView.instanceFromNib()
        
        alert.setup(content: content, chkTitle: chkTitle, buttonTitles: ["확인"])
        
        return alert
    }
    
    ///Return ChkAlertView
    func threeBtnInputPopupView(content: String, buttonTitles:[String]) -> ThreeBtnInputPopupView {
        let alert : ThreeBtnInputPopupView = ThreeBtnInputPopupView.instanceFromNib()
        
        alert.setup(content: content, buttonTitles: buttonTitles)
        
        return alert
    }
    
    ///Return ChkAlertView
    func longTextPopup(content: String, chkTitle:String = "" , buttonTitles: [String] = ["확인","취소"]) -> LongTextPoupView {
        let alert : LongTextPoupView = LongTextPoupView.instanceFromNib()
        
        alert.setup(content: content, chkTitle : chkTitle, buttonTitles: buttonTitles)
        
        return alert
    }
    
    ///Return ChkAlertView
    func multiButtonPoupView(title: String) -> MultiButtonPopupView {
        let alert : MultiButtonPopupView = MultiButtonPopupView.instanceFromNib()
        
        alert.titleLabel.text = title
        
        return alert
    }
    
    func showAlert(content:String ,buttonTitles : [String] = [], buttonActions : [()->Void] = []) {
        dispatchMain.async {
        
            let alert : AlertPopupView = AlertPopupView.instanceFromNib()
            
            
            alert.setup(content: content, buttonTitles: buttonTitles)
        
            //            self.alert.setup(content: content, okTitle: okTitle, cancelTitle: cancelTitle)
            
            if buttonActions.count == 0 {
                alert.setButtonActions(actions: [{self.hide(popup: alert)}])
            }else {
                
                var newButtonActions : [()->Void] = []
                
                for action in buttonActions {
                    newButtonActions.append({
                        self.hide(popup: alert)
                        action()
                    })
                }
                alert.setButtonActions(actions: newButtonActions)
            }

            self.show(popup: alert)
        }
    }
    
    func showInputAlert(title:String, buttonTitles : [String] = [], buttonActions : [(_ text : String )->Void] = []) {
    
        dispatchMain.async {
            let alert : PWInputPopupView = PWInputPopupView.instanceFromNib()
            
            
            alert.setup(content: title, buttonTitles: buttonTitles)
            
            var newButtonActions : [(_ text : String )->Void] = []
            
            if buttonActions.count == 0 {
                alert.buttonActions = [{_ in self.hide(popup: alert)}]
            }else {
                for action in buttonActions {
                    newButtonActions.append({
                        text in
                        self.hide(popup: alert)
                        action(text)
                    })
                }
                alert.buttonActions = newButtonActions
            }
            
            self.show(popup: alert)
        }
    }
    //MARK: - Popups
    ///Show Policy popup (one week check)
    func showLoginPolicyPopup(){
        let popup = self.longTextPopup(content: loginPolicyContent, chkTitle: "일주일 동안 띄우지 않기", buttonTitles: ["확인"])
        popup.buttonActions = [{
            checked in
            if checked {
//                userInfo.updateShowLoginPolicyTs()
            }
            self.hide(popup: popup)
            },{checked in self.hide(popup: popup)}]
        
        self.show(popup: popup)
    }

    func showBroadcastPolicyPopup(agreeAction:@escaping ()->Void){
        
        let popup = self.longTextPopup(content: bradcastPolicyContent, chkTitle: "", buttonTitles: ["동의","취소"])
        
        popup.buttonActions = [{
            checked in
            if checked {
//                userInfo.updateShowLoginPolicyTs()
            }
            agreeAction()
            self.hide(popup: popup)
            },{checked in self.hide(popup: popup)}]
        
        self.show(popup: popup)
    
    }
    
    func showManagerPopup(addAction:@escaping (_ targetID:String)->Void, removeAction:@escaping (_ targetID:String)->Void) {
        let popup = self.threeBtnInputPopupView(content: "매니저임명", buttonTitles: ["지정","해제","취소"])
        popup.inputTextField.placeholder = "매니저 아이디"
        popup.buttonActions = [{
            targetID in
            self.hide(popup: popup)
            addAction(targetID)
            
            },{
                targetID in
                self.hide(popup: popup)
                removeAction(targetID)
            },{
                targetID in
                self.hide(popup: popup)
            }]
        
        self.show(popup: popup)
    }
    
    func showFanLevelPopup(clickAction : @escaping (_ index:Int)->Void) {
        let popup = self.multiButtonPoupView(title: "얼리기")
        
        popup.buttonTitles = ["전체","매니저 이하"]//,"VIP 이하","다이아몬드 이하","골드 이하","실버 이하"]
        popup.buttonAction = clickAction
        
        self.show(popup: popup)
        
    }
    
    //MARK: - LoadingView
    
    ///Show loadingView and start animating
    func showLoadingView() {
        loadingCount += 1
        DispatchQueue.main.async {
            if self.popups.firstIndex(of: self.loadingView) == nil {
                
                self.show(popup: self.loadingView)
                
                self.loadingView.center = self.currentWindow().center
            }
            
            self.loadingView.startAnimating()
        }
    }
    
    ///Hide loadingView and stop animating
    func hideLoadingView() {
        if loadingCount <= 0 {
            return
        }
        
        loadingCount -= 1
        
        print("loading count : \(self.loadingCount)")
        if loadingCount == 0 {
            dispatchMain.async {
                self.hide(popup: self.loadingView)
                
                self.loadingView.stopAnimating()
//                self.loadingView.hide()
            }
            
        }
    }
    
    
//    //MARK: - Cast Popup
//    func showCastPopup(cast:CastInfo, castMember: CastMemberInfo, okAction:@escaping ()->Void, cancelAction:@escaping ()->Void = {}) {
//        DispatchQueue.main.async {
//
//            let popup : CastPopupView = CastPopupView.instanceFromNib()
//
//            popup.setup(cast:cast, castMember: castMember)
//            //            self.alert.setup(content: content, okTitle: okTitle, cancelTitle: cancelTitle)
//
//            popup.center = self.currentWindow().center
//
//            popup.buttonAction.ok = {
//                self.hide(popup: popup)
//                okAction()
//            }
//            popup.buttonAction.cancel = {
//                self.hide(popup: popup)
//                cancelAction()
//            }
//
//            self.show(popup: popup)
//        }
//    }
    
    //MARK: - Private
    
    ///Show popup view
    func show(popup: PopupView) {
        
        DispatchQueue.main.async {
            
            popup.center = self.currentWindow().center
            
            if self.popups.firstIndex(of: popup) == nil {
                
                self.blurView.showInView(parentView: self.currentWindow())
                
                popup.showInView(parentView: self.currentWindow())
                
                self.popups.append(popup)
            }
        }
        
    }
    
    ///Hide popup View
    func hide(popup: PopupView) {
        dispatchMain.async {
            if let index = self.popups.firstIndex(of: popup) {
                self.popups.remove(at: index)
                popup.hide()
            }
            
            if self.popups.count == 0 {
                self.blurView.hide()
            }
        }
        
    }
    
    func defaultAlert(title: String, subject: String, btn1Title: String, btn2title: String)
    {
        let alert = UIAlertController(title: title, message: subject, preferredStyle: .alert)
        
        if(btn2title != "")
        {
            alert.addAction(UIAlertAction(title: "취소", style: .default, handler: { (_) in
                
            }))
        }
        
        if(btn1Title != "")
        {
            alert.addAction(UIAlertAction(title: btn1Title, style: .default, handler: { (_) in
                
            }))
        }
        
        if self.currentViewController != nil {
            self.currentViewController!.present(alert, animated: true, completion: nil)
        }
        
    }


    private func currentWindow()->UIView {
        return (UIApplication.shared.keyWindow)!
    }
    
}
    
