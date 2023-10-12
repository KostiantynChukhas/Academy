//
//  ScheduleDetailTableViewCell.swift
//  Academy
//
//  Created by Konstantin Chukhas on 14.11.2021.
//

import UIKit

struct ScheduleDetail {
    let day: String
    let date: String
    let time: String
}

class ScheduleDetailTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var cardView: UIView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var nameCoachLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var heightCollectionConstraint: NSLayoutConstraint!
    
    private var arrayCell: [ScheduleDetail] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        cardView.backgroundColor = .clear
    }
    
    private func setupCollectionView() {
        collectionView.registerCells([ScheduleDetailCollectionViewCell.identifier])
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
    
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        collectionView.collectionViewLayout = layout
        collectionView.reloadData()
    }
    
    func setupCell(model: ScheduleDates) {
        nameCoachLabel.text = model.nameCoach
        self.heightCollectionConstraint.constant = CGFloat(model.dates.count * 60)
        _ = model.dates.map { dateTime in
            arrayCell.append(ScheduleDetail(day: dateTime.toString(with: "EEEE"),
                                            date:  dateTime.toString(with: "dd.MM"),
                                            time: dateTime.toString(with: "HH:mm")))
            
        }
        
        titleLabel.text = model.month
    }
}

extension ScheduleDetailTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrayCell.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: ScheduleDetailCollectionViewCell = collectionView.dequeCell(for: indexPath) else { return UICollectionViewCell() }
        let model = arrayCell[indexPath.item]
        cell.day.text = model.day
        cell.date.text = model.date
        cell.time.text = model.time
        return cell
    }
}

extension ScheduleDetailTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: self.collectionView.frame.width, height: 50)
    }
}
