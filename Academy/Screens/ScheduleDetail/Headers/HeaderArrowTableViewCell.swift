//
//  HeaderArrowTableViewCell.swift
//  Academy
//
//  Created by Konstantin Chukhas on 14.11.2021.
//

import UIKit

class HeaderArrowTableViewCell: UITableViewCell {
    
    static let reuseId = "HeaderArrowTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
    
    @IBAction func phoneNumberButtonAction(_ sender: Any) {
        guard let url = URL(string: "telprompt://\(Defines.Numbers.numberPhone)"),
                UIApplication.shared.canOpenURL(url) else {
                return
            }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
}
