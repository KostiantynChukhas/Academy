//
//  ScheduleDetailViewController.swift
//  Academy
//
//  Created by Konstantin Chukhas on 14.11.2021.
//

import UIKit

class ScheduleDetailViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet var contentView: UIView!
    
    var viewModel: ScheduleDetailViewModelType!
    
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
        tableView.registerNib(cellType: ScheduleDetailTableViewCell.self)
        tableView.registerNib(cellType: HeaderArrowTableViewCell.self)
        tableView.registerNib(cellType: EmptyScheduleTableViewCell.self)
        
        tableView.dataSource = self
        tableView.delegate = self
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
    
    @IBAction func filterButton(_ sender: Any) {
        viewModel.route(to: .filter)
    }
    
    deinit {
        printDeinit(self)
    }
}

//MARK: UITableViewDataSource -
extension ScheduleDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if viewModel.scheduleResult.count == 0 {
            return 1
        }else{
            return viewModel.scheduleResult.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.scheduleResult.count == 0 {
            guard let cell: EmptyScheduleTableViewCell = tableView.dequeCell(for: indexPath) else { return UITableViewCell() }
            return cell
        }else{
            guard let cell: ScheduleDetailTableViewCell = tableView.dequeCell(for: indexPath) else { return UITableViewCell() }
            let schedule = viewModel.scheduleResult[indexPath.row]
            cell.setupCell(model: schedule)
            return cell
        }
    }
}

//MARK: UITableViewDelegate -
extension ScheduleDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: HeaderArrowTableViewCell.reuseId) as! HeaderArrowTableViewCell
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
}
