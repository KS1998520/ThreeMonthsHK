//
//  PageView.swift
//  ThreeMonths
//
//  Created by admin on 2020/10/30.
//

import UIKit

/// 选中
@objc public protocol TTHeadViewDelegate{
    func selectTTHeadView(_ index: Int)
}

public struct TTHeadText {
    ///默认文字颜色
    var defaultColor: UIColor = #colorLiteral(red: 0.6156026125, green: 0.8018091321, blue: 0.7627013326, alpha: 1)
    /// 默认文字大小
    var defaultFont: CGFloat = 14
    /// 选中文字颜色
    var selectColor: UIColor = .red
    /// 选中文字大小
    var selectTextFont: CGFloat = 15
    /// is下滑线
    var isBottomLine: Bool = true
    /// 下划线宽
    var bottomLineW: CGFloat = 0
    /// 下划线高
    var bottomLineH: CGFloat =  3
    /// item宽
    var ItemWith: CGFloat = 70
}

open class PageHeadView: UIView {
    
    var _titles: [String] = []
    var ttHeadText: TTHeadText!
    var ttDelegste: TTHeadViewDelegate?
    var currentIndex: Int = 0
    var collection: UICollectionView!
    
    var _bottonLineW: CGFloat = 0
    var _bottomLine: UILabel!
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 初始化
    /// - Parameters:
    ///   - frame: frame
    ///   - titles: 标题数组
    ///   - delegates: 协议
    ///   - ttText: 标题内容
   public init(frame: CGRect,titles:[String],delegates: TTHeadViewDelegate? = nil,ttText:TTHeadText!) {
        super.init(frame: frame)
        _titles = titles
        ttDelegste = delegates
        ttHeadText = ttText
        
    collection = colleciontView(CGRect (x: 0, y: 0, width: frame.width, height: frame.height))
        self.addSubview(collection)
    
    //下划线
    if ttHeadText.isBottomLine {
        
        if ttHeadText.bottomLineW > 0{
            _bottonLineW = ttHeadText.bottomLineW
            }else{
               _bottonLineW = ttHeadText.ItemWith * 0.5
            }
        
        _bottomLine = UILabel(frame: CGRect(x: (ttHeadText.ItemWith - _bottonLineW) / 2, y: collection.frame.height - ttHeadText.bottomLineH, width: _bottonLineW, height: ttHeadText.bottomLineH))
        _bottomLine.backgroundColor = .red
            
        _bottomLine.layer.cornerRadius = 2
        _bottomLine.layer.masksToBounds = true
        collection.addSubview(_bottomLine)
        }
    }
    
    //滑动
    func currentGet(_ index: Int){
        let _index = index
        var offest: CGFloat = 0
        if _index != 0 {
             offest = CGFloat(_index) * (ttHeadText.ItemWith + 5) + (ttHeadText.ItemWith - _bottonLineW) / 2
        }else{
            offest = (ttHeadText.ItemWith - _bottonLineW) / 2
        }
        UIView.animate(withDuration: 0.1, animations: {
            self._bottomLine.frame.size.width += 20
        })
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                UIView.animate(withDuration: 0.1, animations: {
                    self!._bottomLine.frame.size.width -= 20
                })

                self!._bottomLine.frame.origin.x = offest
            }, completion: nil)
        
        collection.reloadData()
    }
    
    func once(){
        collection.delegate = self
        collection.dataSource = self
    }
    
    private func colleciontView(_ frame:CGRect) -> UICollectionView {
        
        let _layout = UICollectionViewFlowLayout()
        _layout.itemSize = CGSize (width: ttHeadText.ItemWith, height: frame.height)
        _layout.minimumInteritemSpacing = 5
        _layout.minimumLineSpacing = 5
        _layout.scrollDirection = .horizontal
        
        let collectionview = UICollectionView(frame: frame, collectionViewLayout: _layout)
        collectionview.delegate  = self
        collectionview.dataSource = self
        collectionview.register(UICollectionViewCell.self, forCellWithReuseIdentifier: String (describing: UICollectionViewCell.self))
        collectionview.showsHorizontalScrollIndicator = false
        collectionview.showsVerticalScrollIndicator = false
        collectionview.backgroundView = nil
        collectionview.backgroundColor = .white
        return collectionview
        
        }
}


extension PageHeadView: UICollectionViewDelegate, UICollectionViewDataSource{
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _titles.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {


        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String (describing:UICollectionViewCell.self), for: indexPath)
        
        let title = _titles[indexPath.row]
        for _title in cell.contentView.subviews{
            _title.removeFromSuperview()
            
        }
        let labelTitle = UILabel.init(frame: CGRect(x: 0, y: 0, width: ttHeadText.ItemWith, height: self.bounds.height))
        labelTitle.font = UIFont.systemFont(ofSize: currentIndex == indexPath.row ? ttHeadText.selectTextFont: ttHeadText.defaultFont)
        labelTitle.textAlignment = .center
        labelTitle.text = title
        labelTitle.textColor = (currentIndex == indexPath.row ? ttHeadText.defaultColor: ttHeadText.selectColor)
        cell.contentView.addSubview(labelTitle)
        
        return cell
        
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if ttDelegste != nil{
            ttDelegste?.selectTTHeadView(indexPath.row)
        }
        print(indexPath.row)
        currentGet(indexPath.row)
        currentIndex = indexPath.row
        collection.reloadData()
    }

}
