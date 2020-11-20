//
//  BaseNavView.swift
//  ThreeMonths
//
//  Created by admin on 2020/10/29.
//

import UIKit
import SnapKit

enum NavViewType: Int{
    case one       //首页+西瓜视频
    case two       //微头条
    case three     //小视频
    case four      //无样式
    case none      //无
}

class BaseNavView: UIView {
    typealias leftButtonBlock = () -> ()
    
    var leftButtonB: leftButtonBlock!
    let leftButton = UIButton()
    let rightButton = UIButton()
    let searchView = UIView()
    let labelText = UIView()
    
    var ChangeBool: Bool!
    
    var navViewType: NavViewType = .none{
        didSet{
            switch self.navViewType {
            case .one:
                leftButton.setImage(UIImage(named: "home_no_login_head"), for: .normal)
                leftButton.addTarget(self, action: #selector(leftButtonClick), for: .touchUpInside)
                rightButton.setImage(UIImage(named: "home_camera"), for: .normal)
                ChangeBool = true
                addUI(ChangeBool)
                break
            case .two:
                leftButton.setImage(UIImage(named: "home_no_login_head"), for: .normal)
                rightButton.setImage(UIImage(named: "home_camera_night"), for: .normal)
                ChangeBool = false
                addUI(ChangeBool)
            case .three:
                print("头部三暂无")
                break
            case .four:
                leftButton.setImage(UIImage(named: "goBack"), for: .normal)
                ChangeBool = false
                addUI(ChangeBool)
                break
            default:
                break
            }
            
        }
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)

        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func leftButtonClick(){
        self.leftButtonB()
    }
    ///基础UI
   private func addUI(_ bool:Bool){
        self.addSubview(leftButton)
        leftButton.snp.makeConstraints{(m) -> Void in
            m.width.equalTo(30)
            m.height.equalTo(30)
            m.left.equalTo(10)
            m.bottom.equalTo(-4)
        }
        self.addSubview(rightButton)
        rightButton.snp.makeConstraints{(m) -> Void in
            m.width.equalTo(30)
            m.height.equalTo(30)
            m.right.equalTo(-10)
            m.bottom.equalTo(-3)
        }
        //判断
        if bool {
            self.addSubview(searchView)
            searchView.layer.cornerRadius = 7
            searchView.layer.masksToBounds = true
            searchView.backgroundColor = .white
            searchView.snp.makeConstraints{(m) -> Void in
                m.right.equalTo(rightButton.snp.left).offset(-5)
                m.left.equalTo(leftButton.snp.right).offset(5)
                m.bottom.equalTo(-6)
                m.height.equalTo(30)
            }
        }else{
            self.addSubview(searchView)
//            labelText.textAlignment = .center
//            labelText.snp.makeConstraints{(m) -> Void in
//                m.right.equalTo(rightButton.snp.left).offset(-5)
//                m.left.equalTo(leftButton.snp.right).offset(5)
//                m.bottom.equalTo(-6)
//                m.height.equalTo(30)
//                m.width.equalTo(100)
//            }
        }
    }
}
