
import UIKit
import QRSwift

class DetailViewController: UIViewController {
    var viewModel: DetailViewModelType!
    
    @IBOutlet var globalView: UIView!
    @IBOutlet var scanLabel: UILabel!
    @IBOutlet var qrImageView: UIImageView!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet var cardNumberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateQR()
        setupView()
        setupLabel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        navigationView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 10)
    }
    
    private func setupView() {
        //globalView
        globalView.layer.addShadow()
        globalView.roundAll(radius: 10)
    }
    
    private func setupLabel() {
        //globalView
        scanLabel.roundAll(radius: 10)
    }
    
    private func generateQR() {
        // Create a barcode generator instance
 qrImageView.image = BarcodeGenerate.shared.createBarcodeFromString(barcode: viewModel.getCardNumber())
        
        guard viewModel.getCardNumber().isEmpty != true else {
            cardNumberLabel.text = ""
            return}
        
        let attrString = NSMutableAttributedString(string: viewModel.getCardNumber().trimmingCharacters(in: .whitespacesAndNewlines))
        cardNumberLabel.attributedText = NSAttributedString(string: attrString.string.trimmingCharacters(in: .whitespacesAndNewlines))
        
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        viewModel.back()
    }
    
    deinit {
        printDeinit(self)
    }
}
