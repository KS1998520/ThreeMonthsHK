//
//  HomeViewController.swift
//  ThreeMonths
//
//  Created by admin on 2020/10/29.
//

import UIKit
import Alamofire
import HandyJSON
import SwiftyJSON
import SnapKit
import MJRefresh
import SDWebImage


/// 列表
let titleHeadArry = ["社会","环保","科学","综合","汽车","互联网","农业"]
/// 新闻请求数量
let cellCount = 20

class HomeViewController: BaseNavViewController,TTHeadViewDelegate{
        
    let _cellModel = cellModel()
    let CELL = "TableViewCell"
    var imageCell: UIImage?
    var isurl: Bool = false
    var modelArry: [[String:Any]] = []
    var pageHeadView: PageHeadView?
    var tableViewCell: TableViewCell?
    var titleLabelH: CGFloat?
    var detailsUrls: [String] = []
    var newOffest: CGFloat = 0
    var newOldOffest: CGFloat = 0
    var titleIndex: Int = 0

    

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: CELL)
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    lazy var pageScrollew: PageScrollView = {
        let pageScrollew = PageScrollView()
        pageScrollew.frame = CGRect(x: 0, y: (pageHeadView?.frame.maxY)!, width: S_Width, height: S_Height - 94)
        pageScrollew.initScrollew(titleHeadArry.count)
        pageScrollew.delegate = self
        view.addSubview(pageScrollew)
        return pageScrollew
        
    }()
    
    lazy var MJ_header:  MJRefreshNormalHeader = {
        let MJ_header = MJRefreshNormalHeader()
        MJ_header.setRefreshingTarget(self, refreshingAction: #selector(refreshTableView))
        tableView.mj_header = MJ_header
        MJ_header.lastUpdatedTimeLabel?.isHidden = true
        MJ_header.setTitle("下拉刷新", for: .idle)
        MJ_header.setTitle("松开", for: .pulling)
        MJ_header.setTitle("刷新中..", for: .refreshing)
        return MJ_header
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        

        view.backgroundColor = .white
        self.baseNavView.backgroundColor = .red
        self.navType(.one)
        addPageHeadView()
        pageHeadView?.ttDelegste = self
        tableView.addSubview(MJ_header)
        
        pageScrollew.addSubview(tableView)
        

        _cellModel.getDataSwiftJson(cellCount,titleIndex,success:{[weak self](modelArry) in
            self!.modelArry = modelArry
            self!.changeTableView(self!.titleIndex)
        })
    }
    
    //刷新
    @objc func refreshTableView(){
        print("刷新")
        _cellModel.getDataSwiftJson(cellCount,titleIndex,success:{[weak self](modelArry) in
            self!.modelArry = modelArry
            self!.detailsUrls = []
            
            self!.tableView.reloadData()
            self!.tableView.mj_header?.endRefreshing()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                self!.changeTableView(self!.titleIndex)
            })
        })
    }
    
    func changeTableView(_ X: Int){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = CGRect(x: CGFloat(X) * S_Width, y: 0, width: S_Width, height: S_Height - 94)
    }
    
    // 头部init
    func addPageHeadView(){
        var setDefaultHead = TTHeadText()
        setDefaultHead.bottomLineW = 50
        setDefaultHead.selectColor = .gray

        let frame = CGRect(x: 0, y: Device.navBarH + Device.statusBarH, width: S_Width, height: 30)
        let _pageHeadView = PageHeadView(frame: frame, titles: titleHeadArry, delegates: self, ttText: setDefaultHead)
        pageHeadView = _pageHeadView
        self.view.addSubview(_pageHeadView)
    }
    
    //头部点击代理
    func selectTTHeadView(_ index: Int) {
        MJ_header.beginRefreshing()
        titleIndex = index
        print("头部titleIndex：\(titleIndex)")
        _cellModel.getDataSwiftJson(cellCount,titleIndex,success:{(modelArry) in
            self.modelArry = modelArry
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                self.changeTableView(index)
            })
        })
        
        pageScrollew.contentOffset.x = CGFloat(index) * S_Width
        
//        print("OffestX:\(pageScrollew.contentOffset.x)")
    }
    
}
//MARK:-- ScrollView
extension HomeViewController: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        var oldOffest:CGFloat = 0
//        print(pageScrollew.contentOffset.x)
        
        if pageScrollew.contentOffset.x - oldOffest > S_Width / 2{
            oldOffest = pageScrollew.contentOffset.x
            
            titleIndex = Int(pageScrollew.contentOffset.x / S_Width)
//            print("Offest\(pageScrollew.contentOffset.x)")
            
            pageHeadView?.collection.scrollToItem(at: IndexPath.init(row: titleIndex, section: 0), at: .centeredHorizontally, animated: true)
            pageHeadView?.currentGet(titleIndex)
            pageHeadView?.currentIndex = titleIndex
//            print(pageScrollew.contentOffset.x)
            if newOffest != pageScrollew.contentOffset.x{
                if newOffest - newOldOffest < -50{
                    refreshTableView()
                    newOldOffest = 0
                }
                
                newOffest = pageScrollew.contentOffset.x
                if newOffest.truncatingRemainder(dividingBy: S_Width) == 0{
                    newOldOffest = S_Width
                    refreshTableView()
                }
            }
        }
    }
}

//MARK：-- TableView
extension HomeViewController:UITableViewDelegate,UITableViewDataSource{
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeigth(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCount - 1
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL, for: indexPath) as! TableViewCell

        cell.titleLabel.text = (modelArry[indexPath.row]["title"])! as? String
        cell.timeLabel.text = (modelArry[indexPath.row]["ctime"])! as? String
        cell.fromLabel.text = (modelArry[indexPath.row]["description"])! as? String
        let imageURl = modelArry[indexPath.row]["picUrl"] as? String
        let _detailsUrl = modelArry[indexPath.row]["url"] as? String
        detailsUrls.append(_detailsUrl!)

        SDImageCache.shared.queryCacheOperation(forKey: imageURl){(image,date,cacheType) in
            if image != nil{
                cell.contentImage.image = image
                cell.titleLabel.snp.remakeConstraints{(m) -> Void in
                    m.top.equalTo(4)
                    m.left.equalTo(4)
                    m.width.equalTo(S_Width - 130)
                }
                cell.contentImage.snp.remakeConstraints{(m) -> Void in
                    m.top.equalTo(4)
                    m.right.equalTo(-4)
                    m.width.equalTo(120)
                    m.height.equalTo(80)                }
            }else{
                var isChangeSnapkit: Bool = true
                self.getImage(imageURl!, success: {(imagecell) in
                    DispatchQueue.main.async {
                        cell.contentImage.image = imagecell
                        
                    }
                    isChangeSnapkit = false
                    tableView.reloadData()
                })
                if isChangeSnapkit{

                    cell.titleLabel.snp.remakeConstraints{(m) -> Void in
                        m.top.equalTo(4)
                        m.left.equalTo(4)
                        m.width.equalTo(S_Width - 4)
                    }
                    cell.contentImage.snp.remakeConstraints{(m) -> Void in
                        m.width.height.equalTo(0)
                    }
                }
 
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let DetailsVC = DetailsViewController()
        self.hidesBottomBarWhenPushed = true
        DetailsVC.index = indexPath.row
        DetailsVC.detailsUrls = detailsUrls
        self.navigationController?.pushViewController(DetailsVC, animated: true)
        self.hidesBottomBarWhenPushed = false
        
    }
    //请求图片并缓存
    func getImage(_ urlString: String,success:@escaping(_ imagecell: UIImage) -> ()){
        SDWebImageManager.shared.loadImage(with: URL(string: urlString), options: .allowInvalidSSLCertificates, progress: {(receivedSize,expectedSize,url) in
        }, completed: {(image,data,erroe,cacheType,finish,imageUrl) in
            if image != nil{
                success(image!)
            }else{
                print("Error\(erroe!)")
                
            }
        })
    }

    //cell高度
    private func cellHeigth(_ index:Int) -> CGFloat{

        //无图片高度
        titleLabelH = getTitleLabelH(textStr: (modelArry[index]["title"])! as! String, font: UIFont.systemFont(ofSize: 14), width: S_Width - 4)
        
        //有图片高度
        SDImageCache.shared.queryCacheOperation(forKey: (modelArry[index]["picUrl"] as! String)){(image,date,cacheType) in
            if image != nil{
                self.titleLabelH = self.getTitleLabelH(textStr: (self.modelArry[index]["title"])! as! String, font: UIFont.systemFont(ofSize: 14), width: S_Width - 130)
            }else{
                self.getImage(self.modelArry[index]["picUrl"] as! String, success: {(imagecell) in
                    self.titleLabelH = self.getTitleLabelH(textStr: (self.modelArry[index]["title"])! as! String, font: UIFont.systemFont(ofSize: 14), width: S_Width - 130)
                    
                })
            }
        }
        let cellHeightBase = 94+Int(titleLabelH!)

        return CGFloat(cellHeightBase)
        
    }
    
    //titleLabel高度
    private func getTitleLabelH(textStr :  String, font : UIFont, width : CGFloat)  -> CGFloat{
            let normalText : NSString = textStr as NSString
            let size = CGSize(width: width, height:1000)
            let dic = NSDictionary(object: font, forKey : kCTFontAttributeName as! NSCopying)
            let stringSize = normalText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedString.Key:Any], context:nil).size
        
            return  stringSize.height
        }
}
