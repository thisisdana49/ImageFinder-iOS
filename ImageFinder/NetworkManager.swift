//
//  NetworkManager.swift
//  ShoppingSearchApp
//
//  Created by 조다은 on 1/16/25.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func searchWithKeyWord(keyword: String, orderBy: String = "latest", page: Int = 1) {
        let url = "https://api.unsplash.com/search/photos?query=\(keyword)&page=1&client_id=\(accessKey)"
        AF.request(url, method: .get)
//            .validate(statusCode: 200..<300)
            .responseString { response in
                dump(response.result)
            }
//            .responseDecodable(of: Item.self) { response in
//            switch response.result {
//            case .success(let value):
//                completionHandler(value)
//
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
}
