//
//  Example.swift
//  CoverStar
//
//  Created by taehan park on 2022/03/29.
//

import UIKit

//"uidx": 19,
//"phone": "82-1032851276",
//"login_id": "ODItMTAzMjg1MTI3Nl85Njg4ODJfMTY0NDIyNTc0MS4wNTg=",
//"grade": 0,
//"LANGUAGE": "ko",
//"NAME": "cho",
//"thumbnail_url": "/dt/005.png",
//"PROFILE": "",
//"reg_dt": "2022-02-07 18:22:21.0",
//"language": "ko",
//"name": "cho",
//"profile": ""

public class Example: NSObject {
    var uidx: Int = 0
    var phone: String = ""
    var login_id: String = ""
    var grade: Int = 0
    var language: String = ""
    var name: String = ""
    var profile: String = ""
    
    override init() {
        super.init()
    }
    
    init(dict: NSDictionary) {
        super.init()
        
        set(dict: dict)
    }
    
    func set(dict: NSDictionary) {
        self.uidx = (dict["uidx"] as? Int) ?? 0
        self.phone = ((dict["phone"] as? String) ?? "").trim()
        self.grade = (dict["grade"] as? Int) ?? 0
        self.login_id = ((dict["login_id"] as? String) ?? "").trim()
        self.language = ((dict["language"] as? String) ?? "").trim()
        self.name = ((dict["name"] as? String) ?? "").trim()
        self.profile = ((dict["profile"] as? String) ?? "").trim()
    }
    
    func get() -> NSDictionary {
        
        return [ "uidx": self.uidx,
          "phone": self.phone,
          "grade": self.grade,
          "login_id": self.login_id,
          "language": self.language,
          "name": self.name,
          "profile": self.profile
        ]
    }
}
