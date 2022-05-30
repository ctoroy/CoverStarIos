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
    
    //MARK: 18. 회원가입
    ///18. 회원가입
    ///
    ///@RequestParam("userId") final String userId,
//    @RequestParam("nickName") String nickName,
//    @RequestParam("userPwd") String userPwd,
//    @RequestParam("userProfileImage") String userProfileImage,
//    @RequestParam("pushId") String pushId,
//    @RequestParam("device") String device,//android:1 ios:2
//    @RequestParam("userDialCode") String userDialCode,//82
//    @RequestParam("userNation") String userNation //KR,
//    @RequestParam("curCoin") String curCoin //가입시 추천해서 성공한 사람은 3으로 보냄 아니면 0으로 보냄,
//    @RequestParam("recommendKey") String recommendKey
//    @RequestParam("coinPwd") String coinPwd //coinPwd

    
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
                
                appData.set(userID, forKey: "userID")
                appData.set(userPw, forKey: "userPw")
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
    
    
//    //MARK: - Encoding
//    func getEncodedData(param : [String : String]) -> Data {
//        let imsiPara = "data=" + self.base64Encode(self.convertDicToString(param as Dictionary<String, AnyObject>?))
//
//        return imsiPara.data(using: String.Encoding.utf8)!
//    }
    
//    func base64Encode(_ inutStr: String!) -> String!
//    {
//        var plainData = (inutStr as NSString).data(using: String.Encoding.utf8.rawValue)
//        var base64String = plainData!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
//        let reversed = String(base64String.characters.reversed())
//        plainData = (reversed as NSString).data(using: String.Encoding.utf8.rawValue)
//        base64String = plainData!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
//        print(base64String)
//        return base64String
//    }
//
//    func base64Decode(_ inutStr: String!) -> String!
//    {
//        var decodedData = Data(base64Encoded: inutStr, options:NSData.Base64DecodingOptions(rawValue: 0))
//        var decodedString = NSString(data: decodedData!, encoding: String.Encoding.utf8.rawValue) as! String
//        let reversed = String(decodedString.characters.reversed())
//        decodedData = Data(base64Encoded: reversed, options:NSData.Base64DecodingOptions(rawValue: 0))
//        decodedString = NSString(data: decodedData!, encoding: String.Encoding.utf8.rawValue) as! String
//        return decodedString
//    }
    
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
