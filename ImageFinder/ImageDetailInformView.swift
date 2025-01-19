//
//  ImageDetailInformView.swift
//  ImageFinder
//
//  Created by 조다은 on 1/20/25.
//

import UIKit
import SnapKit

class ImageDetailInformView: UIView {
    var titleLabel = UILabel()
    var contentLabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        
        addSubview(titleLabel)
        addSubview(contentLabel)
        
        titleLabel.textColor = .black
        
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        contentLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        contentLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
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
