//
//  ScheduleCategoryTableViewCell.swift
//  Academy
//
//  Created by Konstantin Chukhas on 13.12.2021.
//

import UIKit

class ScheduleCategoryTableViewCell: UITableViewCell {

    @IBOutlet var imgView: UIImageView!
    @IBOutlet var cardView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageAvatar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cardView.layer.cornerRadius = 10
        imgView.layer.cornerRadius = 10
        self.imageAvatar.layer.cornerRadius = 30
        self.imageAvatar.layer.masksToBounds = true
    }

    func setupCell(group: CategoryGroupsModel) {
        titleLabel.text = group.name?.capitalized
        
//        switch row {
//        case 0: self.imgView.image = #imageLiteral(resourceName: "BoxImage")
//        case 1: self.imgView.image = #imageLiteral(resourceName: "crossfitImage")
//        case 2: self.imgView.image = #imageLiteral(resourceName: "fitenessImage")
//        default:
//            break
//        }
    }
}
