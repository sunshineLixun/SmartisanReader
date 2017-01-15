
//
//  ReusableView.swift
//  SmartisanReader
//
//  Created by lixun on 2017/1/7.
//  Copyright © 2017年 sunshine. All rights reserved.
//

import UIKit

protocol ReusableView: class {}

extension ReusableView where Self: UIView{
    static var reuseIdentifier: String{
        return String(describing: self)
    }
}



protocol NibLoadableView: class {}

extension NibLoadableView where Self: UIView{
    static var nibName: String{
        return String(describing: self)
    }
}


extension UITableViewCell: ReusableView{}

extension UITableViewCell: NibLoadableView{}
