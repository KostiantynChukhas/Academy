//
//  DetailCoachesScheduleTableViewCell.swift
//  Academy
//
//  Created by Konstantin Chukhas on 14.11.2021.
//

import UIKit

class DetailCoachesScheduleTableViewCell: UITableViewCell {

    @IBOutlet var cardView: UIView!
    @IBOutlet var detailView: UIView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        cardView.backgroundColor = .clear
        detailView.backgroundColor = .clear
        
        self.imgView.layer.cornerRadius = self.imgView.frame.size.height / 2
        self.imgView.layer.masksToBounds = true
    }
    
    func setupCell(model: ScheduleDates, avatar: Data) {
        descriptionLabel.text = model.month
        nameLabel.text = model.nameCoach
        dateLabel.text = model.dates.map({$0.toString(with: "E dd.MM HH:mm")}).joined(separator: "\n\n")
        
        imgView.image = UIImage(data: avatar, scale: 1)
        if avatar.count == 275 {
            imgView.image = UIImage(named: "avatarFake")
        }
    }
    
    @IBAction func phoneNumberButtonAction(_ sender: Any) {
        guard let url = URL(string: "telprompt://\(Defines.Numbers.numberPhone)"),
                UIApplication.shared.canOpenURL(url) else {
                return
            }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
