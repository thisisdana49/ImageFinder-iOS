//
//  ImageDetailViewModel.swift
//  ImageFinder
//
//  Created by 조다은 on 2/10/25.
//

import Foundation

class ImageDetailViewModel: BaseViewModel {
    
    private(set) var input: Input
    private(set) var output: Output
    
    struct Input {
        var viewWillLoad: Observable<PhotoDetail?> = Observable(nil)
        var viewDidLoad: Observable<Void?> = Observable(nil)
    }
    
    struct Output {
        var photo: PhotoDetail?
        var photoStatistics: Observable<PhotoStatistic?> = Observable(nil)
    }
    
    init() {
        input = Input()
        output = Output()
        transform()
    }
    
    func transform() {
        input.viewWillLoad.lazyBind { [weak self] value in
            self?.output.photo = value
        }
        
        input.viewDidLoad.lazyBind { [weak self] _ in
            self?.fetchData()
        }
    }
    
    private func fetchData() {
        guard let photoID = output.photo?.id else { return }
        NetworkManager.shared.searchPhoto(api: .withID(id: photoID), type: PhotoStatistic.self) { value in
//            dump(value)
            self.output.photoStatistics.value = value
//            self.mainView.configureData(photo: self.photo, photoStatistics: self.photoStatistics)
        } failHandler: { errorMessage in
//            AlertManager.shared.showAlert(
//                on: self,
//                title: "네트워크 오류",
//                message: errorMessage,
//                actions: [
//                    UIAlertAction(title: "확인", style: .default),
//                    UIAlertAction(title: "취소", style: .cancel)
//                ]
//            )
        }
    }
    
}
