//
//  CastInfo.swift
//  CoverStar
//
//  Created by taehan park on 2022/06/01.
//

import UIKit
import SwiftyJSON

class CastInfo: NSObject {
    
    ///방송코드
    var castCode            : String    = ""
    
    ///방송자 아이디
    var castId          : String    = ""
    
    ///시청수
    var watchCnt            : Int    = 0
    
    var category            : Int = 0
    
    ///방송제목
    var castTitle           : String    = ""
    
    ///방송경로 (참조)
    var castPath            : Int = 0
    
    var castType            : Int = 0

    ///방송자 닉네임
    var nickName            : String    = ""
    
    ///방송자 프로필이미지
    var profileImage           : String    = ""
    

    ///방송 시작 시간코드
    var castStartDate       : String    = ""
    
    var castEndDate       : String    = ""
    
    var logoImage       : String    = ""
    
    var sortBig       : String    = ""
    
    var sortMid       : String    = ""
    
    var sortSmall       : String    = ""
    
    var location       : String    = ""
    
    var store       : String    = ""
    
    var product       : String    = ""
    
    var keyword       : String    = ""
    
    var likes       : String    = ""
    
    var accumWatchCnt       : String    = ""
    
    
    
    open func setInfo(json : JSON) {
        
        if json["castCode"].stringValue != "" {
            castCode = json["castCode"].stringValue
        }
        
        if json["castId"].stringValue != "" {
            castId = json["castId"].stringValue
        }
        
        if json["watchCnt"].stringValue != "" {
            watchCnt = json["watchCnt"].intValue
        }
        
        if json["category"].stringValue != "" {
            category = json["category"].intValue
        }
        
        if json["castTitle"].stringValue != "" {
            castTitle = json["castTitle"].stringValue
        }
        
        if json["castPath"].stringValue != "" {
            castPath = json["castPath"].intValue
        }
        
        if json["castType"].stringValue != "" {
            castType = json["castType"].intValue
        }
        
        if json["nickName"].stringValue != "" {
            nickName = json["nickName"].stringValue
        }
        
        if json["profileImage"].stringValue != "" {
            profileImage = json["profileImage"].stringValue
        }
        
        if json["castStartDate"].stringValue != "" {
            castStartDate = json["castStartDate"].stringValue
        }
        
        if json["castEndDate"].stringValue != "" {
            castEndDate = json["castEndDate"].stringValue
        }
        
        if json["logoImage"].stringValue != "" {
            logoImage = json["logoImage"].stringValue
        }
        
        if json["sortBig"].stringValue != "" {
            sortBig = json["sortBig"].stringValue
        }
        
        if json["sortMid"].stringValue != "" {
            sortMid = json["sortMid"].stringValue
        }
        
        if json["sortSmall"].stringValue != "" {
            sortSmall = json["sortSmall"].stringValue
        }
        
        if json["location"].stringValue != "" {
            location = json["location"].stringValue
        }
        
        if json["store"].stringValue != "" {
            store = json["store"].stringValue
        }
        
        if json["product"].stringValue != "" {
            product = json["product"].stringValue
        }
        
        if json["keyword"].stringValue != "" {
            keyword = json["keyword"].stringValue
        }
        
        if json["likes"].stringValue != "" {
            likes = json["likes"].stringValue
        }
        
        if json["accumWatchCnt"].stringValue != "" {
            accumWatchCnt = json["accumWatchCnt"].stringValue
        }
    }
    
}

