//
//  KeywordView.swift
//  ImageFinder
//
//  Created by 조다은 on 1/18/25.
//

import UIKit

class TopicSearchView: BaseView {
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureHierarchy() {
        addSubview(collectionView)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(240)
        }
    }
    
    override func configureView() {
        backgroundColor = .white
        collectionView.backgroundColor = .systemGray
    }
    
    internal func createCollectionViewLayout() -> UICollectionViewFlowLayout {
        let spacing: CGFloat = 5
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = deviceWidth - spacing
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.itemSize = CGSizeMake(cellWidth / 2, (cellWidth / 2) * 1.2)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        return layout
    }
    
}
