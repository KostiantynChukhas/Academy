//
//  ContactsViewController.swift
//  Academy
//
//  Created by Konstantin Chukhas on 14.11.2021.
//

import UIKit

class ContactsViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet var contentView: UIView!
    
    var viewModel: ContactsViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        navigationView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 10)
        contentView.layer.cornerRadius = 10
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        contentView.addShadow(offset: CGSize.init(width: 0, height: 15), color: UIColor.black, radius: 5.0, opacity: 0.70)
        
    }
    
    private func setupTable() {
        tableView.registerNib(cellType: ContactsTableViewCell.self)
        tableView.registerNib(cellType: ContactsHeaderTableViewCell.self)
        tableView.registerNib(cellType: ContactsFooterTableViewCell.self)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        //        tableView.bounces = false
        //        tableView.alwaysBounceVertical = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
    }
    
    @IBAction func menuButtonAction(_ sender: Any) {
        DispatchQueue.main.async {
            self.viewModel.route(to: .menu)
        }
    }
    
    deinit {
        printDeinit(self)
    }
}

//MARK: UITableViewDataSource -
extension ContactsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row  != 4 {
            guard let cell: ContactsTableViewCell = tableView.dequeCell(for: indexPath) else { return UITableViewCell() }
            cell.setupCell(indexPath.row)
            return cell
        }
        if indexPath.row  == 4 {
            guard let cell: ContactsFooterTableViewCell = tableView.dequeCell(for: indexPath) else { return UITableViewCell() }
            return cell
        }
        return UITableViewCell()
    }
    
}

//MARK: UITableViewDelegate -
extension ContactsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: ContactsHeaderTableViewCell.reuseId) as! ContactsHeaderTableViewCell
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
