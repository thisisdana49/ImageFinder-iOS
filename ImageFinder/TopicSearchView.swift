//
//  KeywordView.swift
//  ImageFinder
//
//  Created by 조다은 on 1/18/25.
//

import UIKit

class TopicSearchView: BaseView {
    
    lazy var collectionView1 = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    lazy var collectionView2 = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    lazy var collectionView3 = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureHierarchy() {
        addSubview(collectionView1)
        addSubview(collectionView2)
        addSubview(collectionView3)
    }
    
    override func configureLayout() {
        collectionView1.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(240)
        }
        collectionView2.snp.makeConstraints { make in
            make.top.equalTo(collectionView1.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(240)
        }
        collectionView3.snp.makeConstraints { make in
            make.top.equalTo(collectionView2.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(240)
        }
    }
    
    override func configureView() {
        backgroundColor = .white
        collectionView1.backgroundColor = .systemGray
        collectionView2.backgroundColor = .systemGray
        collectionView3.backgroundColor = .systemGray
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
