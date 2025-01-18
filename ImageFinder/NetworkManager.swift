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
    
    func searchItem(searchWord: String, sortWith sortStandard: String, start: Int, display: Int, completionHandler: @escaping (Item) -> Void) {
        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(searchWord)&sort=\(sortStandard)&start=\(start)&display=\(display)"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": naverClientID,
            "X-Naver-Client-Secret": naverClientSecret
        ]
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Item.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value)

            case .failure(let error):
                print(error)
            }
        }
    }
}
