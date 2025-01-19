//
//  CustomFilterButton.swift
//  ImageFinder
//
//  Created by 조다은 on 1/17/25.
//

import UIKit

class CustomFilterButton: UIButton {
    
    // TODO: 꼭 미리 초기화를 해야하는가?
    var name: String = ""
    
    init(title: String, name: String, tag: Int) {
        super.init(frame: .zero)
        self.name = name
        
        var config = UIButton.Configuration.plain()
        config.contentInsets = NSDirectionalEdgeInsets.init(top: 5, leading: 10, bottom: 5, trailing: 10)
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(self.isSelected ? .black : .white, for: .normal)
        self.layer.backgroundColor = UIColor.systemGray6.cgColor
        self.layer.cornerRadius = 15
        self.tag = tag
        self.configuration = config
    }
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? .systemBlue : .orange
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
