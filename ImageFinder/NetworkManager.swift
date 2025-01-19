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
    
    func searchWithKeyWord(keyword: String, page: Int, orderBy: String, filteredBy color: String? = nil, completionHandler: @escaping (PhotoModel) -> Void) {
        let url = "https://api.unsplash.com/search/photos?query=\(keyword)&page=\(page)&order_by=\(orderBy)&client_id=\(accessKey)"
        var params: Parameters = [:]
        if let color = color, !color.isEmpty {
            params["color"] = color
        }
        
        AF.request(url, method: .get, parameters: params)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: PhotoModel.self) { response in
                switch response.result {
                case .success(let value):
                    print(#function, value.totalPages)
                    completionHandler(value)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func searchWithPhotoID(id: String, completionHandler: @escaping (PhotoStatistic) -> Void) {
        let url = "https://api.unsplash.com/photos/\(id)/statistics?client_id=\(accessKey)"
        
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: PhotoStatistic.self) { response in
                switch response.result {
                case .success(let value):
                    print(id)
                    completionHandler(value)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func searchWithTopic(topic: String, completionHandler: @escaping ([PhotoDetail]) -> Void) {
        let url = "https://api.unsplash.com/topics/\(topic)/photos?page=1&client_id=\(accessKey)"
        
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: [PhotoDetail].self) { response in
                switch response.result {
                case .success(let value):
                    dump(value.first?.id)
                    completionHandler(value)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
