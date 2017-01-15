//
//  String+Extension.swift
//  SmartisanReader
//
//  Created by lixun on 2017/1/8.
//  Copyright © 2017年 sunshine. All rights reserved.
//

import UIKit


extension String{
    
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        guard self.characters.count > 0 && width > 0 else {
            return 0.0
        }
        
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let text = self as NSString
        let boundingBox = text.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }
    
    func widthWithConstrainedHeight(height: CGFloat) -> CGFloat {
        guard self.characters.count > 0 && height > 0 else {
            return 0.0
        }
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let text = self as NSString
        let boundingBox = text.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return boundingBox.width
    }
}




extension String {
    
    func height(constraintedWidth width: CGFloat, lines: Int, font: UIFont) -> CGFloat {
        guard width > 0 else {
            return 0.0
        }
        
        let label =  UILabel()
        label.bounds = CGRect.init(origin: CGPoint.init(x: 0.0, y: 0.0), size: CGSize.init(width: width, height: .greatestFiniteMagnitude))
        label.numberOfLines = lines
        label.font = font
        label.text = self
        label.sizeToFit()
        
        return label.bounds.height
    }
    
    
    func width(constraintedHeight height: CGFloat, lines: Int, font: UIFont) -> CGFloat {
        guard height > 0 else {
            return 0.0
        }
        
        let label =  UILabel()
        label.bounds = CGRect.init(origin: CGPoint.init(x: 0.0, y: 0.0), size: CGSize.init(width: .greatestFiniteMagnitude, height: height))
        label.numberOfLines = lines
        label.font = font
        label.text = self
        label.sizeToFit()
        
        return label.bounds.width
    }
    
}


extension NSMutableAttributedString {
    
    
    func heightWithConstrainedWidth(width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return boundingBox.height
    }
    
    func widthWithConstrainedHeight(height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return boundingBox.width
    }
    
    
    
    func height(constraintedWidth width: CGFloat, lines: Int, font: UIFont) -> CGFloat {
        guard width > 0 else {
            return 0.0
        }
        
        let label =  UILabel()
        label.bounds = CGRect.init(origin: CGPoint.init(x: 0.0, y: 0.0), size: CGSize.init(width: width, height: .greatestFiniteMagnitude))
        self.addAttributes([NSFontAttributeName : font], range: NSRange.init(location: 0, length: self.length))
        label.numberOfLines = lines
        label.attributedText = self
        label.sizeToFit()
        
        return label.bounds.height
    }
    
    
    func width(constraintedHeight height: CGFloat, lines: Int, font: UIFont) -> CGFloat {
        guard height > 0 else {
            return 0.0
        }
        
        let label =  UILabel()
        label.bounds = CGRect.init(origin: CGPoint.init(x: 0.0, y: 0.0), size: CGSize.init(width: .greatestFiniteMagnitude, height: height))
        self.addAttributes([NSFontAttributeName : font], range: NSRange.init(location: 0, length: self.length))
        label.numberOfLines = lines
        label.attributedText = self
        label.sizeToFit()
        
        return label.bounds.width
    }
}




