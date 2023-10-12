//
//  ContactsFooterTableViewCell.swift
//  Academy
//
//  Created by Konstantin Chukhas on 14.11.2021.
//

import UIKit

class ContactsFooterTableViewCell: UITableViewCell {

    static let reuseId = "ContactsFooterTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
    
    @IBAction func instagramButtonAction(_ sender: Any) {
        if let url = URL(string: Defines.Links.instagram) {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func facebookButtonAction(_ sender: Any) {
        if let url = URL(string: Defines.Links.facebook) {
            UIApplication.shared.open(url)
        }
    }
}

