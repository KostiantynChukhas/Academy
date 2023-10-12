//
//  TabBarController.swift
//  Academy
//
//  Created by  on 31.03.2021.
//

import UIKit
import Stevia

protocol TappedScanButton {
    func tappedScanButton()
}

class TabBarController: UITabBarController {
    
    private let containerView = UIView()
    private let stackView = UIStackView()
    private var appCoordinator: AppCoordinator?
    
    var tapDelegate: TappedScanButton?
    var items: [TabBarItem] = []
    var window: UIWindow?
    
    private var buttons: [TabBarButton] = []
    
//    private lazy var scanButton: UIButton = {
//        let scanButton = UIButton()
//
//        scanButton.layer.cornerRadius = 85 / 2
//        scanButton.layer.borderWidth = 5
//        scanButton.backgroundColor = Style.Color.primaryColor
//        scanButton.layer.borderColor = UIColor.white.cgColor
//        scanButton.setImage(UIImage(named: "qr_code_placeholder"), for: .normal)
//        scanButton.addTarget(self, action: #selector(tappedScanButton), for: UIControl.Event.touchUpInside)
//        return scanButton
//    }()
    
//    @objc func tappedScanButton() {
//        tapDelegate?.tappedScanButton()
////        window = UIWindow(frame: UIScreen.main.bounds)
//
////        if let window = window {
////            appCoordinator = AppCoordinator(window: window)
////            appCoordinator?.start()
////        }
//     }
    
    private var inset: CGFloat {
        return UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
    }
    
    private var height: CGFloat {
        let height: CGFloat = inset > 0 ? 49: 64
        return inset + height
    }
    
    private var bottomOffset: CGFloat {
        return inset > 0 ? 50: 30
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCustomTabBar()
    }
    
    
    private func setupCustomTabBar() {
        self.tabBar.isHidden = true
        
        containerView.backgroundColor = Style.Color.black
        
        view.subviews { containerView }

//        scanButton.width(85)
//        scanButton.height(85)
        
        containerView.bottom(0)
        containerView.width(self.view.frame.width)
        containerView.height(height)
        containerView.centerHorizontally()

        stackView.distribution = .fillEqually
        
        let homeButton = TabBarButton()
        homeButton.item = .home(HomeCoordinator())
        homeButton.onClick = handleTap(button:)
        
        let space = UIView()
        space.backgroundColor = .clear
        
        let profileButton = TabBarButton()
        profileButton.item = .profile(ProfileCoordinator())
        profileButton.onClick = handleTap(button:)
        
        buttons.append(homeButton)
        buttons.append(profileButton)
        
        stackView.addArrangedSubview(homeButton)
        stackView.addArrangedSubview(space)
        stackView.addArrangedSubview(profileButton)
        
        containerView.subviews { stackView }
        
//        view.subviews { scanButton }
//
//        scanButton.bottom(bottomOffset)
//        scanButton.centerHorizontally()
        
        stackView.height(50)
        stackView.top(10)
        stackView.fillHorizontally()
        stackView.spacing = 0
        
        buttons.first?.isSelected = true
        viewControllers = TabBarItem.allCases.compactMap { $0.controller }
    }
    
    private func handleTap(button: TabBarButton) {
        buttons.forEach { $0.isSelected = false }
        button.isSelected = true
        
        if let index = buttons.firstIndex(of: button) {
            selectedIndex = index
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        containerView.roundCorners(corners: [.topLeft, .topRight], radius: Style.Radius.tabBar)
    }
    
}
