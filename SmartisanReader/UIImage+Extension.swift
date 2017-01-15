//
//  UIImage+Extension.swift
//  SmartisanReader
//
//  Created by lixun on 2017/1/9.
//  Copyright © 2017年 sunshine. All rights reserved.
//

import UIKit


extension UIImage {
    func resizeImage(_ image: UIImage, targetSize: CGSize) -> UIImage? {
            let newRect = CGRect(x: 0, y: 0, width: targetSize.width, height: targetSize.height).integral
            UIGraphicsBeginImageContextWithOptions(targetSize, false, 0)
            if let context = UIGraphicsGetCurrentContext() {
                context.interpolationQuality = .high
                let flipVertical = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: targetSize.height)
                context.concatenate(flipVertical)
                context.draw(self.cgImage!, in: newRect)
                let newImage = UIImage(cgImage: context.makeImage()!)
                UIGraphicsEndImageContext()
               return newImage
            }
        return nil
    }
}


extension UIImageView {
    func drawImage(_ image: UIImage, targetSize: CGSize) {
        DispatchQueue.global().async {
            let newRect = CGRect(x: 0, y: 0, width: targetSize.width, height: targetSize.height).integral
            UIGraphicsBeginImageContextWithOptions(targetSize, false, 0)
            if let context = UIGraphicsGetCurrentContext() {
                context.interpolationQuality = .high
                let flipVertical = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: targetSize.height)
                context.concatenate(flipVertical)
                context.draw(image.cgImage!, in: newRect)
                let newImage = UIImage(cgImage: context.makeImage()!)
                UIGraphicsEndImageContext()
                DispatchQueue.main.async {
                    self.layer.contents = newImage.cgImage
                }
            }
        }
    }
}
