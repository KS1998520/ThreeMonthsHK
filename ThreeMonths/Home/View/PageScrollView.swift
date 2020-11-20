//
//  PageScrollView.swift
//  ThreeMonths
//
//  Created by admin on 2020/10/30.
//

import UIKit

class PageScrollView: UIScrollView{
    
    func initScrollew (_ titleCount: Int){
        
        self.backgroundColor = .white
        self.contentSize = CGSize(width: CGFloat(titleCount) * S_Width, height: self.bounds.height)
        self.isScrollEnabled = true
        self.isPagingEnabled = true
        self.showsHorizontalScrollIndicator = false
        
    }





}
