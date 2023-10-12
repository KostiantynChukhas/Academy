//
//  ScheduleTableViewCell.swift
//  Academy
//
//  Created by Konstantin Chukhas on 13.11.2021.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {

    @IBOutlet var imgView: UIImageView!
    @IBOutlet var cardView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageAvatar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cardView.layer.cornerRadius = 10
        imgView.layer.cornerRadius = 10
    }

    func setupCell(group: GroupsModel) {
        titleLabel.text = group.name
        
//        switch row {
//        case 0: self.imgView.image = #imageLiteral(resourceName: "BoxImage")
//        case 1: self.imgView.image = #imageLiteral(resourceName: "crossfitImage")
//        case 2: self.imgView.image = #imageLiteral(resourceName: "fitenessImage")
//        default:
//            break
//        }
    }
    
}
