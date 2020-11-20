//
//  VideoModel.swift
//  ThreeMonths
//
//  Created by admin on 2020/11/5.
//

import UIKit
import Alamofire
import SwiftyJSON

class VideoModel: NSObject {
    var videoModel:[[String:Any]] = []
    
    public func getDataSwiftJson(_ num:Int,success:@escaping(_ videoModel:[[String:Any]]) -> ()){
        let url = "http://api.tianapi.com/txapi/dyvideohot/index?key=3921889315f58bfe9b52d1d5b16d5759"
        
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
                for i in 0..<num - 1{
                    if let hotindex = json["newslist"][i]["hotindex"].string{
                        infoDic["hotindex"] = hotindex
                    }
                    if let durationTime = json["newslist"][i]["duration"].string{
                        infoDic["duration"] = durationTime
                    }
                    if let playaddr = json["newslist"][i]["playaddr"].string{
                        infoDic["playaddr"] = playaddr
                    }
                    if let coverurl = json["newslist"][i]["coverurl"].string{
                        infoDic["coverurl"] = coverurl
                    }
                    if let title = json["newslist"][i]["title"].string{
                        infoDic["title"] = title
                    }
                    if let author = json["newslist"][i]["author"].string{
                        infoDic["author"] = author
                    }
                    if let avatar = json["newslist"][i]["avatar"].string{
                        infoDic["avatar"] = avatar
                    }
                    self.videoModel.append(infoDic)
                }
                success(self.videoModel)

            }
        }
    }
}
    
