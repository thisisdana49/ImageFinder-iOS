//
//  UICollectionView+Extensions.swift
//  ImageFinder
//
//  Created by 조다은 on 1/19/25.
//

import UIKit

extension UICollectionView {
    // 1
    func setEmptyMessage(_ message: String) {
        let messageLabel: UILabel = {
            let label = UILabel()
            label.text = message
            label.textColor = .black
            label.numberOfLines = 0;
            label.textAlignment = .center;
            label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
            label.sizeToFit()
            return label
        }()
        self.backgroundView = messageLabel;
    }
    // 2
    func restore() {
        self.backgroundView = nil
    }
}
