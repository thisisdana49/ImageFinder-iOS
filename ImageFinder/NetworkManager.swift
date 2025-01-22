//
//  NetworkManager.swift
//  ShoppingSearchApp
//
//  Created by 조다은 on 1/16/25.
//

import Foundation
import Alamofire

enum PhotoRequest {
    case withID(id: String)
    case withKeyword(keyword: String, page: Int, orderBy: String, filterBy: String?)
    case withTopic(topic: String)
    
    var baseURL: String {
        return "https://api.unsplash.com"
    }
    
    var endPoint: URL {
        switch self {
        case .withID(let id):
            return URL(string: baseURL + "/photos/\(id)/statistics")!
        case .withKeyword:
            return URL(string: baseURL + "/search/photos")!
        case .withTopic(let topic):
            return URL(string: baseURL + "/topics/\(topic)/photos")!
        }
    }
    
    var header: HTTPHeaders {
        return ["Authorization": "Client-ID \(Key.access)"]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameter: Parameters {
        switch self {
        case .withID:
            return [:]
        case .withKeyword(let keyword, let page, let orderBy, let filterBy):
            if let color = filterBy, !color.isEmpty {
                return [
                    "query": keyword,
                    "page": page,
                    "order_by": orderBy,
                    "color": color
                ]
            } else {
                return [
                    "query": keyword,
                    "page": page,
                    "order_by": orderBy,
                ]
            }
        case .withTopic:
            return [:]
        }
    }
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func searchPhoto<T: Decodable>(
            api: PhotoRequest,
            type: T.Type,
            successHandler: @escaping (T) -> Void,
            failHandler: @escaping (AFError) -> Void
    ) {
        AF.request(api.endPoint, method: api.method, parameters: api.parameter, headers: api.header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    successHandler(value)
                case .failure(let error):
                    failHandler(error)
                }
            }
    }
    
}
