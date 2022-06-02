//
//  NoticeInfo.swift
//  CoverStar
//
//  Created by taehan park on 2022/06/01.
//

import UIKit
import SwiftyJSON

class NoticeInfo: NSObject {
    
    var id : String = ""
    var createdat : String = ""
    var updatedat : String = ""
    var videoUrl : String = ""
    var title : String = ""
    var content : String = ""
    var type : Int =  0
    var view_count : Int = 0
    var like_count : Int =  0
    var thumbnail : String = ""
    var open : Bool = false
    
    open func setClose(bool:Bool){
        open = bool
    }

    open func setInfo(json : JSON) {
        
        print("NoticeInfo=\(json)")
        
        id = json["id"].stringValue
        createdat = json["createdat"].stringValue
        updatedat = json["updatedat"].stringValue
        videoUrl = json["videoUrl"].stringValue
        title = json["title"].stringValue
        content = json["content"].stringValue
        type = json["type"].intValue
        view_count = json["view_count"].intValue
        like_count = json["like_count"].intValue
        thumbnail = json["thumbnail"].stringValue
    }
    
}
