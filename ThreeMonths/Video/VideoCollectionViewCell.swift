//
//  VideoCollectionViewCell.swift
//  ThreeMonths
//
//  Created by admin on 2020/11/5.
//

import UIKit

let nameImageW = 60
let nameImageH = 60

class VideoCollectionViewCell: UICollectionViewCell {

    
    let nameLabel = UILabel()
    let titleLabel = UILabel()
    let nameImage = UIImageView()
    let titleImage = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func addUI(){
        
        contentView.addSubview(titleImage)
        titleImage.snp.makeConstraints{(m) -> Void in
            m.top.left.right.bottom.equalTo(0)
        }
        titleImage.addSubview(nameImage)
        nameImage.layer.cornerRadius = 30
        nameImage.layer.masksToBounds = true
        nameImage.snp.makeConstraints{(m) -> Void in
            m.width.height.equalTo(nameImageH)
            m.right.equalTo(-5)
            m.bottom.equalTo(-5)
        }
        titleImage.addSubview(nameLabel)
        nameLabel.font = UIFont.systemFont(ofSize: 12)
        nameLabel.snp.makeConstraints{(m) -> Void in
            m.width.equalTo(80)
            m.right.equalTo(nameImage.snp.left).offset(-5)
            m.bottom.equalTo(-5)
        }
        
        titleImage.addSubview(titleLabel)
        titleLabel.numberOfLines = 0
        titleLabel.snp.makeConstraints{(m) -> Void in
            m.width.equalTo(self.bounds.width/2)
            m.height.equalTo(self.bounds.height/2)
            m.left.equalTo(10)
            m.top.equalTo(10)
        }
        
    }
    
    
}
