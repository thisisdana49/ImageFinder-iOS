//
//  ImageDetailViewController.swift
//  ImageFinder
//
//  Created by 조다은 on 1/17/25.
//

import UIKit

class ImageDetailViewController: UIViewController {
    
    var photo: PhotoDetail?
    var photoStatistics: PhotoStatistic?
    
    let mainView = ImageDetailView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavController()
        
        // TODO: 위치에 대한 고민, UI와 관련해서 서비스
        callRequest()
    }
    
    func configureNavController() {
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
    }
    
    private func callRequest() {
        guard let photoID = photo?.id else { return }
        NetworkManager.shared.searchPhoto(api: .withID(id: photoID), type: PhotoStatistic.self) { value in
            self.photoStatistics = value
            self.mainView.configureData(photo: self.photo, photoStatistics: self.photoStatistics)
        } failHandler: { error in
            print("network error", error)
        }
    }
    
}
