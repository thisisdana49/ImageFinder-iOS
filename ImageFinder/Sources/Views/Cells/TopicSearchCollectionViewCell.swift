//
//  SearchCollectionViewCell.swift
//  ImageFinder
//
//  Created by 조다은 on 1/17/25.
//

import UIKit
import Kingfisher

final class TopicSearchCollectionViewCell: UICollectionViewCell {
    
    static let id = "TopicSearchCollectionViewCell"

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

    private func configureHierarchy() {
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(starBaseView)
//        likeBaseView.addSubview(likeButton)
        contentView.addSubview(starLabel)
    }
    
    private func configureLayout() {
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
    
    private func configureView() {
        thumbnailImageView.contentMode = .scaleAspectFill
        // MARK: 왜 해줘야 하지?
        thumbnailImageView.clipsToBounds = true
        thumbnailImageView.layer.cornerRadius = 15
        starLabel.backgroundColor = .black.withAlphaComponent(0.3)
        starLabel.font = UIFont.systemFont(ofSize: 14)
        starLabel.textColor = .white
        starLabel.clipsToBounds = true
        starLabel.layer.cornerRadius = 15
    }

}
