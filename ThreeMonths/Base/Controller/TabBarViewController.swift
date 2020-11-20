//
//  TabBarViewController.swift
//  ThreeMonths
//
//  Created by admin on 2020/10/29.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewControllers()
    }
    
    
    /// 添加子控制器
    private func addChildViewControllers(){
        initChildViewControllre(HomeViewController(), "首页", "home_tabbar_32x32_", "home_tabbar_press_32x32_")
        initChildViewControllre(VideoViewController(), "小视频", "video_tabbar_32x32_", "video_tabbar_press_32x32_")
        initChildViewControllre(HuoshanViewController(), "生活圈", "huoshan_tabbar_32x32_", "huoshan_tabbar_press_32x32_")
        initChildViewControllre(MineViewController(), "设置", "mine_tabbar_32x32_", "mine_tabbar_press_32x32_")
    }
    
    /// 初始化
    private func initChildViewControllre(_ childControllre: UIViewController,_ title: String,_ imageName: String,_ selectImageName: String){
        childControllre.tabBarItem.title = title
        childControllre.tabBarItem.image = UIImage(named: imageName)
        childControllre.tabBarItem.selectedImage = UIImage(named: selectImageName)
        childControllre.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .selected)
        let Nac = NavViewController(rootViewController: childControllre)
        addChild(Nac)
    }
    
    


}
