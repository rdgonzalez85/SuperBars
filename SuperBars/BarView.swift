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
    var maxValue : UInt = 1
    var items : Array<BarElement>?
    var colors : Array<CGColor> = [UIColor.orangeColor().CGColor, UIColor.blueColor().CGColor, UIColor.redColor().CGColor]
    var viewOffset = 10
    var viewsHeight = 3
    
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
        barView.offset = CGFloat(self.viewOffset)
        barView.colors = self.colors
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
    var animationDuration : Double = 0.5
    var offset : CGFloat = 10
    var colors : Array<CGColor> = Array<CGColor>()
    
    override func layoutSubviews() {
        var subFrame = self.bounds
        subFrame.size.width = (CGFloat(self.value) / CGFloat(self.maxValue)) * self.frame.width
        
        let gradient:CAGradientLayer = self.gradient(subFrame)
        layer.insertSublayer(gradient, atIndex: 0)
        self.animations(layer)
    }
    
    func gradient(frame:CGRect) -> CAGradientLayer {
        let layer = CAGradientLayer()
        layer.frame = frame

        layer.startPoint = CGPointMake(0,0.5)
        layer.endPoint = CGPointMake(1,0.5)

        if colors.count > 0 {
            layer.colors = colors
        }

        return layer
    }

    func animations(layer : CALayer) {
        layer.anchorPoint = CGPointMake(0, 1.0);
        let widthAnim = CABasicAnimation(keyPath: "transform.scale.x")
        widthAnim.fromValue = 0
        widthAnim.toValue = 1
        widthAnim.fillMode = kCAFillModeBoth
        widthAnim.duration = animationDuration
        layer.addAnimation(widthAnim, forKey: "transform.scale.x")
        
        // update layer's frame
        var frame = layer.frame
        frame.origin.x = self.bounds.origin.x + offset
        layer.frame = frame
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