//
//  BarView.swift
//  SuperBars
//
//  Created by Raul Rashuaman on 4/11/16.
//  Copyright © 2016 Raul Rashuaman. All rights reserved.
//

import UIKit
import SnapKit

class BarView: UIView {
    var maxValue : UInt = 0
    var items : Array<BarElement>?
    
    let viewOffset = 10
    var viewsHeight = 2
    
    func showBars() {
        guard let safeItems = items else {
            return
        }

        var previousView : UIView = self
        var firstView : UIView? = nil
        for item in safeItems {
            let itemView = itemBarView(item)
            
            if (firstView == nil) {
                firstView = itemView
            }
            
            itemView.snp_makeConstraints { (make) -> Void in
                make.left.equalTo(self.snp_left).offset(viewOffset)
                make.right.equalTo(self.snp_right).offset(-viewOffset)
                make.height.equalTo(viewsHeight)
                if (item === safeItems[0]) {
                    make.top.equalTo(previousView.snp_top).offset(viewOffset)
                } else {
                    make.top.equalTo(previousView.snp_bottom).offset(viewOffset)
                }
            }
            previousView = itemView
        }
    }
    
    private func itemBarView(item : BarElement) -> UIView {
        let barView = Bar()
        barView.value = item.value
        barView.maxValue = self.maxValue
        
        barView.sizeToFit()
        addSubview(barView)
        

        
        return barView
    }

}

class Bar : UIView {
    var value : UInt = 0
    var maxValue : UInt = 1
    
    override func layoutSubviews() {
        let subView = UIView(frame: CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: 0.0, height: self.frame.height))
        subView.backgroundColor = .blueColor()
        self.addSubview(subView)
        UIView.animateWithDuration(1.5) { () -> Void in
            var subFrame = self.bounds
            subFrame.size.width = (CGFloat(self.value) / CGFloat(self.maxValue)) * self.frame.width
            subView.frame = subFrame
        }
    }
    
    
}

class BarElement {
    var title : String?
    var value : UInt = 0
    init (title: String?, value : UInt) {
        self.title = title
        self.value = value
    }
}