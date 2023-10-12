//
//  CoachesTableViewCell.swift
//  Academy
//
//  Created by Konstantin Chukhas on 14.11.2021.
//

import UIKit

class CoachesTableViewCell: UITableViewCell {

    @IBOutlet var cardView: UIView!
    @IBOutlet var infoView: UIView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var scheduleLabel: UILabel!
    @IBOutlet var avatarImage: UIImageView!
    @IBOutlet var phoneButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.phoneButton.setTitle("", for: .normal)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.avatarImage.image = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        cardView.backgroundColor = .clear
        infoView.backgroundColor = .clear
        
        self.avatarImage.layer.cornerRadius = self.avatarImage.frame.size.height / 2
        self.avatarImage.layer.masksToBounds = true
        
    }
    
    func setupCell(_ model: CoachModel) {
        self.nameLabel.text = model.name
        self.descriptionLabel.text = model.positionNames?.first
        self.scheduleLabel.text = ""
    }
    
    @IBAction func phoneNumberButtonAction(_ sender: Any) {
        guard let url = URL(string: "telprompt://\(Defines.Numbers.numberPhone)"),
                UIApplication.shared.canOpenURL(url) else {
                return
            }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
