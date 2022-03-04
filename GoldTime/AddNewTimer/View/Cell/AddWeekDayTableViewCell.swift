//
//  AddWeekDayTableViewCell.swift
//  GoldTime
//
//  Created by Hamid Manafov on 28.01.22.
//

import UIKit

final class AddWeekDayTableViewCell: UITableViewCell {
    
    weak var saveWeekDayDelegate: SaveWeekDayDelegate?
    
    private let region = Locale.current.regionCode
    private lazy var calendarRegion = false
    
    private lazy var weekDayArrayEU = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    private lazy var weekDayArrayUSA = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    private lazy var tapWeekDayArray = [1 : false, 2 : false, 3 : false, 4 : false, 5 : false, 6 : false, 7 : false]
    
    private lazy var isSeletedd = false
    
    private let addAllWeekDayView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private let addAllWeekDayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.text = "All week day"
        return label
    }()
    
    private let addAllWeekDaySwitch: UISwitch = {
        let addAllWeekDaySwitch = UISwitch()
        addAllWeekDaySwitch.translatesAutoresizingMaskIntoConstraints = false
        addAllWeekDaySwitch.isOn = false
        addAllWeekDaySwitch.onTintColor = .black
        return addAllWeekDaySwitch
    }()
    
    private let weekDayView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return cv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        itemSetum()
        weekDayAdd()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.backgroundColor = .clear
        addAllWeekDayView.layer.cornerRadius = 10
        weekDayView.layer.cornerRadius = 10
        collectionView.layer.cornerRadius = 10
    }
    
    @objc private func switchOnOffAction(switchParam: UISwitch) {
        if switchParam.isOn {
            print("ON")
            for i in 1...weekDayArrayEU.count {
                tapWeekDayArray[i] = true
            }
        }else {
            print("Off")
            for i in 1...weekDayArrayEU.count {
                tapWeekDayArray[i] = false
            }
        }
        weekDayAdd()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
        saveWeekDaAdd(region: calendarRegion)
    }
    
    private func itemSetum() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.weekDayAdd()
        }
        contentView.addSubview(addAllWeekDayView)
        addAllWeekDayView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        addAllWeekDayView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        addAllWeekDayView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        addAllWeekDayView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        addAllWeekDayView.addSubview(addAllWeekDayLabel)
        addAllWeekDayLabel.centerYAnchor.constraint(equalTo: addAllWeekDayView.centerYAnchor).isActive = true
        //        addAllWeekDayLabel.topAnchor.constraint(equalTo: addAllWeekDayView.topAnchor, constant: 15).isActive = true
        addAllWeekDayLabel.leadingAnchor.constraint(equalTo: addAllWeekDayView.leadingAnchor, constant: 15).isActive = true
        
        addAllWeekDayView.addSubview(addAllWeekDaySwitch)
        addAllWeekDaySwitch.centerYAnchor.constraint(equalTo: addAllWeekDayView.centerYAnchor).isActive = true
        //        addAllWeekDaySwitch.topAnchor.constraint(equalTo: addAllWeekDayView.topAnchor, constant: 15).isActive = true
        addAllWeekDaySwitch.trailingAnchor.constraint(equalTo: addAllWeekDayView.trailingAnchor, constant: -15).isActive = true
        addAllWeekDaySwitch.addTarget(self, action: #selector(switchOnOffAction(switchParam:)), for: .valueChanged)
        
        addSubview(weekDayView)
        weekDayView.topAnchor.constraint(equalTo: addAllWeekDayView.bottomAnchor, constant: 5).isActive = true
        weekDayView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        weekDayView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10).isActive = true
        weekDayView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        weekDayView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(IconsCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.topAnchor.constraint(equalTo: weekDayView.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: weekDayView.leadingAnchor, constant: 5).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: weekDayView.trailingAnchor, constant: -5).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: weekDayView.bottomAnchor).isActive = true
    }
    
    //MARK: - Week Day yeni bugun necenci gundu
    private func weekDayAdd() {
        let date = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let today = Calendar.current.component(.weekday, from: date)
        if region == "US" || region == "CA" {
            calendarRegion = true
            if today == 7 {
                tapWeekDayArray[1] = true
            }else {
                tapWeekDayArray[today + 1] = true
            }
            saveWeekDaAdd(region: calendarRegion)
        }else {
            tapWeekDayArray[today] = true
            saveWeekDaAdd(region: calendarRegion)
        }
    }
    
    private func saveWeekDaAdd(region: Bool) {
        if region {
            saveWeekDayDelegate?.saveWeekDay(mon: tapWeekDayArray[2]!, tue: tapWeekDayArray[3]!, wed: tapWeekDayArray[4]!, thu: tapWeekDayArray[5]!, fri: tapWeekDayArray[6]!, sat: tapWeekDayArray[7]!, sun: tapWeekDayArray[1]!)
        }else {
            saveWeekDayDelegate?.saveWeekDay(mon: tapWeekDayArray[1]!, tue: tapWeekDayArray[2]!, wed: tapWeekDayArray[3]!, thu: tapWeekDayArray[4]!, fri: tapWeekDayArray[5]!, sat: tapWeekDayArray[6]!, sun: tapWeekDayArray[7]!)
        }
    }
}


extension AddWeekDayTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weekDayArrayEU.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! IconsCell
        let item: String
        if calendarRegion == true {
            item = weekDayArrayUSA[indexPath.item]
        } else {
            item = weekDayArrayEU[indexPath.item]
        }
        let item2 = tapWeekDayArray[indexPath.item + 1]
        cell.update(name: item , isSelected: item2)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: weekDayView.frame.width / 7.34 , height: weekDayView.frame.height - 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item + 1)
        if tapWeekDayArray[indexPath.item + 1] == false{
            tapWeekDayArray[indexPath.item + 1] = true
        }else if tapWeekDayArray[indexPath.item + 1] == true {
            tapWeekDayArray[indexPath.item + 1] = false
            //            isSeletedd = false
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
        var intt = 0
        for i in 1...tapWeekDayArray.count {
            if tapWeekDayArray[i] == true {
                intt += 1
            }
        }
        
        if intt == 7 {
            addAllWeekDaySwitch.isOn = true
        }else {
            addAllWeekDaySwitch.isOn = false
        }
        
        saveWeekDaAdd(region: calendarRegion)
    }
}



private final class IconsCell: UICollectionViewCell  {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        itemSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(name: String, isSelected: Bool?) {
        nameLabel.text = name
        nameLabel.textColor = .black
        if isSelected! {
            nameLabel.textColor = .white
            self.contentView.layer.backgroundColor = UIColor.black.cgColor
        }else {
            nameLabel.textColor = .black
            self.contentView.layer.backgroundColor = UIColor.white.cgColor
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor.black.cgColor
        self.contentView.layer.cornerRadius = 10
    }
    
    private func itemSetup() {
        contentView.addSubview(nameLabel)
        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
