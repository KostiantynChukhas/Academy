//
//  EmptyScheduleTableViewCell.swift
//  Academy
//
//  Created by Konstantin Chukhas on 26.11.2021.
//

import UIKit

class EmptyScheduleTableViewCell: UITableViewCell {

    @IBOutlet var cardView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        cardView.backgroundColor = .clear
    }
}
