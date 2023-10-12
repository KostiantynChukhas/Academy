//
//  NavigationView.swift
//  Academy
//
//  Created by  on 01.04.2021.
//

import UIKit

@IBDesignable
class NavigationView: UIView {
    
    @IBOutlet weak var appBarView: UIView!
    
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
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        print(self.frame)
        print(self.appBarView.frame)

        appBarView.roundCorners(corners: [.bottomRight, .bottomLeft], radius: Style.Radius.navigation)
    }

}
