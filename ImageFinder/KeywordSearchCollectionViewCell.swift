//
//  SearchCollectionViewCell.swift
//  ImageFinder
//
//  Created by 조다은 on 1/17/25.
//

import UIKit
import Kingfisher

class KeywordSearchCollectionViewCell: UICollectionViewCell {
    
    static let id = "KeywordSearchCollectionViewCell"

    let thumbnailImageView = UIImageView()
    let starBaseView =  UILabel()
    let starLabel = BasePaddingLabel()
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
    
    func configureData(item: PhotoDetail) {
        if let image = URL(string: item.urls.small) {
            thumbnailImageView.kf.setImage(with: image)
        }
        
        starLabel.text = "★ \(item.likes.formatted(.number))"
    }

    internal func configureHierarchy() {
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(starBaseView)
        contentView.addSubview(starLabel)
    }
    
    internal func configureLayout() {
        thumbnailImageView.snp.makeConstraints { make in
            make.size.equalTo(contentView.snp.size)
            make.center.equalToSuperview()
        }
 
        starBaseView.snp.makeConstraints { make in
            make.size.equalTo(contentView.snp.size)
        }
        
        starLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(8)
            make.height.equalTo(30)
        }
    }
    
    internal func configureView() {
        clipsToBounds = true
        thumbnailImageView.contentMode = .scaleAspectFill
        starLabel.backgroundColor = .black.withAlphaComponent(0.3)
        starLabel.font = UIFont.systemFont(ofSize: 14)
        starLabel.textColor = .white
        starLabel.clipsToBounds = true
        starLabel.layer.cornerRadius = 15
    }

}
