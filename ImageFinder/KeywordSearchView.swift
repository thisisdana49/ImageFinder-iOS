//
//  KeywordSearchView.swift
//  ImageFinder
//
//  Created by 조다은 on 1/17/25.
//

import UIKit

class KeywordSearchView: BaseView {
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    let scrollView = UIScrollView()
    let stackView =  UIStackView()
    
    let orderButton = UIButton()
    
    let buttonBlack = CustomFilterButton(title: "블랙", name: "black", tag: 0)
    let buttonWhite = CustomFilterButton(title: "화이트", name: "white", tag: 0)
    let buttonYellow = CustomFilterButton(title: "옐로우", name: "yellow", tag: 0)
    let buttonRed = CustomFilterButton(title: "레드", name: "red", tag: 0)
    let buttonPurple = CustomFilterButton(title: "퍼플", name: "purple", tag: 0)
    let buttonGreen = CustomFilterButton(title: "그린", name: "green", tag: 0)
    let buttonBlue = CustomFilterButton(title: "블루", name: "blue", tag: 0)
    
    lazy var colorButtons = [buttonBlack, buttonWhite, buttonYellow, buttonRed, buttonPurple, buttonGreen, buttonBlue]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureHierarchy() {
        addSubview(scrollView)
        addSubview(orderButton)
        scrollView.addSubview(stackView)
        addSubview(collectionView)
    }
    
    override func configureLayout() {
        orderButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(4)
            make.trailing.equalTo(safeAreaLayoutGuide)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(48)
        }
        
        stackView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(scrollView)
            make.horizontalEdges.equalTo(scrollView).inset(8)
            make.height.equalTo(48)
        }
        
        colorButtons.forEach { button in
            button.snp.makeConstraints { make in
                make.verticalEdges.equalTo(scrollView).inset(8)
            }
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    override func configureView() {
        backgroundColor = .white
        
        scrollView.showsHorizontalScrollIndicator = false
        
        stackView.spacing = 10
        stackView.alignment = .center
        
        orderButton.setTitle("관련순", for: .normal)
        orderButton.setTitle("최신순", for: .selected)
        orderButton.isUserInteractionEnabled = true
        orderButton.backgroundColor = .darkGray
        orderButton.layer.cornerRadius = 10
        
        configureButton()
    }
    
    func configureButton() {
        colorButtons.forEach { button in
            stackView.addArrangedSubview(button)
        }
    }

    
    internal func createCollectionViewLayout() -> UICollectionViewFlowLayout {
        let spacing: CGFloat = 5
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = deviceWidth - spacing
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.itemSize = CGSizeMake(cellWidth / 2, (cellWidth / 2) * 1.2)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        return layout
    }
}
