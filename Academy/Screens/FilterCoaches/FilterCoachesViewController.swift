//
//  FilterCoachesViewController.swift
//  Academy
//
//  Created by Konstantin Chukhas on 14.11.2021.
//

import UIKit
import BEMCheckBox

class FilterCoachesViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var selectedbutton: BMButton!
    
    var viewModel: FilterCoachesViewModelType!
    private var selectedFilterArray: [String] = []
    private var checkboxesState: [Int: Bool] = [:]
    
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
    
    private func setupTable() {
        tableView.registerNib(cellType: FilterCoachTableViewCell.self)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
    }
    
    @IBAction func selectedButtonAction(_ sender: Any) {
        viewModel.selectFilter(self.selectedFilterArray)
    }
    
    deinit {
        printDeinit(self)
    }
}

//MARK: UITableViewDataSource -
extension FilterCoachesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.coachModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: FilterCoachTableViewCell = tableView.dequeCell(for: indexPath) else { return UITableViewCell() }
        let model = viewModel.coachModel[indexPath.row]
        cell.titleLabel.text = model.positionNames?.first
        cell.titleLabel.textColor = .lightGray
        cell.checkBox.tag = indexPath.row
        
        if self.selectedFilterArray.contains(model.positionNames?.first ?? "") {
            cell.checkBox.on = true
            cell.titleLabel.textColor = .black
        }else{
            cell.checkBox.on = false
            cell.titleLabel.textColor = .lightGray
        }
        
        return cell
    }
}

//MARK: UITableViewDataSource -
extension FilterCoachesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = viewModel.coachModel[indexPath.row]
        
        if !self.selectedFilterArray.contains(model.positionNames?.first ?? "") {
            self.selectedFilterArray.append(model.positionNames?.first ?? "")
        }else{
            if let index = self.selectedFilterArray.firstIndex(of: model.positionNames?.first ?? "") {
                self.selectedFilterArray.remove(at: index)
            }
        }
        tableView.reloadData()
    }
}
