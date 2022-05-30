//
//  NSUserDefaults+Extensions.swift
//  PopkonAir
//
//  Created by roy on 2016. 8. 14..
//  Copyright © 2016년 roy. All rights reserved.
//

import Foundation

let NSUserDefaultAutoLogin = "NSUserDefaultAutoLogin"
let NSUserDefaultEnableLTE = "NSUserDefaultEnableLTE"
let NSUserDefaultSNSID = "NSUserDefaultSNSID"
let NSUserDefaultID = "NSUserDefaultID"
let NSUserDefaultPW = "NSUserDefaultPW"
let NSUserDefaultPushKey = "NSUserDefaultPushKey"
let NSUserDefaultUUID = "NSUserDefaultUUID"
//let NSUserDefaultDidEnterBackground = "NSUserDefaultDidEnterBackground"
//let NSUserDefaultActiveFromBackground = "NSUserDefaultActiveFromBackground"

extension UserDefaults
{
    /// Login 유지 데이터 UserDefault 값
    /// 
    /// - returns: Login 유지값
    func isAutoLogin() -> Bool!
    {
        if self.object(forKey: NSUserDefaultAutoLogin) == nil
        {
            return false
        }
        else
        {
            return self.object(forKey: NSUserDefaultAutoLogin) as? Bool
        }
    }
    
    /// Login 유지 데이터 설정
    ///
    /// - parameter Login: 유지 설정값
    func AutoLogin(_ val: Bool)
    {
        self.set( val, forKey: NSUserDefaultAutoLogin)
        self.synchronize()
    }
    
    /// 3G LTE 사용여부 UserDefault 값
    ///
    /// - returns: 3G LTE 사용여부
    func isLTEEnabled() -> Bool!
    {
        if self.object(forKey: NSUserDefaultEnableLTE) == nil
        {
            return true
        }
        else
        {
            return self.bool(forKey:NSUserDefaultEnableLTE)
        }
    }
    
    /// 3G LTE 사용여부 설정
    ///
    /// - parameter 3G LTE 사용여부
    func setLTEEnabled(_ val: Bool)
    {
        self.set( val, forKey: NSUserDefaultEnableLTE)
        self.synchronize()
    }
    
    /// Login ID 데이터 UserDefault 값
    ///
    /// - returns: Login ID값
    func LoginID() -> String?
    {
        return self.object(forKey: NSUserDefaultID) as? String
    }
    
    /// SNS Login ID 데이터 UserDefault 값
    ///
    /// - returns: Login snsID값
    func snsLoginID() -> String?
    {
        return self.object(forKey: NSUserDefaultSNSID) as? String
    }
    
    /// Login ID 데이터 설정
    ///
    /// - parameter Login: ID 설정값
    func setLoginID(_ val: String)
    {
        self.set( val, forKey: NSUserDefaultID)
        self.synchronize()
    }
    
    /// Login SNSID 데이터 설정
    ///
    /// - parameter Login: SNSID 설정값
    func setSnsLoginID(_ val: String)
    {
        self.set( val, forKey: NSUserDefaultSNSID)
        self.synchronize()
    }
    
    /// Login PW 데이터 UserDefault 값
    ///
    /// - returns: Login PW값
    func LoginPW() -> String?
    {
        return self.object(forKey: NSUserDefaultPW) as? String
    }
    
    /// Login PW 데이터 설정
    ///
    /// - parameter Login: PW 설정값
    func setLoginPW(_ val: String)
    {
        self.set( val, forKey: NSUserDefaultPW)
        self.synchronize()
    }
    
    /// Login 푸쉬 키 값
    ///
    /// - returns: Login 푸쉬 키
    func PushKey() -> String?
    {
        return self.object(forKey: NSUserDefaultPushKey) as? String
    }
    
    /// Login 푸쉬 키 데이터 설정
    ///
    /// - parameter Login: 푸쉬 키
    func setPushKey(_ key: String)
    {
        self.set(key, forKey: NSUserDefaultPushKey)
        self.synchronize()
    }
    
    func getUUID() -> String?
    {
        return self.object(forKey: NSUserDefaultUUID) as? String
    }
    
    /// Login 푸쉬 키 데이터 설정
    ///
    /// - parameter Login: 푸쉬 키
    func setUUID(_ uuid: String)
    {
        self.set(uuid, forKey: NSUserDefaultUUID)
        self.synchronize()
    }
    
    /// 모든 NSUserDefaults 값을 삭제한다
    func clearAllUserData()
    {
        for key in self.dictionaryRepresentation().keys
        {
            self.removeObject(forKey: key)
        }
        self.synchronize()
    }
    
//    /// DidEnterBackground 여부 값
//    ///
//    /// - returns: DidEnterBackground 여부
//    func didEnterBackground() -> Bool!
//    {
//        if self.objectForKey(NSUserDefaultDidEnterBackground) == nil
//        {
//            return false
//        }
//        else
//        {
//            return self.objectForKey(NSUserDefaultDidEnterBackground) as! Bool
//        }
//    }
//    
//    /// DidEnterBackground 여부 값 설정
//    ///
//    /// - parameter: DidEnterBackground 여부 설정
//    func setDidEnterBackground(key: Bool)
//    {
//        self.setObject(key, forKey: NSUserDefaultDidEnterBackground)
//        self.synchronize()
//    }
//    
//    
//    /// BackgroundMode에서 Active 되었는지 여부 값
//    ///
//    /// - returns: BackgroundMode에서 Active 되었는지 여부
//    func isActiveFromBackground() -> Bool!
//    {
//        if self.objectForKey(NSUserDefaultActiveFromBackground) == nil
//        {
//            return false
//        }
//        else
//        {
//            return self.objectForKey(NSUserDefaultActiveFromBackground) as! Bool
//        }
//    }
//    
//    /// BackgroundMode에서 Active 되었는지 여부 값 설정
//    ///
//    /// - parameter: BackgroundMode에서 Active 되었는지 여부 설정
//    func setActiveFromBackground(key: Bool)
//    {
//        self.setObject(key, forKey: NSUserDefaultActiveFromBackground)
//        self.synchronize()
//    }
    
}
