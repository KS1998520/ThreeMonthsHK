//
//  Device.swift
//  3DCamera
//
//  Created by Zy on 2020/8/18.
//  Copyright © 2020 Zy. All rights reserved.
//

import UIKit

public struct Device {
    
    /// 是否为模拟器
    public static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
        isSim = true
        #endif
        return isSim
    }()
    
    /// 是否为iPad
    public static let isIpad: Bool = {
        return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad)
    }()
    
    ///判断是不是iOS 11
    public static let iOS11 : Bool = {
        var state = false
        if #available(iOS 11, *) {
            state = true
            if #available(iOS 12.0, *) {
                state = false
            }
        }
        return state
    }()
    
    /// 是否为全面屏手机
    public static let isFullScreen: Bool = {
        return (Screen.is4_0 == false && Screen.is4_7 == false && Screen.is5_5 == false) && (Device.isIpad == false)
    }()
    
    /// 屏幕宽度
    public static let screenWidth: CGFloat = {
        return Screen.main.bounds.width
    }()
    /// 屏幕高度
    public static let screenHeight: CGFloat = {
        return Screen.main.bounds.height
    }()
    
    //判断是否是刘海屏幕（上面的方法判断不对）
    public static var isLiuHai: Bool {
        if #available(iOS 11, *) {
              guard let w = UIApplication.shared.delegate?.window, let unwrapedWindow = w else {
                  return false
              }
              
              if unwrapedWindow.safeAreaInsets.left > 0 || unwrapedWindow.safeAreaInsets.bottom > 0 {
//                  print(unwrapedWindow.safeAreaInsets)
                  return true
              }
        }
        return false
    }
    
    /// 导航栏高度
    public static let navBarH: CGFloat = 44
    
    /// tabbar高度
    public static let tabBarH: CGFloat = {
        if Device.isFullScreen {
            return 83
        }
        return 49
    }()
    
    /// 状态栏高度
    public static let statusBarH: CGFloat = {
        if Device.isLiuHai {
            return 44
        }
        return 20
    }()
    
    
    /// 底部安全栏高度
    public static let bottomSafeAreaH: CGFloat = {
        if Device.isLiuHai {
            return 34
        }
        return 0
    }()
}

// MARK: - 应用信息
extension Device {
    
    /// App名称
    public static let appName = Bundle.main.infoDictionary!["CFBundleDisplayName"] as? String
    /// App的版本号
    public static let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String
    /// App Bundle版本
    public static let bundleVersion = Bundle.main.infoDictionary!["CFBundleVersion"] as? String
    

}

// MARK: - 设备信息
//extension Device {
//    ///设备具体型号（如：iPhone 7 Plus）
//    public static let modelName = UIDevice.current.modelName
//    
//    ///设备系统版本号（如：iOS 10.3.3）
//    public static let sysVersion = UIDevice.current.systemVersion
//
//    /// 设备 uuid
//    public static let uuid = DCNcsStDeviceInfo.dCUDIDString() ?? UIDevice.current.identifierForVendor!.uuidString//设备udid
//
//    ///设备用户自定义名称
//    public static let name = UIDevice.current.name
//
//    ///设备系统名称
//    public static let systemName = UIDevice.current.systemName
//
//    /// 设备型号（如：iphone/ipad等）
//    public static let model = UIDevice.current.model
//
//    /// 设备区域化型号如A1533
//    public static let localizedModel = UIDevice.current.localizedModel
//
//    //不要在Device中加入Local相关的内容，该内容已迁移回Local
//}

extension UIDevice {
    //获取设备具体详细的型号
    fileprivate var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
            
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1":                               return "iPhone 7 (CDMA)"
        case "iPhone9,3":                               return "iPhone 7 (GSM)"
        case "iPhone9,2":                               return "iPhone 7 Plus (CDMA)"
        case "iPhone9,4":                               return "iPhone 7 Plus (GSM)"
        case "iPhone10,1","iPhone10,4":                 return "iPhone 8"
        case "iPhone10,2","iPhone10,5":                 return "iPhone 8 Plus"
        case "iPhone10,3","iPhone10,6":                 return "iPhone X"
        case "iPhone11,2":                              return "iPhone XS"
        case "iPhone11,4","iPhone11,6":                 return "iPhone XS Max"
        case "iPhone11,8":                              return "iPhone XR"
        case "iPhone12,1":                              return "iPhone 11"
        case "iPhone12,3":                              return "iPhone 11 Pro"
        case "iPhone12,5":                              return "iPhone Pro Max"
            
            
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7-inch)"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9-inch)"
        case "iPad6,11", "iPad6,12":                    return "iPad 5"
        case "iPad7,1", "iPad7,2":                      return "iPad Pro 2 (12.9-inch)"
        case "iPad7,3", "iPad7,4":                      return "iPad Pro 2 (10.5-inch)"
        case "iPad7,5", "iPad7,6":                      return "iPad 6"
        case "iPad7,11", "iPad7,12":                    return "iPad 7"
            
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
}
