//
//  CoachesViewController.swift
//  Academy
//
//  Created by Konstantin Chukhas on 14.11.2021.
//

import UIKit

class CoachesViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet var contentView: UIView!
    
    var viewModel: CoachesViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        bindViewModelData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        navigationView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 10)
        contentView.layer.cornerRadius = 10
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        contentView.addShadow(offset: CGSize.init(width: 0, height: 15), color: UIColor.black, radius: 5.0, opacity: 0.70)
        
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
        tableView.registerNib(cellType: CoachesTableViewCell.self)
        
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
    @IBAction func filterButtonAction(_ sender: Any) {
        viewModel.route(to: .filter(coachModel: viewModel.coaches))
    }
    
    deinit {
        printDeinit(self)
    }
}

//MARK: UITableViewDataSource -
extension CoachesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.coaches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: CoachesTableViewCell = tableView.dequeCell(for: indexPath) else { return UITableViewCell() }
        let model = viewModel.coaches[indexPath.row]
        cell.setupCell(model)
        viewModel.getAvatarCoach(id: model.id ?? "") { [weak self] imageData in
            guard let _ = self else { return }
            DispatchQueue.main.async {
                cell.avatarImage.image = UIImage(data: imageData, scale: 1)
                if imageData.count == 275 {
                    cell.avatarImage.image = UIImage(named: "avatarFake")
                }
            }
        }
        return cell
    }
}

//MARK: UITableViewDataSource -
extension CoachesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = viewModel.coaches[indexPath.row]
        
        viewModel.getAvatarCoach(id: model.id ?? "") { [weak self] imageData in
            guard let _ = self else { return }
            DispatchQueue.main.async {
                self?.viewModel.route(to: .detail(coachModel: model, imageDataAvatar: imageData))
            }
        }
    }
}
