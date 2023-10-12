//
//  GroupCardsTableViewCell.swift
//  Academy
//
//  Created by Konstantin Chukhas on 15.11.2021.
//

import UIKit

class GroupCardsTableViewCell: UITableViewCell {

    @IBOutlet var cardView: UIView!
    @IBOutlet var bgImgView: UIImageView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var totalTrainningLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        cardView.backgroundColor = .clear
        cardView.layer.cornerRadius = 10
        bgImgView.layer.cornerRadius = 10
        cardView.addShadow(offset: CGSize.init(width: 0, height: 0), color: Style.Color.primaryColor, radius: 5.0, opacity: 0.70)
        bgImgView.addShadow(offset: CGSize.init(width: 0, height: 0), color: Style.Color.primaryColor, radius: 5.0, opacity: 0.70)
    }
    
    
    func setupCell(endDate: String, model: GetClientCardModel?) {
        
        switch model?.totalVisits {
        case .integer(let intTotal):
            self.totalTrainningLabel.text = "У вас осталось \(model?.leftVisits ?? 0) с \(intTotal) тренировок"
        case .string(let stringTotal):
            self.totalTrainningLabel.text = "У вас безлимит тренировок"
        case .none:
            break
        case .some(_):
            break
        }
        
        let todayConvert = Date().toString(with: "dd.MM.yy")
        guard let today = todayConvert.toDate(with: "dd.MM.yy") else { return }
        guard let endDateDate = endDate.toDate(with: "dd.MM.yy") else { return }

        let result = today.compare(endDateDate)
        switch result {
        case .orderedAscending:
            self.dateLabel.text = endDate
            print("today is earlier than date 2")
        case .orderedDescending:
            self.totalTrainningLabel.text = "У вас закончился абонемент"
            print("today is later than date 2")
        case .orderedSame:
            self.dateLabel.text = endDate
            print("two dates are the same")
        }
        
        let total = model?.discount?.services?.values.first?.totalQuantity
        let leftQuantity = model?.discount?.services?.values.first?.leftQuantity
        
        if leftQuantity != 0 {
            self.totalTrainningLabel.text = "У вас осталось \(leftQuantity ?? 0) с \(total ?? 0) тренировок"
        }else{
            self.totalTrainningLabel.text = "У вас закончился абонемент"
        }
        
    }
    
}
