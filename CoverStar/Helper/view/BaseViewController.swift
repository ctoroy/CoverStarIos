//
//  RTBaseViewController.swift
///  PopkonAir
//
//  Created by roy on 2016. 8. 14..
//  Copyright © 2016년 roy. All rights reserved.
//


import UIKit
import AVFoundation
import Photos


class BaseViewController: UIViewController
{
    
//    var navibarType : NavigationBarType  = .normal
    
    fileprivate var chooseImageCompleted : (_ image: UIImage?)->Void = {_ in}
    //MARK: - Life Cycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
//        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        
        super.viewWillAppear(animated)
        
//        self.setBar(with: self.navibarType)
//        self.setBarRightButton(with: [])
        
        //update Back button display
//        if let navi = self.navigationController {
//
//
//            let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: navigationController, action: nil)
//            navigationItem.leftBarButtonItem = backButton
//            navi.navigationItem.setRightBarButtonItems([], animated: false)
//
//            if navi.viewControllers.count>1 {
//                var buttonInfo = BarButtonInfo()
//                buttonInfo.type = .back
//                buttonInfo.actionHandler = {_ in
//                    navi.popViewController(animated: true)
//                }
//                self.baseNavi?.customBar.leftButtonInfos = [buttonInfo]
//            }
//
//        }
        
//        //add observer of logout noti
//        NotificationCenter.default.addObserver(self, selector: #selector(willLogOut), name: NSNotification.Name(rawValue: kUserWillLogOutNoti), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(didLogOut), name: NSNotification.Name(rawValue: kUserDidLogOutNoti), object: nil)
//        //add UIApplicationDidBecomeActive & UIApplicationWillEnterForeground observer
//        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(willResignActive), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
        
        
        popupManager.currentViewController = self
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        
        //remove observer of logout noti
        NotificationCenter.default.removeObserver(self)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
    override var shouldAutorotate: Bool
    {
        return false
    }
    
    // MARK: - Notification oberserver methods
//    @objc func didBecomeActive() {
//        log.debug("did become active")
//
//    }
//
//    @objc func willResignActive() {
//        log.debug(("will resign active"))
//    }
//
//
//    @objc func willLogOut(){
//        log.debug("user will log out")
//    }
//
//    @objc func didLogOut(){
//        log.debug("user did log out")
//    }
}

extension UIViewController {
    
    /// 최상위 윈도우 readonly!!
    var mainWindow: UIWindow {
        get {
            var window = UIApplication.shared.keyWindow;
            if(window != nil)
            {
                window = (UIApplication.shared.windows[0] )
            }
            return window!
        }
    }
    
//    var baseNavi : BaseNavigationController? {
//        get {
//            if self.navigationController != nil {
//                return self.navigationController as? BaseNavigationController
//            }
//            return nil
//        }
//    }
    


    
    //MARK: - New
    func viewController(identifier : String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier) as UIViewController
    }
    
    func changeToVC(identifier : String){
        let targetVC = self.viewController(identifier: identifier)
        self.mainWindow.rootViewController = targetVC
    }
    
    func changeToLogin() {
        self.changeToVC(identifier: "login_navi")
    }
    
    //MARK: - Show VC
//    func showLoginVC(complete : @escaping (_ succeed : Bool) -> Void) {
//        if let navi = self.viewController(identifier: "login_navi") as? BaseNavigationController {
//
//            if let loginVC = navi.viewControllers.first as? LoginViewController {
//                let completeHandler : (_ succeed : Bool)->Void = {
//                    succeed in
//
//                    complete(succeed)
//
//                }
//                loginVC.completionHandler = completeHandler
//
//                self.present(navi, animated: true) {
//
//                }
//            }
//
//        }
//    }
    
//    func showWebVC(with path:WebPagePath) {
//        if let webVC = self.viewController(identifier: "SupportWebViewController") as? SupportWebViewController {
//
//            webVC.pagePath = path
//
//            if let navi = self.navigationController {
//
//                navi.pushViewController(webVC, animated: true)
//            }
//        }
//    }
//
//    func showWebVC(url:URL) {
//        if let webVC = self.viewController(identifier: "SupportWebViewController") as? SupportWebViewController {
//
//            webVC.url = url
//
//            if let navi = self.navigationController {
//
//                navi.pushViewController(webVC, animated: true)
//            }
//        }
//    }
//
//    func watchCast(of cast:CastInfo)
//    {
//        let showVodPalyer : () -> Void = {
//
//            dispatchMain.async {
//
//                if let vodVC = self.viewController(identifier: "WatchVODViewController") as? WatchVODViewController {
//
//                    vodVC.cast = cast
//                    if let navi = self.navigationController {
//                        navi.pushViewController(vodVC, animated: true)
//                    }else if self is UINavigationController {
//                        (self as! UINavigationController).pushViewController(vodVC, animated: true)
//                    }else {
//                        self.present(vodVC, animated: true, completion: nil)
//                    }
//
//                }
//            }
//        }
//
//        showVodPalyer()
//    }
//
//    func showWatchCastVC(cast:CastInfo) {
//
//        let showCastVCHandler = {
//            dispatchMain.async {
//                let watchVC = self.viewController(identifier: "WatchCastViewController") as! WatchCastViewController
//
//                watchVC.cast = cast
//
//                if let navi = self.navigationController {
//                    navi.pushViewController(watchVC, animated: true)
//                }else if self is UINavigationController {
//                    (self as! UINavigationController).pushViewController(watchVC, animated: true)
//                }else {
//                    self.present(watchVC, animated: true, completion: nil)
//                }
//            }
//        }
//        showCastVCHandler()
//    }
//
//    func showWatchVODVC(vod: VODInfo, mc : FanMCInfo) {
//
//        popupManager.showLoadingView()
//        connection.sendWatchVOD(with: (vodCode : vod.vodCode, signID:vod.signID, partnerCode : vod.partnerCode), command: .start) { (succeed, json, resultInfo) in
//            popupManager.hideLoadingView()
//
//            if succeed {
//                vod.setInfo(json: json["mcVodWatchOnOff"])
//
//                dispatchMain.async {
//                    let watchVC = self.viewController(identifier: "WatchVODViewController") as! WatchVODViewController
//
//                    self.navigationController?.pushViewController(watchVC, animated: true)
//                }
//            }
//        }
//
//    }
//
//    func showWebVC(url : URL, cast: CastInfo) {
//        dispatchMain.async {
//            let webVC = self.viewController(identifier: "GiftWebViewController") as! GiftWebViewController
//
//
//            let post = ["SC_SI": userInfo.userID, "SC_SP": userInfo.pwdCode, "SC_PC":PARTNER_CODE, "SC_RPAT":"8", "SC_WCP":"0", "SC_CSI":cast.castId,"SC_SEC":"1","SC_BPU":""]
//
//
//            let keyIndex = (arc4random()%1000)+1
//            let encryped = aesAdapter.encrypt(with: Int(keyIndex), text: post.description)
//
//            let param = "key=\(keyIndex)&DATA=\(encryped.urlEncode()!)"
//
//            log.debug("param : \(param)")
//
//            let url2 = URL(string: "\(url.absoluteString)?\(param)")!
//
//            log.debug("url : \(url2)")
//
//            webVC.url = url2
//
//            let navi = BaseNavigationController(rootViewController: webVC)
//
//            if self.navigationController != nil {
//                self.navigationController?.present(navi, animated: true, completion: {
//
//                })
//            }else {
//                self.present(navi, animated: true, completion: {
//
//                })
//            }
//
//        }
//    }
    
//    func showWebVC(url : URL) {
//        dispatchMain.async {
//            let webVC = self.viewController(identifier: "GiftWebViewController") as! GiftWebViewController
//
//            webVC.url = url
//
//            let navi = BaseNavigationController(rootViewController: webVC)
//
//            if self.navigationController != nil {
//                self.navigationController?.present(navi, animated: true, completion: {
//
//                })
//            }else {
//                self.present(navi, animated: true, completion: {
//
//                })
//            }
//
//        }
//    }
    
//    func showWebVC(url : URL, vod: VODInfo) {
//        dispatchMain.async {
//            let webVC = self.viewController(identifier: "GiftWebViewController") as! GiftWebViewController
//
//
//            let post = ["SC_SI": userInfo.userID, "SC_SP": userInfo.pwdCode, "SC_PC":PARTNER_CODE, "SC_RPAT":"8", "SC_WCP":"0", "SC_CSI":vod.signID,"SC_CPC":vod.partnerCode,"SC_SEC":"1","SC_BPU":""]
//
//
//            let keyIndex = (arc4random()%1000)+1
//            let encryped = aesAdapter.encrypt(with: Int(keyIndex), text: post.description)
//
//            let param = "key=\(keyIndex)&DATA=\(encryped.urlEncode()!)"
//
//            log.debug("param : \(param)")
//
//            let url2 = URL(string: "\(url.absoluteString)?\(param)")!
//
//            log.debug("url : \(url2)")
//
//            webVC.url = url2
//
//            let navi = BaseNavigationController(rootViewController: webVC)
//
//            if self.navigationController != nil {
//                self.navigationController?.present(navi, animated: true, completion: {
//
//                })
//            }else {
//                self.present(navi, animated: true, completion: {
//
//                })
//            }
//
//        }
//    }
//
//    func showBCPrepareVC() {
//
//        let showVC = {
//            dispatchMain.async {
//
//
//                let prepareVC = self.viewController(identifier: "BCPrepareViewController") as! BCPrepareViewController
//
//                self.navigationController?.show(prepareVC, sender: nil)
//            }
//
//        }
//        if userInfo.isLogined {
//            showVC()
//        }else {
//            showLoginVC(complete: { (succeed) in
//                if succeed {
//                    showVC()
//                }
//            })
//        }
//
//    }
//
//    //    func
//
//    // MARK: - NavigationBar Setup Interfaces
//
//    ///Set Bar Type (Normal, Logo, Search)
//    fileprivate func setBar(with type : NavigationBarType) {
//        self.baseNavi?.customBar.setBar(with: type)
//    }
//
//    func setBarTitle(with text : String) {
//        self.baseNavi?.customBar.setTitle(with: text)
//        self.baseNavi?.customBar.sizeToFit()
//    }
//
//    func setbuttonHidden() {
//        self.baseNavi?.customBar.logOutHidden()
//    }
//
//    func setBarLeftButton(with buttonInfos:[BarButtonInfo]) {
//        var resultButtonInfos : [BarButtonInfo] = []
//
//        for info in buttonInfos {
//            var resultInfo = BarButtonInfo()
//            resultInfo.type = info.type
//            switch info.type {
//            case .broadcast:
//                resultInfo.actionHandler = {
//                    sender in
//                    self.showBCPrepareVC()
//                    info.actionHandler(sender)
//                }
//                break
//            default:
//                resultInfo.actionHandler = {
//                    sender in
//                    info.actionHandler(sender)
//                }
//                break
//            }
//
//            resultButtonInfos.append(resultInfo)
//        }
//
//        self.baseNavi?.customBar.leftButtonInfos = resultButtonInfos
//    }
//
//    func setBarRightButton(with buttonInfos:[BarButtonInfo]) {
//        var resultButtonInfos : [BarButtonInfo] = []
//
//        for info in buttonInfos {
//            var resultInfo = BarButtonInfo()
//            resultInfo.type = info.type
//            switch info.type {
//            case .broadcast:
//                resultInfo.actionHandler = {
//                    sender in
//                    self.showBCPrepareVC()
//                    info.actionHandler(sender)
//                }
//                break
//            default:
//                resultInfo.actionHandler = {
//                    sender in
//                    info.actionHandler(sender)
//                }
//                break
//            }
//
//            resultButtonInfos.append(resultInfo)
//        }
//
//        self.baseNavi?.customBar.rightButtonInfos = resultButtonInfos
//    }
//
////    func setBarRight1(with type : NavigationBarButtonType) {
////        self.baseNavi?.customBar.setRight1(with: type)
////
////        //Set default action
////        var action : (_ sender:UIButton) -> Void
////
////        switch type {
////        case .broadcast:
////            action = {
////                sender in
////                self.showBCPrepareVC()
////            }
////            break
////        case .search:
////            action = {
////                sender in
////                self.showSearchVC()
////            }
////            break
////        default:
////            action = {sender in}
////            break
////        }
////
////        self.setBarAction(right1: action)
////
////    }
////
////    func setBarRight2(with type : NavigationBarButtonType) {
////        self.baseNavi?.customBar.setRight2(with: type)
////
////        //Set default action
////        var action : (_ sender:UIButton) -> Void
////
////        switch type {
////        case .broadcast:
////            action = {
////                sender in
////                self.showBCPrepareVC()
////            }
////            break
////        case .search:
////            action = {
////                sender in
////                self.showSearchVC()
////            }
////            break
////        default:
////            action = {sender in}
////            break
////        }
////
////        self.setBarAction(right2: action)
////    }
//
//    func setBarRoundTitle(with text: String, controlState : UIControlState) {
//        self.baseNavi?.customBar.setRoundTitle(with: text, controlState: controlState)
//    }
//
//    ///Set BaseNavigationBar button actions
//
//
//    ///Set LogoButton Action
//    func setBarAction(logo:@escaping ()->Void) {
//        if self.baseNavi == nil {
//            return
//        }
//        self.baseNavi?.customBar.logoAction = logo
//    }
//
////    ///Set RightButton1 Action
////    func setBarAction(right1:@escaping (_ sender:UIButton)->Void) {
////        if self.baseNavi == nil {
////            return
////        }
////        self.baseNavi?.customBar.right1Action = right1
////    }
////
////    ///Set RightButton2 Action
////    func setBarAction(right2:@escaping (_ sender:UIButton)->Void) {
////        if self.baseNavi == nil {
////            return
////        }
////        self.baseNavi?.customBar.right2Action = right2
////    }
//
//    ///Set RoundButton Action
//    func setBarAction(round:@escaping (_ sender:UIButton)->Void) {
//        if self.baseNavi == nil {
//            return
//        }
//        self.baseNavi?.customBar.roundAction = round
//    }
//
//    ///Set SearchTextField end edit Action
//    func setBarAction(searchShouldReturn:@escaping (_ textField : UITextField)->Bool) {
//        if self.baseNavi == nil {
//            return
//        }
//        self.baseNavi?.customBar.searchShoulReturnAction = searchShouldReturn
//    }
//
//    // MARK: - IBAction
//
//    @objc private func goBack() {
//        if let navi = self.navigationController {
//            if navi.viewControllers.count>1 {
//                navi.popViewController(animated: true)
//            }else {
//                navi.dismiss(animated: true, completion: {})
//            }
//
//        }else {
//            self.dismiss(animated: true, completion: {
//
//            })
//        }
//    }
//
//
//    //Hide keyboard
//    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
//    }
}

extension BaseViewController {
    func showSelectImageActionSheet(completed: @escaping (_ image: UIImage?) -> Void) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let albumButton = UIAlertAction(title: "앨범에서 선택", style: .default) { (action) in
            if self.checkPhotoLibrary() == false {
                return
            }
            self.showImagePicker(.photoLibrary)
        }
        
        let cameraButton = UIAlertAction(title: "사진 촬영", style: .default) { (action) in
            if self.checkCamera() == false {
                return
            }
            self.showImagePicker(.camera)
        }
        
        let cancelButton = UIAlertAction(title: "취소", style: .cancel) { (action) in}
        
        alertController.addAction(albumButton)
        alertController.addAction(cameraButton)
        alertController.addAction(cancelButton)
        
        self.chooseImageCompleted = completed
        
        if let navi = self.navigationController {
            navi.present(alertController, animated: true, completion: nil)
        }else {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func checkPhotoLibrary() -> Bool {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            return true
        case .denied, .restricted :
            alertToEncouragePhotoLibraryAccessInitially()
            return false
        case .notDetermined:
            alertPromptToAllowPhotoLibraryAccessViaSetting()
        case .limited:
            return true
        @unknown default:
            return false
        }
        
        return false
    }
    
    func checkCamera() -> Bool {
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch authStatus {
        case .authorized:
            return true
        case .denied:
            alertToEncourageCameraAccessInitially()
            return false
        case .notDetermined:
            alertPromptToAllowCameraAccessViaSetting()
            return false
        default: alertToEncourageCameraAccessInitially()
        return false
        }
    }
    
    func alertToEncouragePhotoLibraryAccessInitially() {
        let alert = UIAlertController(
            title: "",
            message: "사진 사용 권한이 없습니다. \"확인\"을 누르시면 설정 화면으로 이동합니다. \n\n설정 화면에서 \"스위치 건강관리\" 의 사진 권한 설정을 해주세요.\n권한 변경시 앱이 재시작됩니다.",
            preferredStyle: UIAlertController.Style.alert
        )
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { (alert) -> Void in
            DispatchQueue.main.async(execute: {
                UIApplication.shared.openURL(URL(string: UIApplication.openSettingsURLString)!)
            })
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func alertPromptToAllowPhotoLibraryAccessViaSetting() {
        
        let alert = UIAlertController(
            title: "",
            message: "사진 사용 권한이 없습니다. \"확인\"을 누르시면 설정 화면으로 이동합니다. \n\n설정 화면에서 \"스위치 건강관리\" 의 사진 권한 설정을 해주세요.\n권한 변경시 앱이 재시작됩니다.",
            preferredStyle: UIAlertController.Style.alert
        )
        alert.addAction(UIAlertAction(title: "확인", style: .default) { alert in
            PHPhotoLibrary.requestAuthorization() { (status) -> Void in
                DispatchQueue.main.async { [self] in
                    self.checkPhotoLibrary()
                }
            }
        })
        
        present(alert, animated: true, completion: nil)
    }
    
    func alertToEncourageCameraAccessInitially() {
        let alert = UIAlertController(
            title: "",
            message: "카메라 사용 권한이 없습니다. \"확인\"을 누르시면 설정 화면으로 이동합니다. \n\n설정 화면에서 \"스위치 건강관리\" 의 카메라 권한 설정을 해주세요. \n권한 변경시 앱이 재시작됩니다.",
            preferredStyle: UIAlertController.Style.alert
        )
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { (alert) -> Void in
            DispatchQueue.main.async(execute: {
                UIApplication.shared.openURL(URL(string: UIApplication.openSettingsURLString)!)
            })
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func alertPromptToAllowCameraAccessViaSetting() {
        
        let alert = UIAlertController(
            title: "",
            message: "카메라 사용 권한이 없습니다. \"확인\"을 누르시면 설정 화면으로 이동합니다. \n\n설정 화면에서 \"스위치 건강관리\" 의 카메라 권한 설정을 해주세요. \n권한 변경시 앱이 재시작됩니다.",
            preferredStyle: UIAlertController.Style.alert
        )
        alert.addAction(UIAlertAction(title: "확인", style: .default) { alert in
            if AVCaptureDevice.devices(for: AVMediaType.video).count > 0 {
                AVCaptureDevice.requestAccess(for: AVMediaType.video) { granted in
                    DispatchQueue.main.async {
                        self.checkCamera() } }
            }
            }
        )
        present(alert, animated: true, completion: nil)
    }
}

//MARK: - ImagePicker
extension BaseViewController {
    
    fileprivate func showImagePicker(_ sourceType: UIImagePickerController.SourceType ) {
        
//        let vc = UIImagePickerController()
//                vc.sourceType = .photoLibrary
//                vc.delegate = self
//                vc.allowsEditing = true
//                present(vc, animated: true)
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
}

extension BaseViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        self.chooseImageCompleted(info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage)
    }
}
