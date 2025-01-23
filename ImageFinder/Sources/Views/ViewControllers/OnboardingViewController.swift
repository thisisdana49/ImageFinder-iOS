//
//  OnboardingViewController.swift
//  SeSACDay22Assignment
//
//  Created by Jack on 1/23/25.
//

import UIKit
import SnapKit

class OnboardingViewController: UIViewController {
    
    var isFirst = false
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(50)
        }
        button.layer.cornerRadius = 25
        button.backgroundColor = .white
        button.setTitleColor(.darkGray, for: .normal)
        button.setTitle("시작하기", for: .normal)
        button.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
    }
    
    @objc
    func startButtonClicked() {
        UserDefaultsManager.set(to: isFirst, forKey: .isFirst)
        print(UserDefaultsManager.get(forKey: .isFirst) as! Bool)
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windowScene.windows.first else { return }

        window.rootViewController = UINavigationController(rootViewController: ProfileViewController())
        window.makeKeyAndVisible()
    }
    
}
