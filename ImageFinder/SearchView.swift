//
//  SearchView.swift
//  ImageFinder
//
//  Created by 조다은 on 1/17/25.
//

import UIKit
import SnapKit

class SearchView: BaseView {
    
    let scrollView = UIScrollView()
    let stackView =  UIStackView()
    let customButton1 = CustomFilterButton(title: "블랙", tag: 0)
    let customButton2 = CustomFilterButton(title: "블랙", tag: 0)
    let customButton3 = CustomFilterButton(title: "블랙", tag: 0)
    let customButton4 = CustomFilterButton(title: "블랙", tag: 0)
    let customButton5 = CustomFilterButton(title: "블랙", tag: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)
    }
    
    override func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(55)
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.height.equalTo(55)
        }
    }
    
    override func configureView() {
        backgroundColor = .white
        
        stackView.backgroundColor = .systemBlue
        stackView.spacing = 10
        
        configureButton()
    }
    
    func configureButton() {
        let label = customButton1
        label.backgroundColor = .orange
        stackView.addArrangedSubview(label)
        
        let label2 = customButton2
        label2.backgroundColor = .brown
        stackView.addArrangedSubview(label2)
        
        let label3 = customButton3
        label3.backgroundColor = .orange
        stackView.addArrangedSubview(label3)
        
        let label4 = customButton4
        label4.backgroundColor = .orange
        stackView.addArrangedSubview(label4)
        
        let label5 = customButton5
        label5.backgroundColor = .orange
        stackView.addArrangedSubview(label5)
    }
}
