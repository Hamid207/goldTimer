//
//  WeekDayCollectionViewCell.swift
//  GoldTime
//
//  Created by Hamid Manafov on 21.01.22.
//

import UIKit

class WeekDayCollectionViewCell: UICollectionViewCell {
    
    let weekDayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 19, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
////        self.contentView.backgroundColor = .white
//        print("цикла разработки мобильных приложений для iOS")
//    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.contentView.layer.cornerRadius = 5
    }
    

    func update(name: String, isSelected: Bool, isBlackSelected: Bool) {
        weekDayLabel.text = name
        if isSelected {
            self.contentView.layer.borderWidth = 1
            self.contentView.layer.borderColor = UIColor.black.cgColor
            weekDayLabel.textColor = .black
        }else {
            self.contentView.layer.borderWidth = 0
            self.contentView.layer.borderColor = UIColor.white.cgColor
            weekDayLabel.textColor = .black
        }


        if isBlackSelected == true {
            self.contentView.layer.backgroundColor = UIColor.black.cgColor
            weekDayLabel.textColor = .white
        }else if isBlackSelected == false {
            self.contentView.layer.backgroundColor = UIColor.white.cgColor
            weekDayLabel.textColor = .black
        }
        
        //DARK MODE olsa
//        if isSelected {
//            self.contentView.layer.borderWidth = 1
//            self.contentView.layer.borderColor = UIColor(named: "OtherColor")?.cgColor
//            weekDayLabel.textColor = UIColor(named: "OtherColor")
//        }else {
//            self.contentView.layer.borderWidth = 0
//            self.contentView.layer.borderColor = UIColor(named: "BackroundColor")?.cgColor
//            weekDayLabel.textColor = UIColor(named: "OtherColor")
//        }
//
//
//        if isBlackSelected == true {
//            self.contentView.layer.backgroundColor = UIColor(named: "OtherColor")?.cgColor
//            weekDayLabel.textColor = UIColor(named: "BackroundColor")
//        }else if isBlackSelected == false {
//            self.contentView.layer.backgroundColor = UIColor(named: "BackroundColor")?.cgColor
//            weekDayLabel.textColor = UIColor(named: "OtherColor")
//        }
//
    }
    
    private func setup() {
        contentView.addSubview(weekDayLabel)
        weekDayLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        weekDayLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}

