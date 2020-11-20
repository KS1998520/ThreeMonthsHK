//
//  PopWriteView.swift
//  ThreeMonths
//
//  Created by admin on 2020/11/4.
//

import UIKit

let space: CGFloat = 30

class PopWriteView: UIView {
    
    let textView = UITextView()
    let sendButton = UIButton()
    let labelPlach = UIButton()
    let imageButton = UIButton()
    let friendButton = UIButton()
    let circleButton = UIButton()
    let gifButton = UIButton()
    let cartooButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    func addUI(){
        
        self.addSubview(textView)
        textView.snp.makeConstraints{(m) -> Void in
            m.top.equalTo(5)
            m.left.equalTo(7)
            m.width.equalTo(S_Width - 100)
            m.height.equalTo(120)
        }
        
        self.addSubview(sendButton)
        sendButton.setTitle("确定", for: .normal)
        sendButton.addTarget(self, action: #selector(sendContent), for: .touchUpInside)
        sendButton.setTitleColor(.blue, for: .normal)
        sendButton.snp.makeConstraints{(m) -> Void in
            m.top.equalTo(5)
            m.right.equalTo(-7)
            m.width.equalTo(100)
            m.height.equalTo(150)
        }
        self.addSubview(imageButton)
        imageButton.setImage(UIImage(named: "chatroom_keyboard_28x28_"), for: .normal)
        imageButton.snp.makeConstraints{(m) -> Void in
            m.left.equalTo(80)
            m.top.equalTo(textView.snp.bottom).offset(5)
            m.width.height.equalTo(26)
        }
        self.addSubview(friendButton)
        friendButton.setImage(UIImage(named: "toolbar_icon_at_24x24_"), for: .normal)
        friendButton.snp.makeConstraints{(m) -> Void in
            m.left.equalTo(imageButton.snp.right).offset(10)
            m.top.equalTo(textView.snp.bottom).offset(5)
            m.width.height.equalTo(26)
        }
        self.addSubview(circleButton)
        circleButton.setImage(UIImage(named: "tabbar_icon_#_night_24x24_"), for: .normal)
        circleButton.snp.makeConstraints{(m) -> Void in
            m.left.equalTo(friendButton.snp.right).offset(10)
            m.top.equalTo(textView.snp.bottom).offset(5)
            m.width.height.equalTo(26)
        }
        self.addSubview(gifButton)
        gifButton.setImage(UIImage(named: "gif"), for: .normal)
        gifButton.snp.makeConstraints{(m) -> Void in
            m.left.equalTo(circleButton.snp.right).offset(10)
            m.top.equalTo(textView.snp.bottom).offset(5)
            m.width.height.equalTo(26)
        }
        self.addSubview(cartooButton)
        cartooButton.setImage(UIImage(named: "tabbar_icon_emoji_24x24_"), for: .normal)
        cartooButton.snp.makeConstraints{(m) -> Void in
            m.left.equalTo(gifButton.snp.right).offset(10)
            m.top.equalTo(textView.snp.bottom).offset(5)
            m.width.height.equalTo(26)
        }
        

    }
    @objc func sendContent(){
        print(textView.text!)
    }
    
}
