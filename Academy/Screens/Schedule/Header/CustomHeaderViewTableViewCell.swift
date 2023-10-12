//
//  CustomHeaderViewTableViewCell.swift
//  Academy
//
//  Created by Konstantin Chukhas on 13.11.2021.
//

import UIKit

class CustomHeaderViewTableViewCell: UITableViewCell {
    
    static let reuseId = "CustomHeaderViewTableViewCell"
    
    @IBOutlet weak var title: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }

    func configure(with title: String) {
        self.title.text = title
    }
    
}
