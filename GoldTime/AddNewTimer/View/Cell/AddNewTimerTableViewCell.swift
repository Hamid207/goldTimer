//
//  AddNewTimerTableViewCell.swift
//  GoldTime
//
//  Created by Hamid Manafov on 21.01.22.
//

import UIKit

protocol AddColorDelegate: AnyObject {
    func addColor()
}

class AddNewTimerTableViewCell: UITableViewCell {
    
    private var weekDayArray: [String]? = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    private lazy var tapWeekDayArray: [Int : Bool] = [1 : false, 2 : false, 3 : false, 4 : false, 5 : false, 6 : false, 7 : false]
    
    private lazy var isSeletedd = false
    
    weak var addTimerDelegate: TimerItemAddDelegate?
    weak var addColorDelegate: AddColorDelegate?
    
    private lazy var hourse: Int = 0
    private lazy var minute: Int = 0
    private lazy var seconds: Int = 0
    
    private lazy var pomodoroTime: Int? = 0
    private lazy var isPomodoroTimerOnOff: Bool = false
    private lazy var isTimer24HoursResetOnOff = false
    
    private lazy var hourseArray = [Int](0...10)
    private lazy var minuteArray = [Int](0...60)
    private lazy var secundArray = [Int](0...60)
    
    let weekDayView = UIView()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return cv
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        textField.placeholder = "Timer name"
        textField.textAlignment = .center
        textField.contentVerticalAlignment = .center
        textField.textContentType = .name
        textField.returnKeyType = .done
        textField.autocapitalizationType = .words
        textField.autocorrectionType = .no
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let addColorButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add color", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private let viewPicker: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        //        view.backgroundColor = .red
        return view
    }()
    
    private let timerPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    
//    private let promodoroTimerAddLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Add pomodoro timer"
//        label.tintColor = .black
//        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
//        return label
//    }()
    
//    private let pomodoroAddSwitch: UISwitch = {
//        let pomodoroSwitch = UISwitch()
//        pomodoroSwitch.translatesAutoresizingMaskIntoConstraints = false
//        return pomodoroSwitch
//    }()
    
//    private let timer24ResetOnOffLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Timer reset 24 hourse"
//        label.tintColor = .black
//        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
//        return label
//    }()
//
//    private let timer24ResetOnOffSwitch: UISwitch = {
//        let switch24 = UISwitch()
//        switch24.translatesAutoresizingMaskIntoConstraints = false
//        return switch24
//    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        if hourse != 0 || minute != 0 || seconds != 0 && nameTextField.text != nil{
            saveButton.backgroundColor = .black
        }else {
            saveButton.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        subView()
    }
    
    @objc private func saveButtonTarget() {
//        if pomodoroAddSwitch.isOn {
//            pomodoroTime = 10
//            isPomodoroTimerOnOff = true
//        }
//        if timer24ResetOnOffSwitch.isOn {
//            isTimer24HoursResetOnOff = true
//        }
        let date = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let weekday = Calendar.current.component(.weekday, from: date)
        if hourse != 0 || minute != 0 || seconds != 0  {
            let timeee = hourse * 3600 + minute * 60 + seconds
            let timerModel = TimerModelData(name: nameTextField.text, timerTime: timeee, timerColor: nameTextField.text, hourse: hourse, minute: minute, seconds: seconds, statick: timeee, pomodoroTime: pomodoroTime, pomodoroTimerOnOff: isPomodoroTimerOnOff, pomodorTimerWorkOrBreak: true,  startFix: false, bugFixBool: false, userTimerstatistics: 0, startTimer: nil, stopTimer: nil, timerCounting: false, timerUpdateTime: timeee, pomodoroTimerUpdateTime: pomodoroTime!, pomdoroStartTime: nil, pomdoroStopTime: nil, todayDate: Date().getFormattedDate(), weekDay: weekday, timer24houresResetOnOff: isTimer24HoursResetOnOff, mon: tapWeekDayArray[1]!, tue: tapWeekDayArray[2]!, wed: tapWeekDayArray[3]!, thu: tapWeekDayArray[4]!, fri: tapWeekDayArray[5]!, sat: tapWeekDayArray[6]!, sun: tapWeekDayArray[7]!, timerDone: false)
            addTimerDelegate?.timerAdd(timer: timerModel)
        }else {
            
        }
    }
    
    @objc private func addColorAction() {
        addColorDelegate?.addColor()
    }
    
    func update(color: UIColor?) {
        addColorButton.backgroundColor = color
    }
    
    private func subView() {
        self.backgroundColor = .clear
        nameTextField.backgroundColor = .white
        nameTextField.layer.cornerRadius = 10
        addColorButton.layer.cornerRadius = 10
        addColorButton.layer.borderWidth = 1
        viewPicker.layer.borderWidth = 0.5
        viewPicker.layer.borderColor = UIColor.black.cgColor
        viewPicker.layer.cornerRadius = 10
        saveButton.layer.cornerRadius = 10
    }
    
    private func setup() {
//        timerPickerView.delegate = self
//        timerPickerView.dataSource = self
        
        contentView.addSubview(nameTextField)
        nameTextField.topAnchor.constraint(equalTo: topAnchor).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        //        //addColorButton
        //        contentView.addSubview(addColorButton)
        //        addColorButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20).isActive = true
        //        addColorButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        //        addColorButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        //        addColorButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        //        addColorButton.addTarget(self, action: #selector(addColorAction), for: .touchDown)
        
//        contentView.addSubview(viewPicker)
//        viewPicker.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20).isActive = true
//        viewPicker.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
//        viewPicker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
//        viewPicker.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/3).isActive = true
//
//        viewPicker.addSubview(timerPickerView)
//        timerPickerView.topAnchor.constraint(equalTo: viewPicker.topAnchor).isActive = true
//        timerPickerView.leadingAnchor.constraint(equalTo: viewPicker.leadingAnchor, constant: 0).isActive = true
//        timerPickerView.trailingAnchor.constraint(equalTo: viewPicker.trailingAnchor, constant: 0).isActive = true
//        timerPickerView.bottomAnchor.constraint(equalTo: viewPicker.bottomAnchor).isActive = true
        
//        contentView.addSubview(timer24ResetOnOffLabel)
//        timer24ResetOnOffLabel.topAnchor.constraint(equalTo: timerPickerView.bottomAnchor, constant: 25).isActive = true
//        timer24ResetOnOffLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
//
//        contentView.addSubview(timer24ResetOnOffSwitch)
//        timer24ResetOnOffSwitch.centerYAnchor.constraint(equalTo: timer24ResetOnOffLabel.centerYAnchor).isActive = true
//        timer24ResetOnOffSwitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        
        //        contentView.addSubview(promodoroTimerAddLabel)
        //        promodoroTimerAddLabel.topAnchor.constraint(equalTo: timerPickerView.bottomAnchor, constant: 15).isActive = true
        //        promodoroTimerAddLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        
        //        contentView.addSubview(pomodoroAddSwitch)
        //        pomodoroAddSwitch.centerYAnchor.constraint(equalTo: promodoroTimerAddLabel.centerYAnchor).isActive = true
        //        pomodoroAddSwitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        
        
        
//        addSubview(weekDayView)
//        weekDayView.translatesAutoresizingMaskIntoConstraints = false
//        weekDayView.backgroundColor = .clear
////        weekDayView.layer.borderWidth = 1
////        weekDayView.layer.borderColor = UIColor.black.cgColor
//        weekDayView.topAnchor.constraint(equalTo: timerPickerView.bottomAnchor, constant: 20).isActive = true
//        weekDayView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
//        weekDayView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
//        weekDayView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/10).isActive = true
//
//        weekDayView.addSubview(collectionView)
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.register(IconsCell.self, forCellWithReuseIdentifier: "cellId")
//        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.topAnchor.constraint(equalTo: weekDayView.topAnchor).isActive = true
//        collectionView.leadingAnchor.constraint(equalTo: weekDayView.leadingAnchor, constant: 15).isActive = true
//        collectionView.trailingAnchor.constraint(equalTo: weekDayView.trailingAnchor, constant: -15).isActive = true
//        collectionView.bottomAnchor.constraint(equalTo: weekDayView.bottomAnchor).isActive = true
//
//        //saveButton
//        contentView.addSubview(saveButton)
//        //        saveButton.topAnchor.constraint(equalTo: timerPickerView.bottomAnchor, constant: 45).isActive = true
//        saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
//        saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
//        saveButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
//        saveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40).isActive = true
//        saveButton.addTarget(self, action: #selector(saveButtonTarget), for: .touchDown)
    
    }
}

extension AddNewTimerTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weekDayArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! IconsCell
        let item = weekDayArray?[indexPath.item]
        let item2 = tapWeekDayArray[indexPath.item + 1]
        cell.update(name: item!, isSelected: item2)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width / 7.8, height: weekDayView.frame.height - 10)
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
        if tapWeekDayArray[indexPath.item + 1] == false{
            tapWeekDayArray[indexPath.item + 1] = true
        }else if tapWeekDayArray[indexPath.item + 1] == true {
            tapWeekDayArray[indexPath.item + 1] = false
            isSeletedd = false
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

//extension AddNewTimerTableViewCell: UIPickerViewDataSource {
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 6
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        switch component {
//            case 0: return 10
//            case 1: return 1
//            case 2: return 60
//            case 3: return 1
//            case 4: return 60
//            case 5: return 1
//            default:
//                return 0
//        }
//    }
//}
//
//extension AddNewTimerTableViewCell: UIPickerViewDelegate {
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        switch component {
//            case 0:
//                return String(hourseArray[row])
//            case 1:
//                let hour = UILabel()
//                hour.text = "hour"
//                timerPickerView.setPickerLabels(labels: [1:hour], containedView: viewPicker)
//                return ""
//            case 2:
//                return String(minuteArray[row])
//            case 3:
//                let min = UILabel()
//                min.text = "min"
//                timerPickerView.setPickerLabels(labels: [3:min], containedView: viewPicker)
//                return ""
//            case 4:
//                return String(secundArray[row])
//            case 5:
//                let sec = UILabel()
//                sec.text = "sec"
//                timerPickerView.setPickerLabels(labels: [5:sec], containedView: viewPicker)
//                return ""
//            default:
//                return ""
//        }
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        hourse = (pickerView.selectedRow(inComponent: 0))
//        minute = (pickerView.selectedRow(inComponent: 2))
//        seconds = (pickerView.selectedRow(inComponent: 4))
//        if hourse != 0 || minute != 0 || seconds != 0 {
//            saveButton.backgroundColor = .black
//        }else {
//            saveButton.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
//        }
//    }
//}

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
