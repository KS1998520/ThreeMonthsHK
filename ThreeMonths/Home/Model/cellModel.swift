//
//  cellModel.swift
//  ThreeMonths
//
//  Created by admin on 2020/10/30.
//

import UIKit
import Alamofire
import SwiftyJSON


class cellModel: NSObject {
    var ModelArry: [[String:Any]] = []
    var url: String!
    
    /// SwiftJSON
    public func getDataSwiftJson(_ num: Int,_ index: Int,success:@escaping(_ modelArry:[[String:Any]]) -> Void){
        ModelArry = []
        print("MODELARRY\(ModelArry)")
        switch index {
        case 0:
            url = "http://api.tianapi.com/social/index?key=3921889315f58bfe9b52d1d5b16d5759"
            break
        case 1:
            url = "http://api.tianapi.com/lajifenleinews/index?key=3921889315f58bfe9b52d1d5b16d5759"
            break
        case 2:
            url = "http://api.tianapi.com/keji/index?key=3921889315f58bfe9b52d1d5b16d5759"
            break
        case 3:
            url = "http://api.tianapi.com/generalnews/index?key=3921889315f58bfe9b52d1d5b16d5759"
            break
        case 4:
            url = "http://api.tianapi.com/auto/index?key=3921889315f58bfe9b52d1d5b16d5759"
            break
        case 5:
            url = "http://api.tianapi.com/apple/index?key=3921889315f58bfe9b52d1d5b16d5759"
            break
        case 6:
            url = "http://api.tianapi.com/nongye/index?key=3921889315f58bfe9b52d1d5b16d5759"
            break
        default:
            return
        }
        /// 请求内容条数
        let _num: Int = num
        let parament = ["num": _num]

        var infoDic : [String:Any] = [:]

        
        Alamofire.request(url,parameters: parament).responseJSON{(respone) in
            guard respone.result.isSuccess else{
                return
            }
            if let resultValue = respone.result.value{
                let json = JSON(resultValue)
                for i in 0..<num{
                    if let title = json["newslist"][i]["title"].string{
                        infoDic["title"] = title
                    }
                    if let picUrl = json["newslist"][i]["picUrl"].string{
                        infoDic["picUrl"] = picUrl
                    }
                    if let description = json["newslist"][i]["description"].string{
                        infoDic["description"] = description
                    }
                    if let ctime = json["newslist"][i]["ctime"].string{
                        infoDic["ctime"] = ctime
                    }
                    if let url = json["newslist"][i]["url"].string{
                        infoDic["url"] = url
                    }
                    self.ModelArry.append(infoDic)
                    success(self.ModelArry)
//                    ModelArry = []
                    
                }
//                print("----------\(ModelArry)")
            }
        }
    }
}
    

