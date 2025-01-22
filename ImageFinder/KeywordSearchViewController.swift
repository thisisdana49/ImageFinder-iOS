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
        didSet {
            page = 1
            filterBy = nil
        }
    }
    var orderBy: String = "relevant" {
        didSet {
            page = 1
        }
    }
    
    var filterBy: String? = nil {
        didSet {
            page = 1
        }
    }
    
    var page: Int = 1
    var totalPages: Int = 0
    var isEnd: Bool {
        return totalPages > 0 && page >= totalPages
    }
    var isNoData: Bool = false
    
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
        NetworkManager.shared.searchWithKeyWord(api: .withKeyword(keyword: keyword, page: page, orderBy: orderBy, filterBy: filterBy)) { value in
            print(#function, "order", self.orderBy)
            if self.page == 1 {
                if value.total == 0 { self.isNoData = true }
                else { self.isNoData = false }
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
            filterBy = selectedButton.name
        } else {
            filterBy = nil
        }

        callRequest()
    }
    
    func configureNavController() {
        let searchController = UISearchController()
        let customSearchBar = CustomSearchBar()
        customSearchBar.delegate = self
        
        searchController.automaticallyShowsCancelButton = false
        searchController.hidesNavigationBarDuringPresentation = false
        
        searchController.searchBar.removeFromSuperview()
        searchController.setValue(customSearchBar, forKey: "searchBar")

        self.navigationItem.searchController = searchController
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationItem.title = "IMAGE FINDER"
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
        if photos.count == 0 && !isNoData {
            collectionView.setEmptyMessage("사진을 검색해보세요.")
        } else if photos.count == 0 && isNoData {
            collectionView.setEmptyMessage("\"\(keyword)\"에 대한 검색 결과가 없어요😔")
        } else {
            collectionView.restore()
        }
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeywordSearchCollectionViewCell.id, for: indexPath) as? KeywordSearchCollectionViewCell else { return UICollectionViewCell() }
        let photo = photos[indexPath.row]
        
        cell.configureData(item: photo)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ImageDetailViewController()
        vc.photo = photos[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func configureCollectionView() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.prefetchDataSource = self
        mainView.collectionView.register(KeywordSearchCollectionViewCell.self, forCellWithReuseIdentifier: KeywordSearchCollectionViewCell.id)
    }
}
