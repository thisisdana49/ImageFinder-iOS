//
//  CustomFilterButton.swift
//  ImageFinder
//
//  Created by 조다은 on 1/17/25.
//

import UIKit

class CustomFilterButton: UIButton {
    
    init(title: String, tag: Int) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(self.isSelected ? .black : .white, for: .normal)
        self.layer.backgroundColor = UIColor.systemGray6.cgColor
        self.layer.cornerRadius = 18
        self.tag = tag
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
