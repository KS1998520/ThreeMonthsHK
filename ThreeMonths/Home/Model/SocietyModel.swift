//
//  HandJSon.swift
//  ThreeMonths
//
//  Created by admin on 2020/10/29.
//

import UIKit
import HandyJSON

struct responseModel: HandyJSON {

    var data:[headModel]?
    var error: Int!
}

struct headModel: HandyJSON {
    var newslist: String?
    var ctime: Date?
    var title: String?
    var description: String?
    var picUrl: String?
    var url: String?
}

class SocietyModel: NSObject {
    
    /// handyJSON
//    private func getData(){
//
//        let _num: Int = 3
//        let parament = ["num": _num]
//
//        let url = "http://api.tianapi.com/social/index?key=3921889315f58bfe9b52d1d5b16d5759"
//        Alamofire.request(url,parameters: parament).validate().responseString{(respone) in
//
//            guard respone.result.isSuccess else{
//                return
//            }
//            guard (respone.result.value != nil) else{
//                return
//            }
//            let jsonString = respone.result.value
//
//            if let _responseModel = JSONDeserializer<headModel>.deserializeFrom(json: jsonString){
//                print("==========\(_responseModel.toJSONString(prettyPrint: true)!)")
//
//                _responseModel.title?.forEach{(model) in
//                    print("-=-=\(model.utf8)")
//                }
//            }
//
//        }
//    }
    
    
    

}
