//
//  ViewController.swift
//  ImageFinder
//
//  Created by 조다은 on 1/17/25.
//

import UIKit

class SearchViewController: UIViewController {

    let mainView = SearchView()
    
    override func loadView() {
        view = mainView
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavController()
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
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
    }
}
