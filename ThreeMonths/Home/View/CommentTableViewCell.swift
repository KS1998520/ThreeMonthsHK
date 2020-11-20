//
//  CommentTableViewCell.swift
//  ThreeMonths
//
//  Created by admin on 2020/11/11.
//

import UIKit


class CommentTableViewCell: UITableViewCell {
    
//    lazy var imageTitle: UIImageView = {
//        let imageTitle = UIImageView()
//        return imageTitle
//    }()
//
//    lazy var lableName: UILabel = {
//        let lableName = UILabel()
//        return lableName
//    }()
//
//    lazy var labelContent: UILabel = {
//        let labelContent = UILabel()
//        labelContent.numberOfLines = 0
//        return labelContent
//    }()
//
//    lazy var labelTime: UILabel = {
//        let labelTime = UILabel()
//        return labelTime
//    }()
//
//    lazy var buttonReply: UIButton = {
//        let buttonReply = UIButton()
//        buttonReply.setTitle("回复", for: .normal)
//        buttonReply.layer.cornerRadius = ImageH / 2
//        buttonReply.layer.masksToBounds = true
//        buttonReply.addTarget(self, action: #selector(replyButton), for: .touchUpInside)
//        return buttonReply
//    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCell.SelectionStyle.none
//        addUI()
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func replyButton(){
        
        
        
    }
    
    
//    func addUI(){
//        self.addSubview(imageTitle)
//        imageTitle.contentMode = .scaleToFill
//        imageTitle.layer.cornerRadius = 25
//        imageTitle.layer.masksToBounds = true
//        imageTitle.snp.makeConstraints{(m) -> Void in
//            m.top.left.equalTo(5)
//            m.height.width.equalTo(ImageH)
//        }
//
//        self.addSubview(lableName)
//        lableName.snp.makeConstraints{(m) -> Void in
//            m.top.equalTo(20)
//            m.left.equalTo(imageTitle.snp.right).offset(5)
//            m.width.equalTo(100)
//            m.height.equalTo(ImageH / 2)
//        }
//        self.addSubview(labelContent)
//        labelContent.snp.makeConstraints{(m) -> Void in
//            m.top.equalTo(imageTitle.snp.bottom).offset(5)
//            m.left.equalTo(5)
//            m.width.equalTo(screenW - 10)
//            m.height.equalTo(ImageH)
//        }
//
//        self.addSubview(labelTime)
//        labelTime.snp.makeConstraints{(m) -> Void in
//            m.top.equalTo(labelContent.snp.bottom).offset(5)
//            m.left.equalTo(5)
//            m.width.equalTo(100)
//            m.height.equalTo(ImageH / 2)
//        }
//
//        self.addSubview(buttonReply)
//        buttonReply.snp.makeConstraints{(m) -> Void in
//            m.top.equalTo(labelContent.snp.bottom).offset(5)
//            m.left.equalTo(labelTime.snp.right).offset(5)
//            m.width.equalTo(ImageH)
//            m.height.equalTo(ImageH / 2)
//        }
//
//
//
//    }


}
