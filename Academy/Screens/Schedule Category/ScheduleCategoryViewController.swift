//
//  ScheduleCategoryViewController.swift
//  Academy
//
//  Created by Konstantin Chukhas on 13.12.2021.
//

import UIKit

class ScheduleCategoryViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet var contentView: UIView!
    
    var viewModel: ScheduleCategoryViewModelType!
    
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
        tableView.registerNib(cellType: ScheduleCategoryTableViewCell.self)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = Style.Color.primaryColor
    }
    
    func makeTransparent(image: UIImage) -> UIImage? {
        guard let rawImage = image.cgImage else { return nil}
        let colorMasking: [CGFloat] = [255, 255, 255, 255, 255, 255]
        UIGraphicsBeginImageContext(image.size)
        
        if let maskedImage = rawImage.copy(maskingColorComponents: colorMasking),
            let context = UIGraphicsGetCurrentContext() {
            context.translateBy(x: 0.0, y: image.size.height)
            context.scaleBy(x: 1.0, y: -1.0)
            context.draw(maskedImage, in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
            let finalImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return finalImage
        }
        
        return nil
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
extension ScheduleCategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.groupsCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ScheduleCategoryTableViewCell = tableView.dequeCell(for: indexPath) else { return UITableViewCell() }
        let model = viewModel.groupsCategory[indexPath.row]
        cell.setupCell(group: model)
        viewModel.getPhotoCategory(id: model.picture ?? "") { [weak self] imageData in
            guard let _ = self else { return }
            DispatchQueue.main.async {
                let img = UIImage(data: imageData, scale: 1)?.pngData()
                cell.imageAvatar.image = UIImage(data: img ?? Data()) //self.makeTransparent(image: img ?? UIImage())
                if imageData.count == 275 {
                    cell.imageAvatar.image = UIImage(named: "avatarFake")
                }
            }
        }
        return cell
    }
}

//MARK: UITableViewDelegate -
extension ScheduleCategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let professional = viewModel.groupsCategory[indexPath.row]
        viewModel.route(to:.schedule(id: professional.id))
    }
}

