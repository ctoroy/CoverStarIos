//
//  NetworkHelper.swift
//  CoverStar
//
//  Created by taehan park on 2022/03/29.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON

class NetworkHelper: NSObject {
    
    static let manager = NetworkHelper()
    
    //MARK: 13. 마이 포인트 조회
    ///13. 마이 포인트 조회
    
    func getCurCoin(userID : String , complete : @escaping (_ succeed : Bool, _ resultInfo : JSON) -> Void)
    {
        
        var params = self.defaultParams()
        
        params["userId"]           = userID
        
        let url = Static.apiUrl + "getCurCoin"
        
        let completionHandler = {
            (_ succeed : Bool, _ json : JSON, _ resultInfo : JSON) -> Void in
            
            if succeed {
                Static.curCoin = json["curCoin"].intValue
            }
            
            complete(succeed, resultInfo)
            
        }
        
        self.post(url: url, params: params, complete: completionHandler)
        
    }
    
    //MARK: 14. 경연 참가
    ///14. 경연 참가
    
    func joinContest(castCode : String,
                     castTitle : String,
                     category : String,
                     castPath : String,
                     profileImage : String,
                     castType : String,
                     castStartDate : String,
                     castEndDate : String,
                     logoImage : String,
                     sortBig : String,
                     sortMid : String,
                     sortSmall : String,
                     location : String,
                     store : String,
                     product : String,
              complete : @escaping (_ succeed : Bool, _ resultInfo : JSON) -> Void)
    {
        
        var params = self.defaultParams()
        
        params["castCode"]        = castCode
        params["castId"]          = Static.userId
        params["watchCnt"]        = "0"
        params["castTitle"]       = castTitle
        params["category"]        = category
        params["castPath"]        = castPath
        params["nickName"]        = Static.userName
        params["profileImage"]    = profileImage
        params["castType"]        = castType
        params["castStartDate"]   = castStartDate
        params["castEndDate"]     = castEndDate
        params["episode"]         = "0"
        params["logoImage"]       = logoImage
        params["sortBig"]         = sortBig
        params["sortMid"]         = sortMid
        params["sortSmall"]       = sortSmall
        params["location"]        = location
        params["store"]           = store
        params["product"]         = product
        params["likes"]           = "0"
        params["accumWatchCnt"]   = Static.userProfileImage
        
        
        let url = Static.apiUrl + "startBroadCast"
        
        let completionHandler = {
            (_ succeed : Bool, _ json : JSON, _ resultInfo : JSON) -> Void in
            
            if succeed {
            }
            
            complete(succeed, resultInfo)
            
        }
        
        self.post(url: url, params: params, complete: completionHandler)
        
    }

    
    //MARK: 15. 경연 리스트
    ///15. 경연 리스트
    
    func loadContestList( complete: @escaping (_ succeed : Bool, _ contestList: [ContestInfo], _ resultInfo: JSON) -> Void) {
        let params : [String : String] = [:]
        
        let url = Static.apiUrl + "getContestList"
        
        let completionHandler = {
            (_ succeed : Bool, _ json : JSON, _ resultInfo : JSON) -> Void in
            
            var contestList : [ContestInfo] = []
            
            if succeed  {

                for info in resultInfo["data"].arrayValue {

                    let contest = ContestInfo()
                            
                    contest.setInfo(json: info)
                    contestList.append(contest)
                }
            }
            complete(succeed,contestList, resultInfo)
        }
        self.post(url: url, params: params, complete: completionHandler)
    }
    
    //MARK: 16. 공지사항 리스트
    ///16. 공지사항 리스트
    
    func loadNoticeList( complete: @escaping (_ succeed : Bool, _ noticeList: [NoticeInfo], _ resultInfo: JSON) -> Void) {
        let params : [String : String] = [:]
        
        let url = Static.apiUrl + "getNoticeList"
        
        let completionHandler = {
            (_ succeed : Bool, _ json : JSON, _ resultInfo : JSON) -> Void in
            
            var noticeList : [NoticeInfo] = []
            
            if succeed  {

                for info in resultInfo["data"].arrayValue {

                    let notice = NoticeInfo()
                            
                    notice.setInfo(json: info)
                    noticeList.append(notice)
                }
            }
            complete(succeed,noticeList, resultInfo)
        }
        self.post(url: url, params: params, complete: completionHandler)
    }
    
    //MARK: 17. 유저정보 수정
    ///17. 유저정보 수정
    
    func updateUserProfile(userProfileImage : String,nickName : String,userId : String, complete : @escaping (_ succeed : Bool, _ resultInfo : JSON) -> Void)
    {
        
        var params = self.defaultParams()
        
        params["userProfileImage"]           = userProfileImage
        params["nickName"]           = nickName
        params["userId"]           = userId
        
        let url = Static.apiUrl + "updateUserProfile"
        
        let completionHandler = {
            (_ succeed : Bool, _ json : JSON, _ resultInfo : JSON) -> Void in
            
            if succeed {
                
            }
            
            complete(succeed, resultInfo)
            
        }
        
        self.post(url: url, params: params, complete: completionHandler)
        
    }
    
    //MARK: 18. 회원가입
    ///18. 회원가입

    func join(userId : String,
              nickName : String,
              userPwd : String,
              userProfileImage : String,
              pushId : String,
              device : String,
              userDialCode : String,
              userNation : String,
              curCoin : String,
              recommendKey : String,
              coinPwd : String,
              complete : @escaping (_ succeed : Bool, _ resultInfo : JSON) -> Void)
    {
        
        var params = self.defaultParams()
        
        params["userId"]           = userId
        params["nickName"]           = nickName
        params["userPwd"]           = userPwd
        params["userProfileImage"]           = userProfileImage
        params["pushId"]           = pushId
        params["device"]           = device
        params["userDialCode"]           = userDialCode
        params["userNation"]           = userNation
        params["curCoin"]           = curCoin
        params["recommendKey"]           = recommendKey
        params["coinPwd"]           = coinPwd
        
        let url = Static.apiUrl + "join"
        
        let completionHandler = {
            (_ succeed : Bool, _ json : JSON, _ resultInfo : JSON) -> Void in
            
            if succeed {
                
                appData.set(userId, forKey: "userID")
                appData.set(userPwd, forKey: "userPw")
                appData.set(nickName, forKey: "userName")
                Static.userName = nickName
                appData.synchronize()
            }
            
            complete(succeed, resultInfo)
            
        }
        
        self.post(url: url, params: params, complete: completionHandler)
        
    }

    //MARK: 19. 추천코드 체크
    ///19. 추천코드 체크
    
    func checkRecommend(recommend : String, complete : @escaping (_ succeed : Bool, _ resultInfo : JSON) -> Void)
    {
        
        var params = self.defaultParams()
        
        params["recommend"]           = recommend
        
        let url = Static.apiUrl + "checkRecommend"
        
        let completionHandler = {
            (_ succeed : Bool, _ json : JSON, _ resultInfo : JSON) -> Void in
            
            if succeed {
                
            }
            
            complete(succeed, resultInfo)
            
        }
        
        self.post(url: url, params: params, complete: completionHandler)
        
    }
    
    //MARK: 20. 로그인
    ///20. 로그인
    
    func login(userID : String, userPw : String, complete : @escaping (_ succeed : Bool, _ resultInfo : JSON) -> Void)
    {
        
        var params = self.defaultParams()
        
        params["userId"]           = userID
        params["userPwd"]          = userPw
        params["pushId"]           = Static.pushId
        params["device"]           = "2"
        
        let url = Static.apiUrl + "login"
        
        let completionHandler = {
            (_ succeed : Bool, _ json : JSON, _ resultInfo : JSON) -> Void in
            
            if succeed {
                
                print("userPwd=" + userPw)
                appData.set(userID, forKey: "userID")
                appData.set(userPw, forKey: "userPw")
                print("appData.string(forKey: userPw)=" + appData.string(forKey: "userPw")!)
                appData.set(json["nickName"].stringValue, forKey: "userName")
                Static.userName = json["nickName"].stringValue
                Static.userProfileImage = json["userProfileImage"].stringValue
                appData.synchronize()
                
            }
            
            complete(succeed, resultInfo)
            
        }
        
        self.post(url: url, params: params, complete: completionHandler)
        
    }
    
    ///Common Post Request
    func post(url : String, params: [String : String], complete : @escaping (_ succeed : Bool, _ json : JSON, _ resultInfo : JSON) -> Void) {
        
        print("param : \(String(describing: params))")
        
        Alamofire.request(
            URL(string: url)!,
            method: .post,
            parameters: params)
            .validate()
            .responseJSON { (response) -> Void in
                print(response.request!)  // original URL request
                print(response.response!) // URL response
                print(response.data!)     // server data
                print(response.result)
                
                let resultString = NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue)! as String
                
                let json = JSON(resultString.data(using: .utf8)!)
                
                var resultJson = json
                var resultInfo = json
                let result = json["result"]
                
                if(json["data"] != nil){
                    resultJson = json["data"]
                    resultInfo = json
                }
                
                print("resultJson=\(resultJson)")
                print("resultString=" + resultString)
                
                if result == "0" {
                    complete(true, resultJson, resultInfo)
                }else{
                    complete(false, resultJson, resultInfo)
                    return
                }
        }
    }
}

extension NetworkHelper {
    
    //MARK: - Default Param
    func defaultParams() -> [String : String] {
        return ["":""]
    }
    
   
    
    //MARK: - get ResultInfo
    func getResultInfo(json: JSON) -> JSON {
    
        return json
        
    }
    
    func convertDicToString(_ inputDic: Dictionary<String, AnyObject>!) -> String!
    {
        var returnStr: String!
        returnStr = ""
        do
        {
            let data = try JSONSerialization.data(withJSONObject: inputDic as Any, options: JSONSerialization.WritingOptions.prettyPrinted)
            let body = NSString(data: data, encoding: String.Encoding.utf8.rawValue)! as String
            returnStr = body
        }
        catch _ {
            print("Dic to JSON Error:")
        }
        
        print(returnStr as Any)
        
        return returnStr
    }
    
    func getDateTimeSecondText()->String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        
        return formatter.string(from: Date())
    }
}
