//
//  AlertManager.swift
//  ImageFinder
//
//  Created by 조다은 on 1/22/25.
//

import UIKit

final class AlertManager {
    
    static let shared = AlertManager()
    
    private init() {}
    
    func showAlert(
        on viewController: UIViewController,
        title: String,
        message: String,
        actions: [UIAlertAction] = [UIAlertAction(title: "확인", style: .default)]
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { alert.addAction($0) }
        DispatchQueue.main.async {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
}
