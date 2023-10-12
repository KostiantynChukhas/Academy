//
//  TabBarItem.swift
//  Academy
//
//  Created by  on 01.04.2021.
//

import UIKit

enum TabBarItem {
    case home(HomeCoordinator)
//    case empty
    case profile(ProfileCoordinator)
}

extension TabBarItem {
    static var allCases: [TabBarItem] = [
        .home(HomeCoordinator()),
//        .empty,
        .profile(ProfileCoordinator())
    ]
    
    var title: String {
        switch self {
        case .home: return "Главная"
//        case .empty: return ""
        case .profile: return "Профиль"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .home: return UIImage(named: "home")
//        case .empty: return nil
        case .profile: return UIImage(named: "profile")
        }
    }
    
    var index: Int {
        switch self {
        case .home: return 0
//        case .empty: return -1
        case .profile: return 1
        }
    }
    
    var controller: UIViewController? {
        switch self {
        case .home(let coordinator): return coordinator.root
//        case .empty: return nil
        case .profile(let coordinator): return coordinator.root
        }
    }
}
