//
//  EditWeekDayTableViewCell.swift
//  GoldTime
//
//  Created by Hamid Manafov on 30.01.22.
//

import UIKit

class EditWeekDayTableViewCell: UITableViewCell {
    
    weak var editWeekDayDelegate: EditWeekDayDelegate?
    
    private var weekDayArray: [String] = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    private lazy var tapWeekDayArray: [Int : Bool] = [1 : false, 2 : false, 3 : false, 4 : false, 5 : false, 6 : false, 7 : false]
    private lazy var dontTapWeekDayArray = [1 : false, 2 : false, 3 : false, 4 : false, 5 : false, 6 : false, 7 : false]
    private var day: Int?
    private lazy var isSeletedd = false
    private lazy var timerStartToDay = false
    
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
            for i in 1...weekDayArray.count {
                tapWeekDayArray[i] = true
            }
        }else {
            print("Off")
            for i in 1...weekDayArray.count {
                tapWeekDayArray[i] = false
            }
        }
        weekDayAdd()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
//        saveWeekDayDelegate?.saveWeekDay(mon: tapWeekDayArray[1]!, tue: tapWeekDayArray[2]!, wed: tapWeekDayArray[3]!, thu: tapWeekDayArray[4]!, fri: tapWeekDayArray[5]!, sat: tapWeekDayArray[6]!, sun: tapWeekDayArray[7]!)
    }

    func update(mon: Bool, tue: Bool, wed: Bool, thu: Bool, fri: Bool, sat: Bool, sun: Bool, timerStartToday: Bool) {
        if mon == true {
            tapWeekDayArray[1] = true
        }
        if tue == true {
            tapWeekDayArray[2] = true
        }
        if wed == true {
            tapWeekDayArray[3] = true
        }
        if thu == true {
            tapWeekDayArray[4] = true
        }
        if fri == true {
            tapWeekDayArray[5] = true
        }
        if sat == true {
            tapWeekDayArray[6] = true
        }
        if sun == true {
            tapWeekDayArray[7] = true
        }
        
        timerStartToDay = timerStartToday
        weekOnOfSwitch()
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    private func weekOnOfSwitch() {
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
    
    //MARK: - Week Day 
    private func weekDayAdd() {
        let date = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let today = Calendar.current.component(.weekday, from: date)
        day = today
        dontTapWeekDayArray[today] = true
        editWeekDayDelegate?.sentNewDay(mon: tapWeekDayArray[1]!, tue: tapWeekDayArray[2]!, wed: tapWeekDayArray[3]!, thu: tapWeekDayArray[4]!, fri: tapWeekDayArray[5]!, sat: tapWeekDayArray[6]!, sun: tapWeekDayArray[7]!)
    }
}


extension EditWeekDayTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weekDayArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! IconsCell
        let item = weekDayArray[indexPath.item]
        let item2 = tapWeekDayArray[indexPath.item + 1]
        guard let dontTapITem = dontTapWeekDayArray[indexPath.item + 1] else { return cell}
        cell.update(name: item, isSelected: item2, dontTapIsSelected: dontTapITem, timerStartToDay: timerStartToDay)
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
        if timerStartToDay == false {
            if tapWeekDayArray[indexPath.item + 1] == false{
                tapWeekDayArray[indexPath.item + 1] = true
            }else if tapWeekDayArray[indexPath.item + 1] == true{
                tapWeekDayArray[indexPath.item + 1] = false
    //            isSeletedd = false
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }else {
            if tapWeekDayArray[indexPath.item + 1] == false{
                tapWeekDayArray[indexPath.item + 1] = true
            }else if tapWeekDayArray[indexPath.item + 1] == true && day != indexPath.item + 1{
                tapWeekDayArray[indexPath.item + 1] = false
    //            isSeletedd = false
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        weekOnOfSwitch()
        
        editWeekDayDelegate?.sentNewDay(mon: tapWeekDayArray[1]!, tue: tapWeekDayArray[2]!, wed: tapWeekDayArray[3]!, thu: tapWeekDayArray[4]!, fri: tapWeekDayArray[5]!, sat: tapWeekDayArray[6]!, sun: tapWeekDayArray[7]!)
    }
    
    func tapWeekDay(index: Int) {
        if tapWeekDayArray[index] == false{
            tapWeekDayArray[index] = true
        }else if tapWeekDayArray[index] == true{
            tapWeekDayArray[index] = false
//            isSeletedd = false
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

private class IconsCell: UICollectionViewCell  {
    
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
    
    func update(name: String, isSelected: Bool?, dontTapIsSelected: Bool, timerStartToDay: Bool) {
        nameLabel.text = name
        nameLabel.textColor = .black
        if isSelected! && dontTapIsSelected == true && timerStartToDay == true{
            nameLabel.textColor = .white
            self.contentView.layer.backgroundColor = UIColor.red.cgColor
//            print("1111111")
        }else if isSelected! && dontTapIsSelected == false {
            nameLabel.textColor = .white
            self.contentView.layer.backgroundColor = UIColor.black.cgColor
//            print("22222")
        } else if isSelected! && dontTapIsSelected == true && timerStartToDay == false {
            nameLabel.textColor = .white
//            print("33333")
            self.contentView.layer.backgroundColor = UIColor.black.cgColor
        }else {
            nameLabel.textColor = .black
            self.contentView.layer.backgroundColor = UIColor.white.cgColor
//            print("44444")
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

