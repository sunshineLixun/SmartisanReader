//
//  AsyncView.swift
//  SmartisanReader
//
//  Created by lixun on 2017/1/12.
//  Copyright © 2017年 sunshine. All rights reserved.
//

import UIKit

class AsyncView: UIView {

    override  init(frame: CGRect) {
        super.init(frame: frame)
        self.isOpaque = false
        self.layer.contentsScale = UIScreen.main.scale
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        if !(self.window != nil) {
            
        }else if !(self.layer.contents != nil) {
            self.layer.setNeedsDisplay()
        }
    }
    
    
    override func draw(_ layer: CALayer, in ctx: CGContext) {
        DispatchQueue.global().async {
            self.displayLayer(layer, rect: layer.frame)
        }
    }
    
    
    func displayLayer(_ layer: CALayer, rect: CGRect)  {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        UIGraphicsBeginImageContextWithOptions(layer.bounds.size, layer.isOpaque, layer.contentsScale)
        context.saveGState()
        
        // 旋转画布
        context.textMatrix = CGAffineTransform.identity
        context.translateBy(x: 0, y: rect.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        
        if self.backgroundColor != UIColor.clear, let backgroundColor = self.backgroundColor {
            context.setFillColor(backgroundColor.cgColor)
            context.fill(rect)
        }
        
        let isTrue =  drawInRect(rect, context: context)
        context.restoreGState()
        
        if isTrue {
            let CGImage: CGImage = context.makeImage()!
            let image = UIImage.init(cgImage: CGImage)
            DispatchQueue.main.async {
                self.layer.contents = image.cgImage
            }
            
        }
        UIGraphicsEndImageContext()
    }
    
    
    open func drawInRect(_ rect: CGRect, context: CGContext) -> Bool{
        return true
    }

}





class AsyncRichTextView: AsyncView {
    
    
    
    
    
    override func drawInRect(_ rect: CGRect, context: CGContext) -> Bool {
        
        
        
        
        
        return true
    }
}


