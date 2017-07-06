//
//  RequestManager.swift
//  SmartisanReader
//
//  Created by lixun on 2017/7/6.
//  Copyright © 2017年 sunshine. All rights reserved.
//

import Foundation
import Alamofire

protocol AbstractRequest {
	var requestURL: String {get}
	var method: HTTPMethod {get}
	var parameters: Parameters? {get}
}


extension AbstractRequest{
	func requestStart(completion: @escaping (Any) -> (Void)) {
		Alamofire.request(requestURL, method: self.method, parameters: self.parameters).responseJSON { response in
			if let json = response.result.value{
				completion(json)
			}
		}
	}
}



final class MessageRequest: AbstractRequest{
	var parameters: Parameters? = nil
	var method = HTTPMethod.get
	var requestURL: String = "http://reader.smartisan.com/index.php?r=visitor/getList&offset=0&page_size=20&site_ids=1"
}

