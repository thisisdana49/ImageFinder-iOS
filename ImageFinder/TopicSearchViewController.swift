//
//  TopicSearchViewController.swift
//  ImageFinder
//
//  Created by 조다은 on 1/18/25.
//

import UIKit

class TopicSearchViewController: UIViewController {
    
    let keywords: [String] = ["golden-hour", "business-work", "architecture-interior"]
    
    var photosOne: [PhotoDetail] = []
    var photosTwo: [PhotoDetail] = []
    var photosThree: [PhotoDetail] = []
    
    let mainView = TopicSearchView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callRequest()
        
        configureNavController()
        configureCollectionView()
    }
    
    func configureNavController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "OUR TOPIC"
    }
    
    private func callRequest() {
        NetworkManager.shared.searchWithTopic(topic: keywords[0]) { value in
            self.photosOne = value
            self.mainView.collectionView.reloadData()
        }
    }
}

// MARK: UICollectionView Delegate, UICollectionView DataSource
extension TopicSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosOne.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeywordSearchCollectionViewCell.id, for: indexPath) as? KeywordSearchCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
    
    func configureCollectionView() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        // TODO: Prefetch delegate
        mainView.collectionView.register(KeywordSearchCollectionViewCell.self, forCellWithReuseIdentifier: KeywordSearchCollectionViewCell.id)
    }
}
