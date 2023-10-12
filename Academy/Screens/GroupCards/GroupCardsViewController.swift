//
//  GroupCardsViewController.swift
//  Academy
//
//  Created by Konstantin Chukhas on 14.11.2021.
//

import UIKit

class GroupCardsViewController: UIViewController {
    
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var bgImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var startDate: UILabel!
    @IBOutlet var endDate: UILabel!
    @IBOutlet var remainderLabel: UILabel!
    @IBOutlet var endingLabel: UILabel!
    @IBOutlet var whiteArrowImage: UIImageView!
    @IBOutlet var costLabel: UILabel!
    
    var viewModel: GroupCardsViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        bindViewModelData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkFilterModel()
    }
    
    fileprivate func checkFilterModel() {
        if viewModel.filterModel == nil {
            nameLabel.text = "На даний момент у вас немає групових тренувань"
            nameLabel.font = UIFont(name: "Montserrat-SemiBold", size: 17)
            remainderLabel.isHidden = true
            endingLabel.isHidden = true
            whiteArrowImage.isHidden = true
        }
    }
    
    private func bindViewModelData() {
        viewModel.onReload = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.bindData()
                self.tableView.reloadData()
            }
        }
    }
    
    fileprivate func bindData() {
        startDate.text = viewModel.filterModel?.startDateConvert()
        endDate.text = viewModel.filterModel?.endDateConvert()
        nameLabel.text = viewModel.filterModel?.name
        let balance = UserDefaults.standard.string(forKey: "balance")
        costLabel.text = "Ваш баланс \(balance ?? "") грн"
        whiteArrowImage.isHidden = false
        remainderLabel.isHidden = false
        endingLabel.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        navigationView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 10)
        bgImage.layer.cornerRadius = 10
        bgImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        bgImage.addShadow(offset: CGSize.init(width: 0, height: 15), color: UIColor.black, radius: 5.0, opacity: 0.70)
    }
    
    private func setupTable() {
        tableView.registerNib(cellType: GroupCardsTableViewCell.self)
        
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
    @IBAction func personalTrainingButtonAction(_ sender: Any) {
        viewModel.route(to: .cards)
    }
    
    deinit {
        printDeinit(self)
    }
}

//MARK: UITableViewDataSource -
extension GroupCardsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard viewModel.filterModel != nil else { return 0 }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: GroupCardsTableViewCell = tableView.dequeCell(for: indexPath) else { return UITableViewCell() }
        cell.setupCell(endDate: viewModel.endDate ?? "", model: viewModel.filterModel)
        return cell
    }
}

//MARK: UITableViewDataSource -
extension GroupCardsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
