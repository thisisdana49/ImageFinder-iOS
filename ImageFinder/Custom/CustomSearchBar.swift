//
//  CustomSearchBar.swift
//  ImageFinder
//
//  Created by 조다은 on 1/21/25.
//

import UIKit

class CustomSearchBar: UISearchBar {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let textField = self.value(forKey: "searchField") as? UITextField {
            textField.textColor = .black
            textField.backgroundColor = .systemGray6
            textField.layer.cornerRadius = 10
            textField.clipsToBounds = true
            
            textField.attributedPlaceholder = NSAttributedString(
                string: "키워드 검색",
                attributes: [.foregroundColor: UIColor.systemGray]
            )
            
            if let leftView = textField.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = .systemGray
            }
        }
    }
}
