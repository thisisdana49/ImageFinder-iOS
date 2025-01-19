//
//  TabBarController.swift
//  ImageFinder
//
//  Created by 조다은 on 1/19/25.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let keywordVC = KeywordSearchViewController()
        let topicVC = TopicSearchViewController()
        
        keywordVC.tabBarItem.image = UIImage.init(systemName: "magnifyingglass")
        topicVC.tabBarItem.image = UIImage.init(systemName: "chart.line.uptrend.xyaxis")
        
        self.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0);
        
        let navigationKeyword = UINavigationController(rootViewController: keywordVC)
        let navigationTopic = UINavigationController(rootViewController: topicVC)
        
        setViewControllers([navigationKeyword, navigationTopic], animated: false)
    }
    
}
 
