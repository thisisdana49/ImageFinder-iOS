//
//  ViewController.swift
//  ImageFinder
//
//  Created by 조다은 on 1/17/25.
//

import UIKit

class KeywordSearchViewController: UIViewController {

    var photos: [PhotoDetail] = []
    var keyword: String = "" {
        didSet { page = 1 }
    }
    var orderBy: String = "relevant"
    var filteredBy: String?
    
    var page: Int = 1
    var totalPages: Int = 0
    var isEnd: Bool {
        return totalPages > 0 && page >= totalPages
    }
    
    let mainView = KeywordSearchView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.orderButton.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
        mainView.colorButtons.forEach { button in
            button.addTarget(self, action: #selector(colorButtonTapped), for: .touchUpInside)
        }
        
        configureNavController()
        configureCollectionView()
    }
    
    private func callRequest() {
        NetworkManager.shared.searchWithKeyWord(keyword: keyword, page: page, orderBy: orderBy, filteredBy: filteredBy) { value in
            if self.page == 1 {
                print(#function, self.orderBy)
                self.totalPages = value.totalPages
                self.photos = value.results
            } else {
                self.photos.append(contentsOf: value.results)
            }
            self.mainView.collectionView.reloadData()
            
            if self.page == 1 {
                self.mainView.collectionView.scrollsToTop = true
            }
        }
    }

    @objc
    func orderButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        orderBy = sender.isSelected ? "latest" : "relevant"
        print(#function, sender.isSelected, orderBy)
        callRequest()
    }
    
    @objc
    func colorButtonTapped(_ sender: CustomFilterButton) {
        sender.isSelected.toggle()
        mainView.colorButtons.forEach { button in
            if sender != button {
                button.isSelected = false
            }
        }
        
        if let selectedButton = mainView.colorButtons.first(where: { $0.isSelected }) {
            filteredBy = selectedButton.name
        } else {
            filteredBy = nil
        }
        
        filteredBy = sender.name
        callRequest()
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

// MARK: UICollectionView DataSource Prefetching
extension KeywordSearchViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if (photos.count - 2) == indexPath.item && !isEnd {
                page += 1
                callRequest()
            }
        }
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
        mainView.collectionView.prefetchDataSource = self
        mainView.collectionView.register(ThumbnailCollectionView.self, forCellWithReuseIdentifier: ThumbnailCollectionView.id)
    }
}
