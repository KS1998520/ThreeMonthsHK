//
//  WaterfallLayout.swift
//  ThreeMonths
//
//  Created by admin on 2020/11/5.
//

import UIKit

// 瀑布流布局类
class WaterfallLayout: UICollectionViewFlowLayout {
    
    /// MARK:  数据源属性
    weak var dataSource: WaterfallLayoutDataSource?
    
    /// MARK:  属性数组，私有权限
    // private与fileprivate区别是，前者作用域是当前类，后者作用域是当前文件
    fileprivate lazy var attrsArray = [UICollectionViewLayoutAttributes]()
    
    /// 总高度
    fileprivate var totalHeight: CGFloat = 0
    
    /// 所有列的高度的数组
    fileprivate lazy var colHeights: [CGFloat] = {
        let cols = self.dataSource?.numbersOfColsInWaterfallLayout?(self) ?? 2
        var colHeights = Array(repeating: self.sectionInset.top, count: cols)
        return colHeights
    }()
    
    // 所有列中的最大高度
    fileprivate var maxH: CGFloat = 0
    fileprivate var startIndex = 0
}

// MARK: - 创建数据源协议

@objc protocol WaterfallLayoutDataSource: class {
    
    func waterfallLayout(_ layout: WaterfallLayout, indexPath: IndexPath) -> CGFloat
    @objc optional func numbersOfColsInWaterfallLayout(_ layout: WaterfallLayout) -> Int
}

// MARK: - 创建扩展

// 补充样式和属性
extension WaterfallLayout {
    
    /// 第一步 初始化，调用prepare来准备所有cell的布局样式
    override func prepare() {
        // 调用父类的准备方法
        super.prepare()
        
        // 1. 获取collectionView的分组中item的数量
        let itemCount = collectionView!.numberOfItems(inSection: 0)
        
        // 2. 获取列数
        let cols = dataSource?.numbersOfColsInWaterfallLayout?(self) ?? 2
        
        // 3. 计算item的宽度  (collectionView宽度 - 左右两边边距 - item间的间距) / 列数
        let itemW = ((collectionView?.bounds.width)! - self.sectionInset.left - self.sectionInset.right - self.minimumInteritemSpacing * CGFloat(cols - 1)) / CGFloat(cols)
        
        // 4. 计算所有的item的属性
        for i in startIndex ..< itemCount {
            
            // 4-1. 设置每一个Item位置相关的属性
            let indexPath = IndexPath(row: i, section: 0)
            
            // 4-2. 根据位置创建Attributes属性
            let attrs = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            // 4-3. 获取高度
            guard let height = dataSource?.waterfallLayout(self, indexPath: indexPath) else {
                 fatalError("数据源不存在，请先设置数据源并且实现数据源方法")
            }
            
            // 4-5. 获取高度最小列的位置
            var minH = colHeights.min()!
            let index = colHeights.firstIndex(of: minH)!
            minH = minH + height + minimumLineSpacing
            colHeights[index] = minH
            
            // 4-6. 设置item的属性
            attrs.frame = CGRect(x: self.sectionInset.left + (itemW + minimumInteritemSpacing) * CGFloat(index), y: minH - height - minimumLineSpacing, width: itemW, height: height)
            attrsArray.append(attrs)
        }
        
        // 5.记录最大值
        maxH = colHeights.max()!
        
        // 6. 对startIndex进行重新赋值
        startIndex = itemCount
    }
}

// 添加cell样式的扩展
extension WaterfallLayout {
    
    /// 返回设置cell样式的数组
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attrsArray
    }
    
    /// 返回当前的contentSize
    override var collectionViewContentSize: CGSize {
        return CGSize(width: 0, height: maxH + sectionInset.bottom - minimumLineSpacing)
    }
}
