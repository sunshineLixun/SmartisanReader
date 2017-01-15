//
//  UITableViewExtension.swift
//  SmartisanReader
//
//  Created by lixun on 2017/1/7.
//  Copyright © 2017年 sunshine. All rights reserved.
//

import UIKit

extension UITableView{
    
    func lx_registerNib<T: UITableViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
        let nib = UINib.init(nibName: T.nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    
    func lx_register<T: UITableViewCell>(_: T.Type) where T: ReusableView{
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    
    func lx_dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView{
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    
}
