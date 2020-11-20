//
//  VideoViewController.swift
//  ThreeMonths
//
//  Created by admin on 2020/10/29.
//

import UIKit
import MJRefresh
import SDWebImage

let CELL = "VideoCollectionViewCell"
let num = 15

class VideoViewController: BaseNavViewController,UICollectionViewDelegate,UICollectionViewDataSource,WaterfallLayoutDataSource{
    
    var collection: UICollectionView?
    var mj_Header = MJRefreshHeader()
    var videoModels: [[String: Any]] = []
    var videoModel = VideoModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navType(.none)
        view.backgroundColor = .white
        
        
        videoModel.getDataSwiftJson(num, success: {(videoModel) in
            self.videoModels = videoModel
            self.addColleciontView()

        })

        
    }
    
    func addColleciontView(){
        let waterFL = WaterfallLayout()
        waterFL.dataSource = self
        waterFL.minimumLineSpacing = 7
        waterFL.minimumInteritemSpacing = 7
        
        let _collection = UICollectionView.init(frame: view.bounds, collectionViewLayout: waterFL   )
        _collection.delegate = self
        _collection.dataSource = self
        _collection.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: CELL)
        
        collection = _collection
        collection?.backgroundColor = .white
        
        view.addSubview(_collection)
        collection?.mj_header = mj_Header
        print("进入")
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return num - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL, for: indexPath) as! VideoCollectionViewCell
        var urlStrings:[[Int:String]] = []
        var infnoDic:[Int:String] = [:]
        let urlStringCoverurl = videoModels[indexPath.row]["coverurl"] as! String
        let urlStringAvatar = videoModels[indexPath.row]["avatar"] as! String
        cell.nameLabel.text = videoModels[indexPath.row]["author"] as? String
        infnoDic[0] = urlStringCoverurl
        infnoDic[1] = urlStringAvatar
        urlStrings.append(infnoDic)
        
        for i in 0..<urlStrings.count + 1{
            SDImageCache.shared.queryCacheOperation(forKey: urlStrings[0][i]){(image,respone,error) in
                if image != nil{
                    switch i {
                    case 0:
                        cell.titleImage.image = image
                        break
                    default:
                        cell.nameImage.image = image
                        break
                    }
                }else{
                    switch i {
                    case 0:
                        self.getImage(urlStrings[0][i]!, success: {(image) in
                            cell.titleImage.image = image
                        })
                        break
                    default:
                        self.getImage(urlStrings[0][i]!, success: {(image) in
                            cell.nameImage.image = image
                        })
                        break

                    }
                }

            }
        }
        
        return cell
    }
    //请求图片并缓存
    func getImage(_ urlString: String,success:@escaping(_ imagecell: UIImage) -> ()){
        SDWebImageManager.shared.loadImage(with: URL(string: urlString), options: .allowInvalidSSLCertificates, progress: {(receivedSize,expectedSize,url) in
        }, completed: {(image,data,erroe,cacheType,finish,imageUrl) in
            if image != nil{
                success(image!)
            }else{
                print("图片请求失败")
                
            }
        })
    }
    
    
    func waterfallLayout(_ layout: WaterfallLayout, indexPath: IndexPath) -> CGFloat {
        return CGFloat(arc4random_uniform(80) + 250)
    }

}

