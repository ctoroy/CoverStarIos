//
//  UserInfoManager.swift
//  PopkonAir
//
//  Created by Steven on 12/10/2016.
//  Copyright © 2016 roy. All rights reserved.
//

import UIKit
import SwiftyJSON


enum AccountLevel : String {
    case normal     = ""
    case a          = "A"
    case b          = "B"
}

enum SNSCode : String {
    case none       = "0"
    case google     = "1"
    case kakao      = "2"
    case naver      = "3"
    case facebook   = "4"
}

let kUserWillLogOutNoti = "UserWillLogOutNotification"
let kUserDidLogOutNoti  = "UserDidLogOutNotification"

class UserInfoManager: NSObject {
    
    static let manager = UserInfoManager()
    
    fileprivate var checkLoginTimer : Timer = Timer()
    
    //MARK:- 기본 정보
    
    ///User SNSID
    var snsUserID : String {
        //TODO: maybe use keychain
        set(newValue) {
            UserDefaults.standard.setSnsLoginID(newValue)
        }
        get {
            if (UserDefaults.standard.snsLoginID() == nil) {
                UserDefaults.standard.setSnsLoginID("")
            }
            return UserDefaults.standard.snsLoginID()!
        }
    }
    
    ///User ID
    var userID : String {
        //TODO: maybe use keychain
        set(newValue) {
            UserDefaults.standard.setLoginID(newValue)
        }
        get {
            if (UserDefaults.standard.LoginID() == nil) {
                UserDefaults.standard.setLoginID("")
            }
            return UserDefaults.standard.LoginID()!
        }
    }
    
    ///User Password
    var userPW : String {
        //TODO: maybe use keychain
        set(newValue) {
            UserDefaults.standard.setLoginPW(newValue)
        }
        get {
            if (UserDefaults.standard.LoginPW() == nil) {
                UserDefaults.standard.setLoginPW("")
            }
            return UserDefaults.standard.LoginPW()!
        }
    }
    
    var uuid : String = UUID().uuidString
    
    ///자동로그인 여부
    var isAutoLogin : Bool {
        //TODO: maybe use keychain
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: "auto_login")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.bool(forKey: "auto_login")
        }
    }
    
    /// 로그인 여부
    var isLogined : Bool = false
    
    //MARK: - 로그인 회원 정보
    
    ///성별 (0 : 여 , 1 : 남)
    var memberSex : String = ""
    
    ///성인여부 (0 : 비성인, 1 : 성인)
    var isAdult : String = "0"
    
    ///닉네임
    var nickName : String = ""
    
    ///회원형태
    var memberType : String = ""
    
    ///회원 프로필이미미지 경로
    var pFileName : String = ""
    
    ///계정 등급
    var accountLevel : AccountLevel = .normal
    
    ///암호화 처리 회원 비밀번호
    var pwdCode : String = ""
    
    ///일반코인 소유갯수
    var coin : Int = 0
    
    ///어니언코인 소유갯수
    var aCoin : Int = 0
    
    ///스위트코인 소유갯수
    var sCoin : Int = 0
    
    ///카라멜코인 소유갯수
    var cCoin : Int = 0
    
    var userEmail : String = ""
    
    ///민주종편
    ///SNS Code
    var snsCode : SNSCode {
        //TODO: maybe use keychain
        set(newValue) {
            UserDefaults.standard.set(newValue.rawValue, forKey: "sns_code")
            UserDefaults.standard.synchronize()
        }
        get {
            if (UserDefaults.standard.string(forKey: "sns_code") == nil) {
                UserDefaults.standard.set(SNSCode.none.rawValue, forKey: "sns_code")
                UserDefaults.standard.synchronize()
            }
            return SNSCode(rawValue:UserDefaults.standard.string(forKey: "sns_code")!)!
        }
    }
    
    
    
    //MARK: - Init
    private override init(){
//        userID =  
    }
    
    //MARK: - Public Functions
    
    open func setInfo(json : JSON) {
        
        memberSex = json[usMemberSexKey].stringValue
        nickName = json[usNickNameKey].stringValue
        memberType = json[usMemberTypeKey].stringValue
        pFileName = json[usPFileNameKey].stringValue
        coin = json[usCoinKey].intValue
    }
    
    open func updateCoinStatus(json : JSON) {
        
        coin = json[usCoinKey].intValue
        aCoin = json[usACoinKey].intValue
        sCoin = json[usSCoinKey].intValue
        cCoin = json[usCCoinKey].intValue
    }
    
    open func clearInfo() {
        if snsCode != .none {
            userID = ""
        }
        userPW = ""
        snsUserID = ""
        snsCode = .none
        isLogined = false
        isAutoLogin = false
        memberSex = ""
        isAdult = ""
        nickName = ""
        memberType = ""
        pFileName = ""
        accountLevel = .normal
        pwdCode = ""
        coin = 0
        aCoin = 0
        sCoin = 0
        cCoin = 0
    }
    
    
    open func canBroadcast() -> Bool {
        return memberType == "1"
    }

    //MARK: - Check login status
    func startCheckLoginStatus() {
        
        dispatchMain.async {
            print("start CheckLoginStatus ->>>")
            self.checkLoginTimer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(self.checkLogin), userInfo: nil, repeats: true)
        }
        
    }
    
    @objc func checkLogin() {
//        connection.loadLoginStatus(complete: { (succeed, status) in
//            if succeed {
//                if status {
//                    print("->>> CheckLoginStatus fine <<<<-")
//                }else {
//                    self.stopCheckLoginStatus()
//                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: kUserWillLogOutNoti), object:nil)
//                    userInfo.clearInfo()
//                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: kUserDidLogOutNoti), object:nil)
//                    popupManager.defaultAlert(title: "", subject: "다른기기에서 로그인 하였습니다.", btn1Title: "확인", btn2title: "")
////                    popupManager.showAlert(content: "다른기기에서 로그인 하였습니다.",buttonTitles: ["확인"],buttonActions: [{}])
//                }
//            }
//        })
    }
    
    func stopCheckLoginStatus() {
        print("stop CheckLoginStatus -<<<<<")
        checkLoginTimer.invalidate()
    }
    
    //MARK: - Saved TimeStamp

    let kLatestShowLoginPolicyTS = "latestShowLoginPolicyTS"
    let kLatestShowBroadcastPolicyTS = "latestShowBroadcastPolicyTS"
    
    func needShowLoginPolicyPopup()->Bool {
        
        return false
        
//        let ts = UserDefaults.standard.double(forKey: kLatestShowLoginPolicyTS)
//        
//        if Date().timeIntervalSinceReferenceDate - ts >= 3600*24*7 {
//            return true
//        }
//        return false
    }
    
    func needShowBroadcastPolicyPopup()->Bool {
        return false
        
//        let ts = UserDefaults.standard.double(forKey: kLatestShowBroadcastPolicyTS)
//        
//        if Date().timeIntervalSinceReferenceDate - ts >= 3600*24*7 {
//            return true
//        }
//        return false
    }
    
    func updateShowLoginPolicyTs(){
        UserDefaults.standard.set(Date().timeIntervalSinceReferenceDate, forKey: kLatestShowLoginPolicyTS)
        UserDefaults.standard.synchronize()
    }

    func updateShowBroadcastPolicyTs(){
        UserDefaults.standard.set(Date().timeIntervalSinceReferenceDate, forKey: kLatestShowBroadcastPolicyTS)
        UserDefaults.standard.synchronize()
    }
}
