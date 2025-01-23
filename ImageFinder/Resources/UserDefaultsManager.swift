//
//  UserDefaultsManager.swift
//  ImageFinder
//
//  Created by 조다은 on 1/23/25.
//

import Foundation

struct UserDefaultsManager {
    enum Keys: String {
        // app start
        case isFirst
        // notifications
        // alert
    }
    
    private let userDefault = UserDefaults.standard
    
    static func set<T>(to: T, forKey: Self.Keys) {
        UserDefaults.standard.setValue(to, forKey: forKey.rawValue)
        print("UserDefaultsManager: save \(forKey) complete")
    }
    
    static func get(forKey: Self.Keys) -> Any? {
        return UserDefaults.standard.object(forKey: forKey.rawValue)
    }
    
//    var user: User? {
//        get {
//            if let data = UserDefaults.standard.data(forKey: User.identifier) {
//                if let decodeData = try? decoder.decode(User.self, from: data) {
//                    return decodeData
//                }
//            }
//            return nil
//        }
//        set {
//            if let encodeData = try? encoder.encode(newValue) {
//                UserDefaults.standard.set(encodeData, forKey: User.identifier)
//            }
//        }
//    }

}
