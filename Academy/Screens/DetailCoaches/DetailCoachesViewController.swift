//
//  DetailCoachesViewController.swift
//  Academy
//
//  Created by Konstantin Chukhas on 14.11.2021.
//

import UIKit

class DetailCoachesViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet var contentView: UIView!
    
    var viewModel: DetailCoachesViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        bindViewModelData()
    }
    
    private func bindViewModelData() {
        viewModel.onReload = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        navigationView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 10)
        contentView.layer.cornerRadius = 10
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        contentView.addShadow(offset: CGSize.init(width: 0, height: 15), color: UIColor.black, radius: 5.0, opacity: 0.70)
    }
    
    private func setupTable() {
        tableView.registerNib(cellType: DetailCoachesScheduleTableViewCell.self)
        tableView.registerNib(cellType: DetailCoachesEndAbonimentTableViewCell.self)
        tableView.registerNib(cellType: EmptyScheduleTableViewCell.self)
        
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
    }
    
    @IBAction func menuButtonAction(_ sender: Any) {
        DispatchQueue.main.async {
            self.viewModel.route(to: .menu)
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        viewModel.route(to: .back)
    }
    
    deinit {
        printDeinit(self)
    }
}


//MARK: UITableViewDataSource -
extension DetailCoachesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            
            if viewModel.scheduleResult.count == 0 {
                return 1
            }else{
                return viewModel.scheduleResult.count
            }
        case 1: return 1
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            
            if viewModel.scheduleResult.count == 0 {
                guard let cell: EmptyScheduleTableViewCell = tableView.dequeCell(for: indexPath) else { return UITableViewCell() }
                return cell
            }else{
                guard let cell: DetailCoachesScheduleTableViewCell = tableView.dequeCell(for: indexPath) else { return UITableViewCell() }
                let model = viewModel.scheduleResult[indexPath.row]
                cell.setupCell(model: model, avatar: viewModel.imageDataAvatar)
                return cell
            }
            
        case 1:
            guard let cell: DetailCoachesEndAbonimentTableViewCell = tableView.dequeCell(for: indexPath) else { return UITableViewCell() }
            guard let model = viewModel.filterModel else {
                let cell = UITableViewCell()
                cell.backgroundColor = .clear
                return cell
            }
            cell.setupCell(model: model)
            return cell
        default: return UITableViewCell()
        }
        
    }
}
