//
//  ScheduleFilterViewController.swift
//  Academy
//
//  Created by Konstantin Chukhas on 14.11.2021.
//

import UIKit

class ScheduleFilterViewController: UIViewController {
    
    var viewModel: ScheduleFilterViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func selectedButtonAction(_ sender: Any) {
        viewModel.route(to: .back)
    }
    
    deinit {
        printDeinit(self)
    }
}
