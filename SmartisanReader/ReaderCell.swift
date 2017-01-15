//
//  ReaderCell.swift
//  SmartisanReader
//
//  Created by lixun on 2017/1/7.
//  Copyright © 2017年 sunshine. All rights reserved.
//

import UIKit
import Kingfisher
import PINRemoteImage
import YYText

class ReaderCell: UITableViewCell {
    
    lazy var nameLabel: YYLabel = {
        var label = YYLabel()
        label.fadeOnAsynchronouslyDisplay = true
        label.displaysAsynchronously = true
       // label.font = UIFont.systemFont(ofSize: 17.0)
        label.numberOfLines = 2
        return label
    }()
    
    
    lazy var contentLabel: YYLabel = {
        var label = YYLabel()
        label.fadeOnAsynchronouslyDisplay = true
        label.displaysAsynchronously = true
        label.textColor = UIColor.lightGray
       // label.font = UIFont.systemFont(ofSize: 13.0)
        label.numberOfLines = 2
        
        return label
    }()
    
    
    lazy var sourceLabel: YYLabel = {
        var label = YYLabel()
        label.fadeOnAsynchronouslyDisplay = true
        label.displaysAsynchronously = true
        //label.font = UIFont.systemFont(ofSize: 11.0)
       // label.textColor = UIColor.lightGray
        return label
    }()
    
    
    lazy var showImageView1: UIImageView = {
        let imageView = UIImageView()
      //  imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var showImageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    lazy var showImageView3: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    lazy var souecrImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func setLayout(_ layout: CellLayout){
    
        self.contentView.lx_height = layout.height
        
        /*
        self.nameLabel.text = layout.cellModel.title
        self.contentLabel.text = layout.cellModel.content
        self.sourceLabel.text = layout.cellModel.source
        */
        
        let nameAttStr = NSMutableAttributedString.init(string: layout.cellModel.title)
        nameAttStr.addAttributes([NSFontAttributeName : UIFont.systemFont(ofSize: 17.0), NSForegroundColorAttributeName : UIColor.black], range: NSRange.init(location: 0, length: nameAttStr.length))
        let container = YYTextContainer.init()
        container.size = CGSize.init(width: CellLayout.screenWidth - 20.0, height: layout.titleHeight)
        container.maximumNumberOfRows = 0
        if let textLayout = YYTextLayout.init(container: container, text: nameAttStr){
            nameLabel.textLayout = textLayout
            nameLabel.lx_frameSize = textLayout.textBoundingSize
        }
        
        if layout.cellModel.content != "" {
            let contentAttStr = NSMutableAttributedString.init(string: layout.cellModel.content)
            contentAttStr.addAttributes([NSFontAttributeName : UIFont.systemFont(ofSize: 13.0), NSForegroundColorAttributeName : UIColor.lightGray], range: NSRange.init(location: 0, length: contentAttStr.length))
            
            let contentContainer = YYTextContainer.init()
            contentContainer.size = CGSize.init(width: CellLayout.screenWidth - 20.0, height: layout.contentHeight)
            contentContainer.maximumNumberOfRows = 0
            if let contentTextLayout = YYTextLayout.init(container: contentContainer, text: contentAttStr){
                contentLabel.textLayout = contentTextLayout
                contentLabel.lx_frameSize = contentTextLayout.textBoundingSize
            }
        }else{
            contentLabel.attributedText = nil
        }
       
        
        let sourceAttStr = NSMutableAttributedString.init(string: layout.cellModel.source)
        sourceAttStr.addAttributes([NSFontAttributeName : UIFont.systemFont(ofSize: 11.0), NSForegroundColorAttributeName : UIColor.lightGray], range: NSRange.init(location: 0, length: sourceAttStr.length))
        
        let sourceContainer = YYTextContainer.init()
        sourceContainer.size = CGSize.init(width: layout.sourceWidth, height: layout.souecrHeight)
        sourceContainer.maximumNumberOfRows = 0
        if let sourceTextLayout = YYTextLayout.init(container: sourceContainer, text: sourceAttStr){
            sourceLabel.textLayout = sourceTextLayout
            sourceLabel.lx_frameSize = sourceTextLayout.textBoundingSize
        }
        
        
        nameLayout(layout)
        
        contentLayout(layout)
        
        imageViewLayout(layout)
        
        sourceLayout(layout)
        
        sourceImageViewLayout(layout)

        
    }
    
    private func nameLayout(_ layout: CellLayout){
        nameLabel.lx_top = CellLayout.nameTopPadding
        nameLabel.lx_left = CellLayout.nameLeftPadding
        nameLabel.lx_width = CellLayout.screenWidth  - 20.0
        nameLabel.lx_height = layout.titleHeight
        self.contentView.addSubview(self.nameLabel)
    }
    
    
    private func contentLayout(_ layout: CellLayout){
        if layout.cellModel.content != "" {
            contentLabel.lx_top = CellLayout.contentLabelTopPadding + nameLabel.frame.maxY
            contentLabel.lx_left = nameLabel.lx_left
            contentLabel.lx_width = CellLayout.screenWidth  - 20.0
            contentLabel.lx_height = layout.contentHeight
            self.contentView.addSubview(self.contentLabel)
        }
    }
    
    private func sourceLayout(_ layout: CellLayout){
        sourceLabel.lx_left = CellLayout.nameLeftPadding + CellLayout.sourceImageViewSize.width + CellLayout.sourceLabelLeftPadding
        sourceLabel.lx_top = self.contentView.lx_height - layout.souecrHeight - CellLayout.cellBottomPading
        sourceLabel.lx_height = layout.souecrHeight
        sourceLabel.lx_width = layout.sourceWidth
        self.contentView.addSubview(self.sourceLabel)
    }
    
    private func sourceImageViewLayout(_ layout: CellLayout){
        souecrImageView.lx_top = self.sourceLabel.lx_top
        souecrImageView.lx_frameSize = CellLayout.sourceImageViewSize
        souecrImageView.lx_left = nameLabel.lx_left
//        souecrImageView.kf.setImage(with: URL.init(string: layout.cellModel.sourcePrepic))
        self.setImage(souecrImageView, URLString: layout.cellModel.sourcePrepic, targetSize: CellLayout.sourceImageViewSize)
        showImageView1.pin_updateWithProgress = true
        self.contentView.addSubview(self.souecrImageView)
    }
    
    
    private func imageViewLayout(_ layout: CellLayout){
        if layout.cellModel.prepic1 != "" {
//            showImageView1.kf.setImage(with: URL.init(string: layout.cellModel.prepic1))
            self.setImage(showImageView1, URLString: layout.cellModel.prepic1, targetSize: CellLayout.imageViewSize)
            showImageView2.pin_updateWithProgress = true
            showImageView1.lx_left = nameLabel.lx_left
            if layout.cellModel.content != "" {
                showImageView1.lx_top =  contentLabel.frame.maxY + CellLayout.imageViewTopPaddind
            }else{
                showImageView1.lx_top =  nameLabel.frame.maxY + CellLayout.imageViewTopPaddind
            }
            showImageView1.lx_frameSize = CellLayout.imageViewSize
            self.contentView.addSubview(showImageView1)
        }else{
             showImageView1.removeFromSuperview()
        }
        
        
        if layout.cellModel.prepic2 != "" {
//            showImageView2.kf.setImage(with: URL.init(string: layout.cellModel.prepic2))
            self.setImage(showImageView2, URLString: layout.cellModel.prepic2, targetSize: CellLayout.imageViewSize)
            showImageView2.pin_updateWithProgress = true
            showImageView2.lx_left = showImageView1.frame.maxX + CellLayout.imageViewMargin
            showImageView2.lx_top = showImageView1.lx_top
            showImageView2.lx_frameSize = CellLayout.imageViewSize
            self.contentView.addSubview(showImageView2)
        }else{
            showImageView2.removeFromSuperview()
        }
        
        if layout.cellModel.prepic3 != "" {
//            showImageView3.kf.setImage(with: URL.init(string: layout.cellModel.prepic3))
            showImageView3.pin_updateWithProgress = true
            self.setImage(showImageView3, URLString: layout.cellModel.prepic3, targetSize: CellLayout.imageViewSize)
            showImageView3.lx_left = showImageView2.frame.maxX + CellLayout.imageViewMargin
            showImageView3.lx_top = showImageView1.lx_top
            showImageView3.lx_frameSize = showImageView1.frame.size
            self.contentView.addSubview(showImageView3)
        }else{
            showImageView3.removeFromSuperview()
        }
        
    }
    
    
    private func setImage<T: UIImageView>(_ imageView: T, URLString: String, targetSize: CGSize){
        imageView.pin_setImage(from: URL.init(string: URLString), completion: {(PINRemoteImageManagerResult) in
            if let image = PINRemoteImageManagerResult.image{
                imageView.drawImage(image, targetSize: targetSize)
//                    imageView.image = image.resizeImage(image, targetSize: targetSize)
            }
        })
    }
}
