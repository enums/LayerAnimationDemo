//
//  EmojiView.swift
//  CATest
//
//  Created by 郑宇琦 on 2017/7/23.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

import UIKit
import QuartzCore

class EmojiView: UIView {
    
    var emojiLayers: [CALayer] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let emojiList = "😀😍😂😏😀😍😂😏😀😍😂😏😀😍😂😏😀😍😂😏😀😍😂😏😀😍😂😏😀😍😂😏😀😍😂😏😀😍😂😏"
        let screenScale = UIScreen.main.scale
        let cornerInset = 45
        let layerSize = 70
        
        var index = 0
        var emojiLayers: [CALayer] = []
        
        for e in emojiList.characters {
            let layer = CATextLayer.init()
            layer.string = String(e)
            layer.fontSize = 50
            layer.contentsScale = screenScale
            layer.bounds = CGRect.init(x: 0, y: 0, width: layerSize, height: layerSize)
            layer.alignmentMode = kCAAlignmentCenter
            let column = index % 4
            let row = (index - column) / 4
            layer.position = CGPoint.init(x: cornerInset + layerSize * column, y: cornerInset + layerSize * row)
            
            emojiLayers.append(layer)
            self.layer.addSublayer(layer)
            index += 1
        }
        self.emojiLayers = emojiLayers
        self.backgroundColor = UIColor.white
        
        self.layer.cornerRadius = CGFloat(cornerInset)
        self.layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

