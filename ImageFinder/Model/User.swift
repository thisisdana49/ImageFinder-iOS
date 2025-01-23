//
//  User.swift
//  ImageFinder
//
//  Created by 조다은 on 1/23/25.
//

import Foundation

struct User: Codable {
    static let identifier = "User"
    var nickname: String
    var birthday: String
    var level: Int
}
