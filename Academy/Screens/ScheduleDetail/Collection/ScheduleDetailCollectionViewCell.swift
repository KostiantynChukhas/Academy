//
//  ScheduleDetailCollectionViewCell.swift
//  Academy
//
//  Created by Konstantin Chukhas on 13.12.2021.
//

import UIKit

class ScheduleDetailCollectionViewCell: UICollectionViewCell {

    @IBOutlet var day: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var time: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        day.layer.borderWidth = 0.5
        day.layer.borderColor = UIColor.lightGray.cgColor
        date.layer.borderWidth = 0.5
        date.layer.borderColor = UIColor.lightGray.cgColor
        time.layer.borderWidth = 0.5
        time.layer.borderColor = UIColor.lightGray.cgColor
    }
}
