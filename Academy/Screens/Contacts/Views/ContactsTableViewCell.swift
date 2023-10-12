//
//  ContactsTableViewCell.swift
//  Academy
//
//  Created by Konstantin Chukhas on 14.11.2021.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var textViewLabel: UITextView!
    @IBOutlet var cardView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        cardView.backgroundColor = .clear
    }

    func setupCell(_ row: Int) {
        switch row {
        case 0:
            self.titleLabel.text = "ТЕЛЕФОНУЙТЕ НАМ"
            textViewLabel.attributedText = NSMutableAttributedString().normalMonserrat("+38 (093) 705 05 55", size: 18, color: .white, alignment: .center)
        case 1:
            self.titleLabel.text = "НАШ E-MAIL"
            textViewLabel.attributedText = NSMutableAttributedString().normalMonserrat("acdm.csa@gmail.com", size: 18, color: .white, alignment: .center)
        case 2:
            self.titleLabel.text = "НАША АДРЕСА"
            textViewLabel.attributedText = NSMutableAttributedString().normalMonserrat("Україна, Київ, вул. Володимира Сосюри, 5", size: 18, color: .white, alignment: .center )
        case 3:
            self.titleLabel.text = "НАШ САЙТ"
            textViewLabel.attributedText = NSMutableAttributedString().semiboldMonserrat("https://acdm.in.ua/", size: 18, color: .white, alignment: .center)
        default: break
        }
    }
    
}
