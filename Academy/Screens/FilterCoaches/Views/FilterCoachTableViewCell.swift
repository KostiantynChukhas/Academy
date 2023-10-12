//
//  FilterCoachTableViewCell.swift
//  Academy
//
//  Created by Konstantin Chukhas on 14.12.2021.
//

import UIKit
import BEMCheckBox


class FilterCoachTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var checkBox: BEMCheckBox!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
