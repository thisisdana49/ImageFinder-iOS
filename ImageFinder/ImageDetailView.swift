//
//  ImageDetailView.swift
//  ImageFinder
//
//  Created by 조다은 on 1/17/25.
//

import UIKit

class ImageDetailView: BaseView {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let topView = UIView()
    let informView = UIStackView()
    let imageView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
    }
    
    override func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.snp.width)
            make.verticalEdges.equalTo(scrollView)            
        }
    }
    
    override func configureView() {
        scrollView.backgroundColor = .lightGray
        contentView.backgroundColor = .systemMint
        
        contentView.addSubview(topView)
        contentView.addSubview(informView)
        contentView.addSubview(imageView)
        
        topView.backgroundColor = .systemOrange
        informView.backgroundColor = .systemPurple
        imageView.backgroundColor = .black
        
        topView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView).inset(20)
            make.height.equalTo(400)
        }
        
        informView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(contentView).inset(20)
            make.height.equalTo(400)
        }
        
        imageView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView).inset(20)
            make.top.equalTo(topView.snp.bottom).offset(20)
            make.bottom.equalTo(informView.snp.top).offset(-20)
            make.height.greaterThanOrEqualTo(400)
        }
    }
}

