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
        let dispatchGroup = DispatchGroup()
        
        var fetchedPhotosOne: [PhotoDetail] = []
        var fetchedPhotosTwo: [PhotoDetail] = []
        var fetchedPhotosThree: [PhotoDetail] = []
        
        dispatchGroup.enter()
        NetworkManager.shared.searchWithTopic(topic: keywords[0]) { value in
            fetchedPhotosOne = value
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        NetworkManager.shared.searchWithTopic(topic: keywords[1]) { value in
            fetchedPhotosTwo = value
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        NetworkManager.shared.searchWithTopic(topic: keywords[2]) { value in
            fetchedPhotosThree = value
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.photosOne = fetchedPhotosOne
            self.photosTwo = fetchedPhotosTwo
            self.photosThree = fetchedPhotosThree
            
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThumbnailCollectionView.id, for: indexPath) as? ThumbnailCollectionView else { return UICollectionViewCell() }
        let photo = photosOne[indexPath.row]
        
        cell.configureData(item: photo)
        
        return cell
    }
    
    func configureCollectionView() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        // TODO: Prefetch delegate
        mainView.collectionView.register(ThumbnailCollectionView.self, forCellWithReuseIdentifier: ThumbnailCollectionView.id)
    }
}
