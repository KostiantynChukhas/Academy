//
//  DetailCoachesEndAbonimentTableViewCell.swift
//  Academy
//
//  Created by Konstantin Chukhas on 14.11.2021.
//

import UIKit

class DetailCoachesEndAbonimentTableViewCell: UITableViewCell {

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var cardView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cardView.layer.cornerRadius = 10
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        cardView.backgroundColor = .clear
    }
    
    func setupCell(model: GetClientCardModel) {
        self.dateLabel.text = model.endDateConvert()
    }
}
