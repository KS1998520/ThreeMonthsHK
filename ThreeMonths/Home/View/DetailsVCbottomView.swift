//
//  DetailsVCbottomView.swift
//  ThreeMonths
//
//  Created by admin on 2020/11/4.
//

import UIKit
import SnapKit


class DetailsVCbottomView: UIView {

    let bgButton = UIButton()
    let likeButton = UIButton()
    let goodButton = UIButton()
    let shareButton = UIButton()
    let messageButton = UIButton()
    let writeImage = UIImageView()
    let writeLabel = UILabel()
    let writeTextView = UITextView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addUI(){
        let space: CGFloat = 10
        let baseButtonW = (S_Width - space * 6)/7

        self.addSubview(bgButton)
        
//        bgButton.setImage(UIImage(named: "bgbutton-1"), for: .normal)
        bgButton.setBackgroundImage(UIImage(named: "bgbutton-1"), for: .normal)
        bgButton.snp.makeConstraints{(m) -> Void in
            m.top.equalTo(4)
            m.left.equalTo(10)
            m.height.equalTo(32)
            m.width.equalTo(baseButtonW * 3)
        }
        self.addSubview(messageButton)
        messageButton.addTarget(self, action: #selector(messageButtonF), for: .touchUpInside)
        messageButton.setImage(UIImage(named: "message"), for: .normal)
        messageButton.snp.makeConstraints{(m) -> Void in
            m.top.equalTo(2)
            m.left.equalTo(bgButton.snp.right).offset(space)
            m.height.equalTo(36)
            m.width.equalTo(baseButtonW)
        }

        self.addSubview(likeButton)
        likeButton.addTarget(self, action: #selector(likeButtonF), for: .touchUpInside)
        likeButton.setImage(UIImage(named: "dislike"), for: .normal)
        likeButton.setImage(UIImage(named: "like"), for: .selected)
        likeButton.snp.makeConstraints{(m) -> Void in
            m.top.equalTo(2)
            m.left.equalTo(messageButton.snp.right).offset(space)
            m.height.equalTo(36)
            m.width.equalTo(baseButtonW)
        }
        self.addSubview(goodButton)
        goodButton.addTarget(self, action: #selector(goodButtonF), for: .touchUpInside)
        goodButton.setImage(UIImage(named: "nogood"), for: .normal)
        goodButton.setImage(UIImage(named: "good"), for: .selected)
        goodButton.snp.makeConstraints{(m) -> Void in
            m.top.equalTo(2)
            m.left.equalTo(likeButton.snp.right).offset(space)
            m.height.equalTo(36)
            m.width.equalTo(baseButtonW)
        }
        self.addSubview(shareButton)
        shareButton.addTarget(self, action: #selector(shareButtonF), for: .touchUpInside)
        shareButton.setImage(UIImage(named: "share"), for: .normal)
        shareButton.snp.makeConstraints{(m) -> Void in
            m.top.equalTo(2)
            m.left.equalTo(goodButton.snp.right).offset(space)
            m.height.equalTo(36)
            m.width.equalTo(baseButtonW)
        }
        bgButton.addSubview(writeImage)
        writeImage.image = UIImage(named: "write")
        writeImage.snp.makeConstraints{(m) -> Void in
            m.left.equalTo(5)
            m.top.equalTo(5)
            m.width.height.equalTo(26)
        }
        
        bgButton.addSubview(writeLabel)
        writeLabel.isEnabled = true
        writeLabel.text = "写评论..."
        writeLabel.font = UIFont.systemFont(ofSize: 12)
        writeLabel.snp.makeConstraints{(m) -> Void in
            m.left.equalTo(writeImage.snp.right).offset(7)
            m.top.equalTo(5)
            m.height.equalTo(26)
        }
        
        bgButton.addSubview(writeTextView)
        
    }

    @objc func messageButtonF(){
        
    }
    @objc func likeButtonF(){
        
    }
    @objc func goodButtonF(){
        
    }
    @objc func shareButtonF(){
        
    }
    


}
