//
//  ViewController.swift
//  SuperBars
//
//  Created by Raul Rashuaman on 4/11/16.
//  Copyright © 2016 Raul Rashuaman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
        
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let barView = BarView()
        barView.maxValue = 100
        view.addSubview(barView)
        
        barView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.view.snp_left)
            make.right.equalTo(self.view.snp_right)
            make.top.equalTo(self.view.snp_top).offset(10)
            make.bottom.equalTo(self.view.snp_bottom).offset(-10)
        }
        
        barView.backgroundColor = .yellowColor()
        
        barView.items = [BarElement(title: "title", value: 100), BarElement(title: "title2", value: 90), BarElement(title: "title2", value: 80), BarElement(title: "title2", value: 70), BarElement(title: "title2", value: 60), BarElement(title: "title2", value: 50)]
        barView.showBars()
        
    }
}

