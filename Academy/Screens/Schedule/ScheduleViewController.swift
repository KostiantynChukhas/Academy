//
//  ScheduleViewController.swift
//  Academy
//
//  Created by Konstantin Chukhas on 12.11.2021.
//

import UIKit

class ScheduleViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet var contentView: UIView!
    
    var viewModel: ScheduleViewModelType!
    
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
        tableView.registerNib(cellType: ScheduleTableViewCell.self)
        tableView.registerNib(cellType: CustomHeaderViewTableViewCell.self)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = Style.Color.primaryColor
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
extension ScheduleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         viewModel.groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ScheduleTableViewCell = tableView.dequeCell(for: indexPath) else { return UITableViewCell() }
        cell.setupCell(group: viewModel.groups[indexPath.row])
        return cell
    }
}

//MARK: UITableViewDelegate -
extension ScheduleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let professional = viewModel.groups[indexPath.row]
        
        viewModel.route(to: .detail(allGroupScheduleModel: professional))
    }
}

