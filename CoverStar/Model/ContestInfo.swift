//
//  ContestInfo.swift
//  CoverStar
//
//  Created by taehan park on 2022/06/04.
//

import UIKit

import SwiftyJSON

class ContestInfo: NSObject {

    var contestId : String = ""
    var contestTitle : String = ""
    var contestMaker : String = ""
    var contestType : String = ""
    var contestStartDate : String = ""
    var contestEndDate : String = ""
    var contestPayAmt : String = ""
    var contestCount : String = ""
    var contestAward : String = ""
    var contestShotDate : String = ""

    open func setInfo(json : JSON) {

        print("ContestInfo=\(json)")
        contestId = json["contestId"].stringValue
        contestTitle = json["contestTitle"].stringValue
        contestMaker = json["contestMaker"].stringValue
        contestType = json["contestType"].stringValue
        contestStartDate = json["contestStartDate"].stringValue
        contestEndDate = json["contestEndDate"].stringValue
        contestPayAmt = json["contestPayAmt"].stringValue
        contestCount = json["contestCount"].stringValue
        contestAward = json["contestAward"].stringValue
        contestShotDate = json["contestShotDate"].stringValue
    }
}
