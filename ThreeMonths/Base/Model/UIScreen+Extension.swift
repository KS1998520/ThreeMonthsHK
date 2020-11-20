//
//  UIScreen+Extension.swift
//  3DCamera
//
//  Created by Zy on 2020/8/17.
//  Copyright © 2020 Zy. All rights reserved.

import UIKit


public typealias Screen = UIScreen

public extension UIScreen {
    
    class var width : CGFloat {
        return UIScreen.main.bounds.width
    }
    
    class var  height: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    class var  centerX: CGFloat {
        return UIScreen.main.bounds.width * 0.5
    }
    
    class var  centerY: CGFloat {
        return UIScreen.main.bounds.height * 0.5
    }
    
    class var  center: CGPoint {
        return CGPoint(x: UIScreen.centerX, y: UIScreen.centerY)
    }
    
    class var  isiPhoneXScreen: Bool {
        guard #available(iOS 11.0, *) else {
            return false
        }
        return UIApplication.shared.windows[0].safeAreaInsets.top > 20.0
    }
    
    class var statusBarHeight: CGFloat {
        return isiPhoneXScreen ? 44.0 : 20.0
    }
    
    class var  bottomSafeMargin: CGFloat {
        return isiPhoneXScreen ? 34.0 : 0.0
    }
    
    /// 4.0寸屏幕
    class var is4_0: Bool {
        return (Screen.width == 320.0 && Screen.height == 568.0)
    }
    
    
    /// 4.7寸
    class var is4_7: Bool {
        return (Screen.width == 375.0 && Screen.height == 667.0)
    }
    
    
    /// 5.5寸
    class var is5_5: Bool {
        return (Screen.width == 414.0 && Screen.height == 736.0)
    }
    
    
    /// 5.8寸
    class var is5_8: Bool {
        return (Screen.width == 375.0 && Screen.height == 812.0)
    }
    
    
    /// 6.1寸
    class var is6_1: Bool {
        return (Screen.width == 414.0 && Screen.height == 896.0)
    }
    
    
    /// 6.5寸
    class var is6_5: Bool {
        return (Screen.width == 414.0 && Screen.height == 896.0)
    }
}

