//
//  Photo.swift
//  ImageFinder
//
//  Created by 조다은 on 1/18/25.
//

import Foundation

struct PhotoModel: Decodable {
    let total: Int
    let totalPages: Int
    let results: [PhotoDetail]
    
    enum CodingKeys: String, CodingKey {
        case totalPages = "total_pages"
        case total, results
    }
}

struct PhotoDetail: Decodable {
    let id: String
    let createdAt: String
    let width: Int
    let height: Int
    let urls: PhotoURLs
    let likes: Int
    let user: User
    
    var size: String {
        return "\(width) X \(height)"
    }
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case id, width, height, urls, likes, user
    }
}

struct PhotoStatistic: Decodable {
    let views: PhotoViews
    let downloads: PhotoDownloads
}

struct PhotoViews: Decodable {
    let total: Int
}

struct PhotoDownloads: Decodable {
    let total: Int
}

struct PhotoURLs: Decodable {
    let raw: String
    let small: String
    let thumb: String
}

struct User: Decodable {
    let name: String
}
