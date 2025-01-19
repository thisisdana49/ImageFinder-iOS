//
//  ViewController.swift
//  ImageFinder
//
//  Created by 조다은 on 1/17/25.
//

import UIKit

class KeywordSearchViewController: UIViewController {

    var photos: [PhotoDetail] = []
    var keyword: String = ""
    
    let mainView = KeywordSearchView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavController()
        configureCollectionView()
    }
    
    private func callRequest() {
        NetworkManager.shared.searchWithKeyWord(keyword: keyword) { value in
            self.photos = value.results
            self.mainView.collectionView.reloadData()
        }
    }

    func configureNavController() {
        let searchController = UISearchController()
        let searchBar = searchController.searchBar
        searchBar.delegate = self
        
        if let textField = searchBar.value(forKey: "searchField") as? UITextField, let leftView = textField.leftView as? UIImageView {
            textField.backgroundColor = .systemGray6
            textField.textColor = .blue
            textField.attributedPlaceholder = NSAttributedString(
                string: "키워드 검색",
                attributes: [.foregroundColor: UIColor.systemGray]
            )
            
            leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
            leftView.tintColor = .systemGray
        }
        self.navigationItem.searchController = searchController
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationItem.title = "IMAGE FINDER"
        
        self.navigationController?.navigationBar.tintColor = .white
    }
}

// MARK: UISearchBar Delegate
extension KeywordSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let inputWord = searchBar.text else { return }
        keyword = inputWord
        callRequest()
    }
}

// MARK: UICollectionView Delegate, UICollectionView DataSource
extension KeywordSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThumbnailCollectionView.id, for: indexPath) as? ThumbnailCollectionView else { return UICollectionViewCell() }
        let photo = photos[indexPath.row]
        
        cell.configureData(item: photo)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        let vc = ImageDetailViewController()
        vc.photo = photos[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func configureCollectionView() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        // TODO: Prefetch delegate
        mainView.collectionView.register(ThumbnailCollectionView.self, forCellWithReuseIdentifier: ThumbnailCollectionView.id)
    }
}
