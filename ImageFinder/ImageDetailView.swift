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
    let imageView = UIImageView()
    
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

        contentView.addSubview(topView)
        contentView.addSubview(informView)
        contentView.addSubview(imageView)

//        topView.backgroundColor = .systemOrange
        informView.backgroundColor = .white
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFit
        
        informView.addSubview(informHeaderLabel)
        informView.addSubview(informSizeView)
        informView.addSubview(informViewsView)
        informView.addSubview(informDownloadsView)
        informView.addSubview(chartHeaderLabel)

        topView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView)
            make.height.equalTo(80)
        }

        informView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(contentView)
            make.height.equalTo(400)
        }
        
        informHeaderLabel.snp.makeConstraints { make in
            make.top.equalTo(informView).offset(20)
            make.leading.equalTo(informView).offset(16)
            make.size.equalTo(100)
        }
        
        informSizeView.snp.makeConstraints { make in
            make.top.equalTo(informView).offset(20)
            make.leading.equalTo(informHeaderLabel.snp.trailing).offset(8)
            make.trailing.equalTo(informView).inset(16)
            make.height.equalTo(informHeaderLabel).multipliedBy(0.33)
        }
        
        informViewsView.snp.makeConstraints { make in
            make.top.equalTo(informSizeView.snp.bottom)
            make.leading.equalTo(informHeaderLabel.snp.trailing).offset(8)
            make.trailing.equalTo(informView).inset(16)
            make.height.equalTo(informHeaderLabel).multipliedBy(0.33)
        }
        
        informDownloadsView.snp.makeConstraints { make in
            make.top.equalTo(informViewsView.snp.bottom)
            make.leading.equalTo(informHeaderLabel.snp.trailing).offset(8)
            make.trailing.equalTo(informView).inset(16)
            make.height.equalTo(informHeaderLabel).multipliedBy(0.33)
        }
        
        chartHeaderLabel.snp.makeConstraints { make in
            make.top.equalTo(informHeaderLabel.snp.bottom).offset(20)
            make.leading.equalTo(informView).offset(16)
        }

        imageView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView)
            make.top.equalTo(topView.snp.bottom)
            make.bottom.equalTo(informView.snp.top)

            make.height.equalTo(imageView.snp.width).multipliedBy(0.75).priority(.medium)
        }
    }

    func configureData(photo: PhotoDetail?, photoStatistics: PhotoStatistic?) {
        guard let photo = photo, let imageURL = URL(string: photo.urls.raw) else { return }

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
                    make.top.equalTo(self.topView.snp.bottom)
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
        informHeaderLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
//        informHeaderLabel.backgroundColor = .systemBlue
        
        informSizeView.titleLabel.text = "크기"
        informSizeView.contentLabel.text = "\(photo.size)"
        
        informViewsView.titleLabel.text = "조회수"
        informViewsView.contentLabel.text = "\(photoStatistics?.views.total ?? 0)"
        
        informDownloadsView.titleLabel.text = "다운로드"
        informDownloadsView.contentLabel.text = "\(photoStatistics?.downloads.total ?? 0)"
        
        chartHeaderLabel.text = "차트"
        chartHeaderLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }

}

