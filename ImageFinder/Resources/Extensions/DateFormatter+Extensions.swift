//
//  DateFormatter+Extension.swift
//  ImageFinder
//
//  Created by 조다은 on 1/23/25.
//

import Foundation

extension DateFormatter {
    
    static let krDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()
    
    static func getDateFormatter() -> DateFormatter {
        return krDateFormatter
    }
    
}

extension Date {
    
    func toFormattedString(_ dateFormat: String = "HH:mm") -> String {
        let dateFormatter = DateFormatter.getDateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
    
    static func fromString(_ dateString: String, format: String) -> Date? {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = format
           return dateFormatter.date(from: dateString)
       }
    
}
