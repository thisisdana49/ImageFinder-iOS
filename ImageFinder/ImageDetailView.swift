//
//  ImageDetailView.swift
//  ImageFinder
//
//  Created by 조다은 on 1/17/25.
//

import UIKit

final class ImageDetailView: BaseView {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let informView = UIStackView()
    let imageView = UIImageView()
    
    let informHeaderView = UIView()
    let informHeaderLabel = UILabel()
    
    let informSizeView = ImageDetailInformView()
    let informViewsView = ImageDetailInformView()
    let informDownloadsView = ImageDetailInformView()
    let chartHeaderLabel = UILabel()
    
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
        scrollView.backgroundColor = .white
        contentView.backgroundColor = .white

        contentView.addSubview(informView)
        contentView.addSubview(imageView)

        imageView.contentMode = .scaleAspectFit
        
        informView.addSubview(informHeaderView)
        informHeaderView.addSubview(informHeaderLabel)
        informView.addSubview(informSizeView)
        informView.addSubview(informViewsView)
        informView.addSubview(informDownloadsView)
        informView.addSubview(chartHeaderLabel)

        informView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(contentView)
            make.height.equalTo(400)
        }
        
        informHeaderView.snp.makeConstraints { make in
            make.top.equalTo(informView).offset(20)
            make.leading.equalTo(informView).offset(16)
            make.size.equalTo(100)
        }
        
        informHeaderLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(informHeaderView)
        }
        
        informSizeView.snp.makeConstraints { make in
            make.top.equalTo(informView).offset(20)
            make.leading.equalTo(informHeaderView.snp.trailing).offset(8)
            make.trailing.equalTo(informView).inset(16)
            make.height.equalTo(informHeaderView).multipliedBy(0.33)
        }
        
        informViewsView.snp.makeConstraints { make in
            make.top.equalTo(informSizeView.snp.bottom)
            make.leading.equalTo(informHeaderView.snp.trailing).offset(8)
            make.trailing.equalTo(informView).inset(16)
            make.height.equalTo(informHeaderView).multipliedBy(0.33)
        }
        
        informDownloadsView.snp.makeConstraints { make in
            make.top.equalTo(informViewsView.snp.bottom)
            make.leading.equalTo(informHeaderView.snp.trailing).offset(8)
            make.trailing.equalTo(informView).inset(16)
            make.height.equalTo(informHeaderView).multipliedBy(0.33)
        }
        
        chartHeaderLabel.snp.makeConstraints { make in
            make.top.equalTo(informHeaderView.snp.bottom).offset(20)
            make.leading.equalTo(informView).offset(16)
        }

        imageView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView)
            make.top.equalTo(contentView)
            make.bottom.equalTo(informView.snp.top)

            make.height.equalTo(imageView.snp.width).multipliedBy(0.75).priority(.medium)
        }
    }

    func configureData(photo: PhotoDetail?, photoStatistics: PhotoStatistic?) {
        guard let photo = photo, let imageURL = URL(string: photo.urls.full), let photoStatistics = photoStatistics else { return }

        imageView.kf.setImage(with: imageURL) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let imageResult):
                let image = imageResult.image
                let imageWidth = image.size.width
                let imageHeight = image.size.height
                
                let aspectRatio = imageHeight / imageWidth
                
                self.imageView.snp.remakeConstraints { make in
                    make.horizontalEdges.equalTo(self.contentView)
                    make.top.equalTo(self.contentView)
                    make.bottom.equalTo(self.informView.snp.top)

                    make.height.equalTo(self.imageView.snp.width).multipliedBy(aspectRatio)
                }

                self.setNeedsLayout()
                self.layoutIfNeeded()

            case .failure(let error):
                print("Image loading failed: \(error.localizedDescription)")
            }
        }
        
        informHeaderLabel.text = "정보"
        informHeaderLabel.numberOfLines = 0
        informHeaderLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        informSizeView.titleLabel.text = "크기"
        informSizeView.contentLabel.text = "\(photo.size)"
        
        informViewsView.titleLabel.text = "조회수"
        informViewsView.contentLabel.text = "\(photoStatistics.views.total.formatted(.number))"
        
        informDownloadsView.titleLabel.text = "다운로드"
        informDownloadsView.contentLabel.text = "\(photoStatistics.downloads.total.formatted(.number))"
        
        chartHeaderLabel.text = "차트"
        chartHeaderLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }

}

