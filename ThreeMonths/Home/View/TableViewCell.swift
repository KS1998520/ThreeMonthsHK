//
//  TableViewCell.swift
//  ThreeMonths
//
//  Created by admin on 2020/10/29.
//

import UIKit
import SnapKit

struct cellHeightList {
    let fromLabelH: CGFloat = 30
    let timeLabelH: CGFloat = 30
    let contentImageH: CGFloat = 80
    let buttonCancleH: CGFloat = 25
}

class TableViewCell: UITableViewCell {
    

    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        return titleLabel
    }()
    lazy var fromLabel: UILabel = {
        let fromLabel = UILabel()
        return fromLabel
    }()
    lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        return timeLabel
    }()
    lazy var contentImage: UIImageView = {
        let contentImage = UIImageView()
        return contentImage
    }()
    lazy var buttonCancle: UIButton = {
        let buttonCancle = UIButton()
        return buttonCancle
    }()
    var cellHeightlist = cellHeightList()
    
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
        addUI()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // 列表UI
    private func addUI(){
        
        contentView.addSubview(titleLabel)
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.snp.makeConstraints{(m) -> Void in
            m.top.equalTo(4)
            m.left.equalTo(4)
            m.width.equalTo(UIScreen.main.bounds.width - 130)
        }
        
        contentView.addSubview(fromLabel)
        fromLabel.font = UIFont.systemFont(ofSize: 10)
        fromLabel.snp.makeConstraints{(m) -> Void in
            m.top.equalTo(titleLabel.snp.bottom).offset(30)
            m.left.equalTo(4)
            m.width.equalTo(100)
            m.height.equalTo(cellHeightlist.fromLabelH)
        }
        
        contentView.addSubview(timeLabel)
        timeLabel.font = UIFont.systemFont(ofSize: 10)
        timeLabel.snp.makeConstraints{(m) -> Void in
            m.top.equalTo(titleLabel.snp.bottom).offset(30)
            m.left.equalTo(fromLabel.snp.right).offset(4)
            m.width.equalTo(120)
            m.height.equalTo(cellHeightlist.timeLabelH)
        }
        
        contentView.addSubview(contentImage)
        contentImage.contentMode = .scaleAspectFit
        contentImage.snp.makeConstraints{(m) -> Void in
            m.top.equalTo(4)
            m.right.equalTo(-4)
            m.width.equalTo(120)
            m.height.equalTo(80)
        }
        
        contentView.addSubview(buttonCancle)
        buttonCancle.setImage(UIImage(named: "add_textpage_17x12_"), for: .normal)
        buttonCancle.snp.makeConstraints{(m) -> Void in
            m.top.equalTo(fromLabel.snp.bottom).offset(5)
            m.width.height.equalTo(cellHeightlist.buttonCancleH)
            m.right.equalTo(-4)
        }
    }

}
