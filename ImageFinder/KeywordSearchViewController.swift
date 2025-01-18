//
//  ViewController.swift
//  ImageFinder
//
//  Created by 조다은 on 1/17/25.
//

import UIKit

class KeywordSearchViewController: UIViewController {

    let mainView = KeywordSearchView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavController()
        configureCollectionView()
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
        print(#function)
    }
}

// MARK: UICollectionView Delegate, UICollectionView DataSource
extension KeywordSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
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
