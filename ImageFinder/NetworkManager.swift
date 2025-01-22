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

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func searchPhoto<T: Decodable>(
        api: PhotoRequest,
        type: T.Type,
        successHandler: @escaping (T) -> Void,
        failHandler: @escaping (String) -> Void
    ) {
        AF.request(api.endPoint, method: api.method, parameters: api.parameter, headers: api.header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    successHandler(value)
                case .failure(let error):
                    let statusCode = response.response?.statusCode
                    let errorMessage = self.handleHTTPError(statusCode: statusCode, error: error)
                    failHandler(errorMessage)
                }
            }
    }
    
    private func handleHTTPError(statusCode: Int?, error: AFError) -> String {
            guard let code = statusCode else { return "네트워크 오류가 발생했습니다. 다시 시도해주세요." }
            
            switch code {
            case 400:
                return "잘못된 요청입니다. 입력값을 확인해주세요."
            case 401:
                return "인증에 실패했습니다. 다시 로그인해주세요."
            case 403:
                return "권한이 없습니다. 관리자에게 문의하세요."
            case 404:
                return "요청한 리소스를 찾을 수 없습니다."
            case 500, 503:
                return "서버에 문제가 발생했습니다. 잠시 후 다시 시도해주세요."
            default:
                return "알 수 없는 오류가 발생했습니다. 코드: \(code)"
            }
        }
    
}
