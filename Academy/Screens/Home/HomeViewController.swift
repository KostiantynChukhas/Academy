//
//  HomeViewController.swift
//  Academy
//
//  Created by  on 31.03.2021.
//

import QRSwift
import UIKit

class HomeViewController: UIViewController {
    var viewModel: HomeViewModelType!
    private var cardNumber = ""
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var infoContainer: UIView!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet var cardNumberLabel: UILabel!
    @IBOutlet var dateToLabel: UILabel!
    @IBOutlet var nameAbonementInCardLabel: UILabel!
    @IBOutlet var nameAbonementLabel: UILabel!
    @IBOutlet var visualBlureView: UIVisualEffectView!
    @IBOutlet var qrImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        bindViewModelData()
        checkAboniment()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    private func checkAboniment() {
        if viewModel.filterModel?.compareDateFromToday() == true {
            visualBlureView.isHidden = false
        }else {
            visualBlureView.isHidden = true
        }
    }
    
    private func bindViewModelData() {
        viewModel.onReload = { [weak self] in
            DispatchQueue.main.async {
                guard self != nil else { return }
                self?.getClients()
                self?.getClientCard()
                self?.generateQR()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        profilePicture.layer.cornerRadius = profilePicture.bounds.width / 2
        
        infoContainer.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 10)
        navigationView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 10)
        
        cardView.layer.cornerRadius = Style.Radius.button
        cardView.layer.borderWidth = 2
        cardView.layer.borderColor = Style.Color.primaryColor.cgColor
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cardClicked))
        cardView.isUserInteractionEnabled = true
        cardView.addGestureRecognizer(tapGesture)
        
    }
    
    private func generateQR() {
        // Create a barcode generator instance
        qrImageView.image = BarcodeGenerate.shared.createBarcodeFromString(barcode: self.cardNumber)
        
        guard self.cardNumber.isEmpty != true else {
            cardNumberLabel.text = ""
            return}
        
        let attrString = NSMutableAttributedString(string: self.cardNumber.trimmingCharacters(in: .whitespacesAndNewlines))
        cardNumberLabel.attributedText = NSAttributedString(string: attrString.string.trimmingCharacters(in: .whitespacesAndNewlines))
        
    }
    
    private func getClients() {
        DispatchQueue.main.async {
            let model = self.viewModel.clientModel
            self.nameLabel.text = model?.name
            self.phoneLabel.text = model?.phone?.first
            
            //["+1 (800) 555 0110"]
            if model?.cardNumber?.first?.isEmpty == nil {
                guard let card = model?.phone else {return}
                
                let stringCard: String = card.first?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
                let a = stringCard.replacingOccurrences(of: "(", with: "")
                let b = a.replacingOccurrences(of: ")", with: "")
                let c = b.replacingOccurrences(of: "+", with: "").removeWhitespace()
                
                self.cardNumberLabel.text = "\(c.dropFirst(1))"
                self.cardNumber = "\(c.dropFirst(1))"
            }
            else {
                guard let card = model?.cardNumber else {return}
                let joinCard = card.joined()
                self.cardNumberLabel.text = joinCard
                self.cardNumber = joinCard
            }
            
            self.cardNumberLabel.transform = CGAffineTransform(rotationAngle: .pi / 2 * 3)
            self.generateQR()
            guard let url = URL(string: model?.photo ?? "") else {return}
            self.profilePicture.setImage(with: url)
            
        }
    }
    
    private func getClientCard() {
        self.nameAbonementLabel.text = viewModel.filterModel?.name
        self.nameAbonementInCardLabel.text = ""
        self.dateToLabel.text = "Дійсний до \(viewModel.filterModel?.endDateConvert() ?? "")"
    }
    
    private func checkInternet() {
        let controller: NoInternetConnectionViewController = Storyboard.noInternet.instantiate()
      
        NetworkManager.isUnreachable { _ in
            
            self.addChild(controller)
            self.view.addSubview(controller.view)

            controller.didMove(toParent: self)
            self.view.addSubview(self.navigationView)
        }
        
        NetworkManager.isReachable { _ in
            controller.willMove(toParent: nil)
            controller.view.removeFromSuperview()
            controller.removeFromParent()
        }
    }
    
    @IBAction func extendSubscriptionAction(_ sender: Any) {
    
    }
    
    @IBAction func menuButtonAction(_ sender: Any) {
        viewModel.route(to: .menu)
    }
    
    @objc private func cardClicked() {
//        viewModel.route(to: .details(cardNumber: self.cardNumber))
    }
    
    private func setup() {
        
    }
   
}

