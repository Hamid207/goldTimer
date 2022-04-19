//
//  DasysStatisticsTableViewCell.swift
//  GoldTime
//
//  Created by Hamid Manafov on 18.04.22.
//

import UIKit

class DasysStatisticsTableViewCell: UITableViewCell {
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private let checkmarkUIView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
       
        return view
    }()
    
    private let checkmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.isHidden = true
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupItem()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear
    }
    
    func update(dateLabel: String, timeLabel: Int, timerDone: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.checkmarkImageView.image = UIImage(systemName: "checkmark.circle.fill")
            if timerDone {
                self.checkmarkImageView.isHidden = false
            }else {
                self.checkmarkImageView.isHidden = true
            }
            self.dateLabel.text = dateLabel
            self.timeLabel.text = self.timeString(time: TimeInterval(timeLabel))
            
        }
      
    }
    
    private func timeString(time: TimeInterval) -> String {
        let hour = Int(time) / 3600
        let minute = Int(time) / 60 % 60
        let second = Int(time) % 60
        // return formated string
        if hour == 0 {
            return String(format: "%02im %02is", minute, second)
        }else {
            return String(format: "%02ih %02im %02is", hour, minute, second)
            
        }
    }
    
    private func setupItem() {
        
        addSubview(dateLabel)
        dateLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        dateLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(checkmarkUIView)
        checkmarkUIView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        checkmarkUIView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        checkmarkUIView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        checkmarkUIView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        addSubview(checkmarkImageView)
        checkmarkImageView.topAnchor.constraint(equalTo: checkmarkUIView.topAnchor).isActive = true
        checkmarkImageView.leadingAnchor.constraint(equalTo: checkmarkUIView.leadingAnchor).isActive = true
        checkmarkImageView.trailingAnchor.constraint(equalTo: checkmarkUIView.trailingAnchor).isActive = true
        checkmarkImageView.bottomAnchor.constraint(equalTo: checkmarkUIView.bottomAnchor).isActive = true
        
        addSubview(timeLabel)
        timeLabel.trailingAnchor.constraint(equalTo: checkmarkUIView.leadingAnchor, constant: -5).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
       
    }

}
