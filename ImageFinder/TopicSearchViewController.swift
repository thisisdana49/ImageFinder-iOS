//
//  TopicSearchViewController.swift
//  ImageFinder
//
//  Created by 조다은 on 1/18/25.
//

import UIKit

struct Section {
    let topic: String
    let photos: [PhotoDetail]
}

class TopicSearchViewController: UIViewController {
    
    let keywords: [String] = ["golden-hour", "business-work", "architecture-interior"]
    
    var sections: [Section] = []
    
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
            
            self.mainView.collectionView1.reloadData()
            self.mainView.collectionView2.reloadData()
            self.mainView.collectionView3.reloadData()
        }
    }

}

// MARK: UICollectionView Delegate, UICollectionView DataSource
extension TopicSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mainView.collectionView1 {
            return photosOne.count
        } else if collectionView == mainView.collectionView2 {
            return photosTwo.count            
        } else {
            return photosThree.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThumbnailCollectionView.id, for: indexPath) as? ThumbnailCollectionView else { return UICollectionViewCell() }
        
        switch collectionView {
        case mainView.collectionView1 :
            let photo = photosOne[indexPath.row]
            cell.configureData(item: photo)
        case mainView.collectionView2 :
            let photo = photosTwo[indexPath.row]
            cell.configureData(item: photo)
        case mainView.collectionView3 :
            let photo = photosThree[indexPath.row]
            cell.configureData(item: photo)
        default:
            let photo = photosOne[indexPath.row]
            cell.configureData(item: photo)
        }
                
        return cell
    }
    
    // TODO: Prefetch delegate
    func configureCollectionView() {
        mainView.collectionView1.delegate = self
        mainView.collectionView1.dataSource = self
        mainView.collectionView1.register(ThumbnailCollectionView.self, forCellWithReuseIdentifier: ThumbnailCollectionView.id)
        
        mainView.collectionView2.delegate = self
        mainView.collectionView2.dataSource = self
        mainView.collectionView2.register(ThumbnailCollectionView.self, forCellWithReuseIdentifier: ThumbnailCollectionView.id)
        
        mainView.collectionView3.delegate = self
        mainView.collectionView3.dataSource = self
        mainView.collectionView3.register(ThumbnailCollectionView.self, forCellWithReuseIdentifier: ThumbnailCollectionView.id)
    }
}
