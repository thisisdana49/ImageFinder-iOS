//
//  SearchCollectionViewCell.swift
//  ImageFinder
//
//  Created by 조다은 on 1/17/25.
//

import UIKit

class KeywordSearchCollectionViewCell: UICollectionViewCell {
    
    static let id = "KeywordSearchCollectionViewCell"

    let thumbnailImageView = UIImageView()
    let starBaseView =  UILabel()
    let starLabel = UILabel()
    let likeBaseView = UIView()
    let likeButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func configureData(item: ItemDetail) {
//        if let image = URL(string: item.image) {
//            thumbnailImageView.kf.setImage(with: image)
//            thumbnailImageView.kf.setImage(with: image)
//        }
//        mallNameLabel.text = item.mallName
//        titleLabel.text = item.title.cleanedTag()
//        priceLabel.text = Int(item.lprice)?.formatted(.number)
//    }

    internal func configureHierarchy() {
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(starBaseView)
//        likeBaseView.addSubview(likeButton)
        contentView.addSubview(starLabel)
    }
    
    internal func configureLayout() {
        thumbnailImageView.snp.makeConstraints { make in
            make.size.equalToSuperview()
            make.center.equalToSuperview()
        }
 
        starBaseView.snp.makeConstraints { make in
            make.size.equalTo(thumbnailImageView)
        }
        
        starLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(8)
            make.width.equalTo(120)
            make.height.equalTo(40)
        }
    }
    
    internal func configureView() {
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.image = UIImage(systemName: "star.fill")
        
        starLabel.backgroundColor = .black.withAlphaComponent(0.3)
        starLabel.layer.cornerRadius = 20
        starLabel.text = "★ 1,234"
    }

}
