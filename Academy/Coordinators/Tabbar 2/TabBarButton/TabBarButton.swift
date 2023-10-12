//
//  TabBarButton.swift
//  Academy
//
//  Created by  on 01.04.2021.
//

import UIKit

@IBDesignable
class TabBarButton: UIView {
    @IBOutlet weak var tabImageView: UIImageView!
    @IBOutlet weak var tabTitle: UILabel!

    @IBInspectable var isSelected: Bool = false {
        didSet {
            let color = isSelected ? Style.Color.primaryColor: .white
            tabTitle.textColor = color
            tabImageView.image = tabImageView.image?.withTintColor(color)
        }
    }
    
    var onClick: (TabBarButton) -> Void = { _ in }
    
    var item: TabBarItem = .profile(ProfileCoordinator()) {
        didSet {
            tabTitle.text = item.title
            tabImageView.image = item.image
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        nibSetup()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func handleTap() {
        onClick(self)
        
    }
}
