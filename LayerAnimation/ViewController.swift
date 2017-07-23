//
//  ViewController.swift
//  CATest
//
//  Created by 郑宇琦 on 2017/7/22.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var containerView: EmojiView?
    
    let maxContainerSize = CGSize.init(width: 300, height: 540)
    
    var currentContainerExpansion: Double = 0 {
        didSet {
            containerView?.layer.timeOffset = currentContainerExpansion
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        view.backgroundColor = UIColor.black
        
        let containerFrame = CGRect.init(origin: CGPoint.init(x: view.bounds.midX - maxContainerSize.width / 2, y: view.bounds.midY - maxContainerSize.height / 2), size: maxContainerSize)
        let containerView = EmojiView.init(frame: containerFrame)
        view.addSubview(containerView)
        self.containerView = containerView
        
        setupAnimations()
        
        let rec = UIPanGestureRecognizer.init(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(rec)
    }
    
    @objc func handlePan(_ recorgnizer: UIPanGestureRecognizer) {
        let dragDistanceY = recorgnizer.translation(in: view).y
        let scaledDragAmount = Double(dragDistanceY / maxContainerSize.height)
        
        currentContainerExpansion = min(max(currentContainerExpansion + scaledDragAmount, 0), 1)
            
        recorgnizer.setTranslation(.zero, in: view)
    }
    
    func setupAnimations() {
        if let containerLayer = containerView?.layer, let emojiLayers = containerView?.emojiLayers {
            containerLayer.speed = 0
            let animation = CABasicAnimation.init(keyPath: "bounds.size.height")
            animation.fromValue = 80
            animation.toValue = maxContainerSize.height
            animation.duration = 1
            animation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
            
            let widthAnimation = CABasicAnimation.init(keyPath: "bounds.size.width")
            widthAnimation.fromValue = 80
            widthAnimation.toValue = maxContainerSize.width
            widthAnimation.duration = 0.2
            widthAnimation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
            
            containerLayer.add(animation, forKey: nil)
            containerLayer.add(widthAnimation, forKey: nil)
            
            let baseStartTime = containerLayer.convertTime(CACurrentMediaTime(), from: nil)
            for i in emojiLayers.indices {
                let layer = emojiLayers[i]
                let animation = CABasicAnimation.init(keyPath: "transform.scale.xy")
                animation.fromValue = 0.01
                animation.toValue = 1
                animation.duration = 0.1
                animation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
                animation.beginTime = baseStartTime + 0.028 * Double(i)
                animation.fillMode = kCAFillModeBackwards
                layer.add(animation, forKey: nil)
            }
        }
    }
}


