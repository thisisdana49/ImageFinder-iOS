//
//  TopicSearchViewController.swift
//  ImageFinder
//
//  Created by 조다은 on 1/18/25.
//

import UIKit

final class TopicSearchViewController: UIViewController {
    
    private let keywords: [String] = ["golden-hour", "business-work", "architecture-interior"]
    
    private var photosOne: [PhotoDetail] = []
    private var photosTwo: [PhotoDetail] = []
    private var photosThree: [PhotoDetail] = []
    
    private let mainView = TopicSearchView()
    
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
        NetworkManager.shared.searchPhoto(api: .withTopic(topic: keywords[0]), type: [PhotoDetail].self) { value in
            fetchedPhotosOne = value
            dispatchGroup.leave()
        } failHandler: { error in
            print(error)
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        NetworkManager.shared.searchPhoto(api: .withTopic(topic: keywords[1]), type: [PhotoDetail].self) { value in
            fetchedPhotosTwo = value
            dispatchGroup.leave()
        } failHandler: { error in
            print(error)
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        NetworkManager.shared.searchPhoto(api: .withTopic(topic: keywords[2]), type: [PhotoDetail].self) { value in
            fetchedPhotosThree = value
            dispatchGroup.leave()
        } failHandler: { error in
            print(error)
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicSearchCollectionViewCell.id, for: indexPath) as? TopicSearchCollectionViewCell else { return UICollectionViewCell() }
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ImageDetailViewController()
        switch collectionView {
        case mainView.collectionView1 :
            vc.photo = photosOne[indexPath.row]
        case mainView.collectionView2 :
            vc.photo = photosTwo[indexPath.row]
        case mainView.collectionView3 :
            vc.photo = photosThree[indexPath.row]
        default:
            vc.photo = photosOne[indexPath.row]
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // TODO: Prefetch delegate
    func configureCollectionView() {
        mainView.collectionView1.delegate = self
        mainView.collectionView1.dataSource = self
        mainView.collectionView1.register(TopicSearchCollectionViewCell.self, forCellWithReuseIdentifier: TopicSearchCollectionViewCell.id)
        
        mainView.collectionView2.delegate = self
        mainView.collectionView2.dataSource = self
        mainView.collectionView2.register(TopicSearchCollectionViewCell.self, forCellWithReuseIdentifier: TopicSearchCollectionViewCell.id)
        
        mainView.collectionView3.delegate = self
        mainView.collectionView3.dataSource = self
        mainView.collectionView3.register(TopicSearchCollectionViewCell.self, forCellWithReuseIdentifier: TopicSearchCollectionViewCell.id)
    }
}
