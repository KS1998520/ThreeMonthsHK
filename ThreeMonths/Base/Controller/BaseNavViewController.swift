//
//  BaseNavViewController.swift
//  ThreeMonths
//
//  Created by admin on 2020/10/29.
//

import UIKit
import SnapKit

class BaseNavViewController: UIViewController {
    
    let baseNavView = BaseNavView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setBaseNavView()
    }
    
    
    private func setBaseNavView(){
        view.addSubview(baseNavView)
        baseNavView.snp.makeConstraints{(m) -> Void in
            m.left.top.right.equalTo(self.view)
            m.height.equalTo(Device.navBarH + Device.statusBarH)
        }
        baseNavView.leftButtonB = {[weak self] in
            let MyVC = MyViewController()
            self?.present(MyVC, animated: true, completion: nil)
        }
    }
    
    
    
    public func navType(_ type: NavViewType){
        self.baseNavView.navViewType = type
        
    }
    
    

    


}
