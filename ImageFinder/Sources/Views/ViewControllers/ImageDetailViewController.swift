//
//  ImageDetailViewController.swift
//  ImageFinder
//
//  Created by 조다은 on 1/17/25.
//

import UIKit

final class ImageDetailViewController: UIViewController {
    
    let viewModel = ImageDetailViewModel()
    let mainView = ImageDetailView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavController()
        
        bindData()
    }
    
    private func bindData() {
        viewModel.input.viewDidLoad.value = ()

        viewModel.output.photoStatistics.lazyBind { [weak self] value in
            self?.mainView.configureData(photo: self?.viewModel.output.photo, photoStatistics: value)
        }
    }
    
    private func configureNavController() {
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.topItem?.title = ""
    }
    
}
