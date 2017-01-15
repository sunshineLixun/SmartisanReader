//
//  CellLayout.swift
//  SmartisanReader
//
//  Created by lixun on 2017/1/7.
//  Copyright © 2017年 sunshine. All rights reserved.
//

import UIKit
import SwiftyJSON
import Foundation

public struct CellModel {
    
    public var title: String!
    public var content: String!
    public var prepic1: String!
    public var prepic2: String!
    public var prepic3: String!
    public var sourcePrepic: String!
    public var source: String!

    init(_ json: JSON) {
        self.title = json["title"].stringValue
        self.content = json["brief"].stringValue
        self.prepic1 = self.compareOptionsLiteral(json["prepic1"].stringValue)
        self.prepic2 = self.compareOptionsLiteral(json["prepic2"].stringValue)
        self.prepic3 = self.compareOptionsLiteral(json["prepic3"].stringValue)
        self.source = json["site_info","name"].stringValue
        self.sourcePrepic = self.compareOptionsLiteral(json["site_info","pic"].stringValue)
    }
}

extension CellModel {
    fileprivate func compareOptionsLiteral(_ string: String) -> String{
        return string.replacingOccurrences(of: "\"", with: "", options: NSString.CompareOptions.literal, range:nil)
    }
}



public struct CellLayout {
    
    public var cellModel: CellModel!
    
    public var titleHeight: CGFloat!
    
    public var contentHeight: CGFloat!
    
    public var souecrHeight: CGFloat!
    
    public var sourceWidth: CGFloat!
    
    //MARK: 总高度
    public var height: CGFloat = 0.0
    

    public static var screenWidth: CGFloat{
        get{
            return UIScreen.main.bounds.size.width
        }
    }
    
    public static var screenHeight: CGFloat{
        get{
            return UIScreen.main.bounds.size.height
        }
    }
    
    
    ///标题顶部距离
    public static var nameTopPadding: CGFloat{
        get{
            return 15.0
        }
    }
    
    ///标题左边距
    public static var nameLeftPadding: CGFloat{
        get{
            return 15.0
        }
    }
    
    ///内容上边距
    public static var contentLabelTopPadding: CGFloat{
        get{
            return 8.0
        }
    }
    
    ///图片上边距
    public static var imageViewTopPaddind: CGFloat{
        get{
            return 9.0
        }
    }
    
    ///来源图片上边距
    public static var sourceTopPadding: CGFloat{
        get{
            return 8.0
        }
    }
    
    ///来源图片左边距
    public static var sourceLabelLeftPadding: CGFloat{
        get{
            return 5.0
        }
    }
    
    ///cell底部距离
    public static var cellBottomPading: CGFloat{
        get{
            return 15.0
        }
    }
    
    
    public static var imageViewSize: CGSize{
        get{
            return CGSize.init(width: 80, height: 80)
        }
    }
    
    
    public static var sourceImageViewSize: CGSize{
        get{
            return CGSize.init(width: 15, height: 15)
        }
    }
    
    ///图片间距
    public static var imageViewMargin: CGFloat{
        get{
            return 5.0
        }
    }
    
    
    init(_ cellModel: CellModel) {
        self.cellModel = cellModel
        self.height = self.setHight()
    }
    
    private mutating func setHight() -> CGFloat{
        var maxHeight: CGFloat = 0.0
        guard let title = self.cellModel.title, let content = self.cellModel.content, let source = self.cellModel.source  else {
            return 0.0
        }
        
        
//        let attTitle = NSMutableAttributedString.init(string: title)
//        titleHeight = attTitle.height(constraintedWidth: CellLayout.screenWidth - 20.0, lines: 2, font: UIFont.systemFont(ofSize: 17.0))
        
        
//        titleHeight = title.heightWithConstrainedWidth(width: CellLayout.screenWidth - 20.0, font: UIFont.systemFont(ofSize: 17.0))
        titleHeight = title.height(constraintedWidth: CellLayout.screenWidth - 20.0, lines: 2, font: UIFont.systemFont(ofSize: 17.0))
        
//        let conTitle = NSMutableAttributedString.init(string: content)
//        contentHeight = conTitle.height(constraintedWidth: CellLayout.screenWidth - 20.0, lines: 2, font: UIFont.systemFont(ofSize: 13.0))
        
        
        contentHeight = content.height(constraintedWidth: CellLayout.screenWidth - 20.0, lines: 2, font: UIFont.systemFont(ofSize: 13.0))
        
//      souecrHeight = source.heightWithConstrainedWidth(width: .greatestFiniteMagnitude, font: UIFont.systemFont(ofSize: 11.0))
        
//        let sourceAtt = NSMutableAttributedString.init(string: source)
//        souecrHeight = sourceAtt.height(constraintedWidth: CellLayout.screenWidth - 20.0, lines: 1, font: UIFont.systemFont(ofSize: 11.0))
        
        
        souecrHeight = source.height(constraintedWidth: CellLayout.screenWidth - 20.0, lines: 1, font: UIFont.systemFont(ofSize: 11.0))
        
//       sourceWidth = source.widthWithConstrainedHeight(height: 999)
        
//        sourceWidth = sourceAtt.width(constraintedHeight: 999, lines: 1, font: UIFont.systemFont(ofSize: 11.0))
        
        
        sourceWidth = source.width(constraintedHeight: 999, lines: 1, font: UIFont.systemFont(ofSize: 11.0))
        if cellModel.prepic1 == "" && cellModel.prepic2 == "" && cellModel.prepic3 == "" {
            maxHeight = CellLayout.nameTopPadding + titleHeight + CellLayout.contentLabelTopPadding + contentHeight + CellLayout.sourceTopPadding + souecrHeight + CellLayout.cellBottomPading
        }else{
            maxHeight = CellLayout.nameTopPadding + titleHeight + CellLayout.contentLabelTopPadding + contentHeight + CellLayout.imageViewTopPaddind + CellLayout.imageViewSize.height + CellLayout.sourceTopPadding + souecrHeight + CellLayout.cellBottomPading
        }
        return maxHeight
    }
}
