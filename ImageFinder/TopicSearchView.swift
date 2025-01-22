//
//  KeywordView.swift
//  ImageFinder
//
//  Created by 조다은 on 1/18/25.
//

import UIKit

final class TopicSearchView: BaseView {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let titleLabel1 = UILabel()
    let titleLabel2 = UILabel()
    let titleLabel3 = UILabel()
    
    lazy var collectionView1 = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    lazy var collectionView2 = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    lazy var collectionView3 = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    
    lazy var titlesAndCollectionViews = [
        (titleLabel1, collectionView1),
        (titleLabel2, collectionView2),
        (titleLabel3, collectionView3)
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        titlesAndCollectionViews.forEach { (title, collectionView) in
            contentView.addSubview(title)
            contentView.addSubview(collectionView)
        }
    }
    
    override func configureLayout() {
        scrollView.isScrollEnabled = true
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }

        contentView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.snp.width)
            make.edges.equalTo(scrollView)
        }

        var lastView: UIView? = nil
        titlesAndCollectionViews.forEach { (title, collectionView) in
            title.snp.makeConstraints { make in
                if let last = lastView {
                    make.top.equalTo(last.snp.bottom).offset(30)
                } else {
                    make.top.equalTo(contentView.snp.top).offset(20)
                }
                make.horizontalEdges.equalTo(contentView).inset(16)
            }
            
            collectionView.snp.makeConstraints { make in
                make.top.equalTo(title.snp.bottom).offset(10)
                make.width.equalTo(contentView)
                make.leading.equalTo(contentView).offset(16)
                make.height.equalTo(240)
            }
            collectionView.showsHorizontalScrollIndicator = false
            
            lastView = collectionView
        }
        
        lastView?.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.snp.bottom).offset(-20)
        }
    }

    
    override func configureView() {
        backgroundColor = .white
        titlesAndCollectionViews.forEach { (title, _) in
            title.font = UIFont.systemFont(ofSize: 22, weight: .bold)
            title.textAlignment = .left
            title.textColor = .black
        }
        titleLabel1.text = "골든 아워"
        titleLabel2.text = "비즈니스 및 업무"
        titleLabel3.text = "건축 및 인테리어"
    }
    
    private func createCollectionViewLayout() -> UICollectionViewFlowLayout {
        let spacing: CGFloat = 10
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = deviceWidth - 20
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.itemSize = CGSizeMake(cellWidth / 2, (cellWidth / 2) * 1.2)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        return layout
    }
    
}
