//
//  AsynLabel.swift
//  SmartisanReader
//
//  Created by lixun on 2017/1/10.
//  Copyright © 2017年 sunshine. All rights reserved.
//

import UIKit

class AsynLabel: UILabel {

    private let queue = DispatchQueue.init(label: "sunshine")
    var frameAttr: CTFrame!
    lazy var content = NSMutableAttributedString()
    
    override func draw(_ rect: CGRect) {
        
//        if let contentAttr = self.attributedText {
//            self.content.append(contentAttr)
//            self.content.draw(in: rect)
//        }

        queue.async {
            if let contentAttr = self.attributedText {
                self.content.append(contentAttr)
            }
            
            UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.layer.isOpaque, UIScreen.main.scale)
            guard let context = UIGraphicsGetCurrentContext() else {
                UIGraphicsEndImageContext()
                return
            }
            
            // 可以理解为 - 要旋转画布了
            context.saveGState()
            
            // 旋转画布
            context.textMatrix = CGAffineTransform.identity
            context.translateBy(x: 0, y: rect.size.height)
            context.scaleBy(x: 1.0, y: -1.0)
            
            /*
             * 1. 通过AttributeString->CTFramesetter
             * 2. 创建路径, 你可以做点形变, 可以修改渲染的路径
             * 3. 通过以上两个对象, 创建CTFrame
             * 4. 将CTFrame对象渲染上去
             */
            
            let frameSetter = CTFramesetterCreateWithAttributedString(self.content as CFAttributedString)
            let path = CGMutablePath()
            path.addRect(self.bounds)
            
          
            self.frameAttr = CTFramesetterCreateFrame(frameSetter, CFRange(location: 0, length: self.content.length), path, nil)
            CTFrameDraw(self.frameAttr, context)
            
            // 把刚旋转的画布转回来
            context.restoreGState()
            
            if true {
                let CGImage: CGImage = context.makeImage()!
                let image = UIImage.init(cgImage: CGImage)
                DispatchQueue.main.async {
                    self.layer.contents = image.cgImage
                }
            }

        }
 
    }
 
}
