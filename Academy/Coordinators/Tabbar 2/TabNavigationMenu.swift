//
//  TabNavigationMenu.swift
//  Academy
//
//  Created by  on 03.04.2021.
//


import UIKit
import Stevia

class TabBarItemView: UIView {
    var item: TabBarItem?
    var titleLabel = UILabel()
    var iconView = UIImageView()

    var isSelected: Bool = false
    
    func setup(item: TabBarItem) {
        self.item = item
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
    }
    
    private func createCenterTab(item: TabBarItem) {
        iconView = UIImageView(frame: CGRect.zero)
        self.tag = 11
        iconView.tag = 13

        iconView.contentMode = .scaleAspectFit
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.clipsToBounds = true
        setSelection(state: false)
        
        let iconSize: CGFloat = 62
        let paddings: CGFloat = 8
        self.layer.backgroundColor = UIColor.clear.cgColor
        
        let bgIconView = createBgIconView(size: iconSize + paddings)

        self.addSubview(bgIconView)
        bgIconView.addSubview(iconView)
        
        self.width(frame.width)
        self.height(frame.height)
        
        bgIconView.height(iconSize + paddings)
        bgIconView.width(iconSize + paddings)
        
        iconView.height(iconSize + 3)
        iconView.width(iconSize + 3)

        titleLabel.height(0)
        iconView.CenterY == bgIconView.CenterY + 3
        iconView.CenterX == bgIconView.CenterX
    }
        
    private func createOtherTab(item: TabBarItem) {
        titleLabel = setTitleLabel(text: item.title)
        iconView = UIImageView(frame: CGRect.zero)
        self.tag = 11
        iconView.tag = 13

        iconView.contentMode = .scaleAspectFit
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.clipsToBounds = true
        setSelection(state: false)
        
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.addSubview(iconView)
        self.addSubview(titleLabel)
        
        let iconSize: CGFloat = 20
        iconView.height(iconSize)
        iconView.width(iconSize)

        iconView.CenterY == self.CenterY
        titleLabel.height(13)
        titleLabel.Bottom == self.Bottom - 16
        self.width(frame.width)
        iconView.CenterX == self.CenterX
        titleLabel.CenterX == self.CenterX
    }
    
    private func createBgIconView(size: CGFloat) -> UIView {
        let selfView = UIView(frame: CGRect(x: 7, y: 0, width: size, height: size))

        let cornerRadius = size / 2
        
        let bgIconView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        bgIconView.backgroundColor = .white
        bgIconView.roundCorners()
        
        selfView.addSubview(bgIconView)
        return selfView
    }
    
    func setSelection(state: Bool) {
        self.isSelected = state
        guard let item = item else { return }
        setNeedsLayout()
    }
    
    private func setTitleLabel(text: String) -> UILabel {
        let label = UILabel(frame: CGRect.zero)
        label.text = text
        label.tag = 12
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        
        return label
    }
    
    deinit {
        printDeinit(self)
    }
}
