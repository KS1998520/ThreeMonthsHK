//
//  DetailsViewController.swift
//  ThreeMonths
//
//  Created by admin on 2020/11/4.
//

import UIKit
import WebKit
import Alamofire
import SnapKit

/// loading高宽
let loadingW: CGFloat = 50
let loadingH: CGFloat = 50

/// 弹出视图高
let popWriteViewH: CGFloat = 170

var scrollewH: CGFloat = S_Height


class DetailsViewController: BaseNavViewController{
    

    var index: Int?
    var detailsUrls:[String]?
    var writeView = UIView()
    var popWriteView = PopWriteView()
    var observation: NSKeyValueObservation?

    
    lazy var loadingImageView: UIImageView = {
        let loadingImageView = UIImageView()
        return loadingImageView
    }()
    

    lazy var scrollew: UIScrollView = {
       let scrollew = UIScrollView()
        scrollew.backgroundColor = .white
        return scrollew
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .blue
        return bgView
    }()
    
    lazy var WKContent: WKWebView = {
        let WKContent = WKWebView()
        let urlString = detailsUrls![index!]
        let url = URL(string: urlString)
        let urlRequest = URLRequest(url: url!)
        WKContent.load(urlRequest)
        WKContent.scrollView.isScrollEnabled = false
        WKContent.scrollView.bounces = false
        WKContent.navigationDelegate = self
        return WKContent
        
    }()
    
    lazy var commentView: CommentView = {
        let commentView = CommentView()
        return commentView
    }()

    
    lazy var bottomView: DetailsVCbottomView = {
        let bottomView = DetailsVCbottomView()
        bottomView.layer.shadowColor = UIColor.gray.cgColor
        bottomView.layer.shadowOffset = CGSize(width: -5, height: -5)
        bottomView.layer.masksToBounds = true
        bottomView.backgroundColor = .white
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints{(m) -> Void in
            m.bottom.equalTo(0)
            m.width.equalTo(S_Width)
            m.height.equalTo(44)
        }
        return bottomView
    }()
    
    override func viewDidLoad() {
        self.navType(.four)
        self.baseNavView.backgroundColor = #colorLiteral(red: 0.8993000388, green: 0.8994510174, blue: 0.8992801309, alpha: 1)
        self.baseNavView.leftButton.addTarget(self, action: #selector(leftButton), for: .touchUpInside)
        
        //监听键盘
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)

        super.viewDidLoad()
        view.addSubview(scrollew)
        scrollew.addSubview(bgView)
        bgView.addSubview(WKContent)

        bgView.addSubview(commentView)
        addConstraints()
        
        loadingImage()
        
        bottomView.bgButton.addTarget(self, action: #selector(bgButtonF), for: .touchUpInside)
        
    }
    
    func addConstraints(){
        scrollew.snp.makeConstraints{(m) -> Void in
            m.top.equalTo(Device.navBarH + Device.statusBarH)
            m.left.bottom.right.equalToSuperview()
        }
        
        bgView.snp.makeConstraints{(m) -> Void in
            m.top.left.bottom.equalTo(0)
            m.width.equalTo(S_Width)
            m.height.equalTo(S_Height + S_Height)
            
        }
        WKContent.snp.makeConstraints{(m) -> Void in
            m.width.equalTo(S_Width)
            m.top.left.right.equalTo(0)
            m.height.equalTo(scrollewH)
        }
        commentView.snp.makeConstraints{(m) -> Void in
            m.top.equalTo(WKContent.snp.bottom).offset(0)
            m.right.left.equalTo(0)
            m.height.equalTo(S_Height)
        }

    }
    func updateConstraints(_ newscrollewH: CGFloat){
        bgView.snp.remakeConstraints{(m) -> Void in
            m.top.left.bottom.equalTo(0)
            m.width.equalTo(S_Width)
            m.height.equalTo(newscrollewH + S_Height)
        }
        WKContent.snp.remakeConstraints{(m) -> Void in
            m.width.equalTo(S_Width)
            m.top.left.right.equalTo(0)
            m.height.equalTo(newscrollewH)
        }
    }

    //
    @objc func bgButtonF(){
        bottomView.writeTextView.becomeFirstResponder()
        popWriteView.textView.becomeFirstResponder()
    }
    //
    func observerWkHeight(){
        observation = WKContent.scrollView.observe(\UIScrollView.contentSize, options: [.new]){(_, change)  in
            
            let wkHeight = change.newValue!.height
            
            print(wkHeight)
            
        }
    }
    //监听获取键盘高度
    @objc func keyboardWillAppear(notification:Notification ){
        let keyboreInfo = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey]
        let endFrame = ((keyboreInfo as AnyObject).cgRectValue?.origin.y)
        let keyH = S_Height - endFrame!
        
        print("keyH:\(keyH)")
        
        animateWriteView(keyH)
    }
    
    
    //弹出动画
    func animateWriteView(_ keyH: CGFloat){
        popWriteView.frame = CGRect(x: 0, y: S_Height - keyH - popWriteViewH - CGFloat(50), width: S_Width, height: popWriteViewH)
        popWriteView.backgroundColor = #colorLiteral(red: 0.8993000388, green: 0.8994510174, blue: 0.8992801309, alpha: 1)
        WKContent.addSubview(popWriteView)
        let dAnimate = CAKeyframeAnimation(keyPath: "transform")
        dAnimate.duration = 0.3
        dAnimate.values = [[NSValue.init(caTransform3D: CATransform3DMakeScale(0.9, 0.9, 1.0))],[NSValue.init(caTransform3D: CATransform3DMakeScale(1.1, 1.1, 1.0))],[NSValue.init(caTransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0))]]
        dAnimate.keyTimes = [0.1,0.1,0.1]
        
        dAnimate.timingFunctions = [CAMediaTimingFunction.init(name: .easeInEaseOut),CAMediaTimingFunction.init(name: .easeInEaseOut)]
        
        popWriteView.layer.add(dAnimate, forKey: nil)
                
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        }

    @objc func leftButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    //loadingImage
    func loadingImage(){
        
        loadingImageView.tag = "loadingImageView".hash
        var imageArray: [AnyHashable] = []
        for i in 0..<8 {
            let image = UIImage(named: String(format: "sendloading_18x18_%d", i))
            if image != nil{
                imageArray.append(image)
            }
        }
        
        loadingImageView.frame = CGRect(x: (S_Width - loadingW) / 2 , y: (S_Height - loadingH) / 2, width: loadingW, height: loadingH)
        
        loadingImageView.animationDuration = 2
        loadingImageView.animationRepeatCount = 0
        loadingImageView.animationImages = imageArray as? [UIImage]

        WKContent.addSubview(loadingImageView)
        
    }
    
}
extension DetailsViewController:WKNavigationDelegate{
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        loadingImageView.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){

        loadingImageView.stopAnimating()
        
        var webheight = 0.0
         
        // 获取内容实际高度
        WKContent.evaluateJavaScript("document.body.scrollHeight") {[weak self](result, error) in
            if let tempHeight: Double = result as? Double {
                webheight = tempHeight
                scrollewH = CGFloat(tempHeight)
                print("webheight: \(webheight)")
                self!.updateConstraints(scrollewH)
            }
        }
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error){
//        self.timer.invalidate()
        print("页面加载失败")
    }

 
}



