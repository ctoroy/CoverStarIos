//
//  ExampleInfo.swift
//  CoverStar
//
//  Created by taehan park on 2022/03/29.
//

import UIKit

class ExampleInfo: Example {
    
    func getUserInfo(completion: @escaping (_ success: Bool) -> ()) {
        
        let url = Static.apiUrl + "AnyUser/getUserInfo"
        let params = "phone=82-1032851276"
        
//        NetworkHelper.httpRequestPost(urlString: url, postString: params, completion: { dict in
////
////            print("[INFO] getUserInfo")
////
//            super.set(dict: dict["data"] as! NSDictionary)
////
//            print("[INFO] update() -> version:", self.uidx)
////
////            if self.pushid != self.token {
////
////                print("[INFO] pushid:", self.pushid)
////                print("[INFO] token:", self.token)
////
////                self.pushid = self.token
////            }
////
////            if self.id > 0 { self.save() }
//
            completion(self.uidx > 0)
//        })
    }
}
