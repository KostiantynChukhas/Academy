//
//  ProfileViewController.swift
//  Academy
//
//  Created by  on 31.03.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    var viewModel: ProfileViewModelType!
    
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var navigationView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        logoutButton.layer.cornerRadius = Style.Radius.button
        
        viewModel.getClients()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        navigationView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 10)
    }
    
    @IBAction func logoutButtonAction(_ sender: Any) {
        viewModel.logout()
    }
    
}
