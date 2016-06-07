//
//  ViewController.swift
//  AZBannerView
//
//  Created by Abner Zhong on 06/07/2016.
//  Copyright (c) 2016 Abner Zhong. All rights reserved.
//

import UIKit
import AZBannerView

class ViewController: UIViewController, AZBannerViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let banner = AZBannerView()
        banner.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 200)
        banner.backgroundColor = UIColor.grayColor()
        self.view.addSubview(banner)
        
        banner.imageUrls = [
            "http://c.hiphotos.baidu.com/zhidao/pic/item/8435e5dde71190ef6c6acea8c91b9d16fdfa6037.jpg",
            "http://c.hiphotos.baidu.com/zhidao/pic/item/8435e5dde71190ef6c6acea8c91b9d16fdfa6037.jpg",
            "http://h.hiphotos.baidu.com/zhidao/wh%3D450%2C600/sign=5f39345051e736d15846840cae6063f4/6c224f4a20a44623eec0dfee9d22720e0cf3d730.jpg"
        ]
        
        banner.startAnimating()
        banner.delegate = self
    }
    
    func bannerView(bannerView: AZBannerView, didClick page: Int) {
        print("\(page)")
    }

}

