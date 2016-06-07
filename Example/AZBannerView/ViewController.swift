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
        
        banner.imageUrls = ["", "", ""]
        
        banner.startAnimating()
        banner.delegate = self
    }
    
    func bannerView(bannerView: AZBannerView, didClick page: Int) {
        print("\(page)")
    }

}

