//
//  ViewController.swift
//  SmartisanReader
//
//  Created by lixun on 2017/1/7.
//  Copyright © 2017年 sunshine. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UITableViewController {

    public var layouts: Array<CellLayout> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.tableView.lx_register(ReaderCell.self)
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorInset = .zero
        
        let indicator = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        indicator.center = CGPoint.init(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
        indicator.bounds = CGRect.init(x: 0, y: 0, width: 80, height: 80)
        indicator.backgroundColor = UIColor.init(white: 0.000, alpha: 0.670)
        indicator.startAnimating()
        indicator.layer.cornerRadius = 6.0
        indicator.layer.masksToBounds = true
        self.view.addSubview(indicator)
        
        
        Alamofire.request("http://reader.smartisan.com/index.php?r=visitor/getList&offset=0&page_size=20&site_ids=1").validate().responseJSON { (response) in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                let array = json["data","list"]
                print(array);
                DispatchQueue.global().async(execute: {
                    for(_, subJson) in array{
                        let cellModel = CellModel.init(subJson)
                        let cellLayout = CellLayout.init(cellModel)
                        self.layouts.append(cellLayout)
                    }
                    DispatchQueue.main.async {
                        indicator.stopAnimating()
                        self.tableView.reloadData()
                    }
               })
            case .failure(let error):
                indicator.stopAnimating()
                print("Error:\(error)")
            }
        }
    }
}


extension ViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return layouts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.lx_dequeueReusableCell(forIndexPath: indexPath) as ReaderCell
        cell.setLayout(layouts[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return layouts[indexPath.row].height
    }
}

