//
//  MainCollectionViewCelll.swift
//  GoldTime
//
//  Created by Hamid Manafov on 21.01.22.
//

import UIKit

class MainCollectionViewCelll: UICollectionViewCell {
    
    var progressBar: ProgressBar!
    
    weak var timerStartStopDelegate: TimerStartStopDelegate?
    weak var setIndexDeleagte: SetIndexDelegate?
    weak var addModelIndexDelegate: AddModelIndexDelegate?
    weak var setTimerUpdateTimeDeleagte: SetTimerUpdateTimeDelegate?
    weak var setPomodoroTimerUpdateTimeDeleagte: SetPomdoroTimerUpdateTimeDelegate?
    weak var removeTimerDelegate: TimerRemoveDelegate?
    weak var pomodoroTimerStartStopDelegate: PomodoroTimerStartStopDelegate?
    weak var sentAlertActionDelegate: SentAlertActionDelegate?
    weak var showEditVcDelegate: TapOnTheEditVcDelegate?
    
    
    var index: Int?
    var timerRemoveIndex: TimerModelData?
    
    private var timerCellColor = "#15C08E"
    
    private var timerTime: Int?
    private var startTime: Date?
    private var stopTime: Date?
    private lazy var timerCounting:Bool = false
    private lazy var timerDoneSelected: Bool = false
    private var editTimerTime: Int? = nil
    
    private var isPomodoroTimerOnOff: Bool?
    private lazy var pomodoroTime: Int? = 0
    private lazy var pomodoroTimeUpdate = 0
    private lazy var pomodoroWorkTime = 10
    private lazy var pomodoroBreakTime = 5
    private lazy var isPomodorTimerWorkOrBreak:Bool = true
    private var pomodoroStartTime: Date?
    private var pomodoroStopTime: Date?
    private lazy var pomodoroUpdateWorkTime = 0
    private lazy var pomodoroUpdateBreakTime = 0
    
    private lazy var timerUpdateTime = 0
    //    private lazy var timerStart:Bool = false
    
    private lazy var removeBool: Bool = false
    
    private var weekDay: Int?
    private var toDay: Int?
    private var misStartTime: Date?
    private var misStopTime: Date?
    
    private weak var timer: Timer? {
        willSet {
            timer?.invalidate()// bashqa vcye girende ve sora yenined qayidanda timeri pause elemek olmurdu cunki herdefe yeni timer yaradirdi bu onun qarshisin alir
        }
    }
    private weak var pomodoroTimer: Timer? {
        willSet {
            pomodoroTimer?.invalidate()
        }
    }
    
    private var isFirstAnimation = true
    private var animteBool: Bool = false
    private var circularBarReload = false
    private var circulerStartStopTime: Float?
    var countFred: CGFloat = 0
    
    
    var testBoool = false
    var stopInt = 0
    var startInt = 0
    //===============================================
    
    private let editsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "gearshape")
        imageView.tintColor = .black
        //        imageView.backgroundColor = .red
        return imageView
    }()
    
    private let editsTimerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        //                button.backgroundColor = .orange
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Edit", for: .normal)
        button.tintColor = .black
        return button
    }()
    
    
    private let removeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "trash")
        imageView.tintColor = .black
        //        imageView.backgroundColor = .red
        return imageView
    }()
    
    private let removeTimer: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        //        button.backgroundColor = .red
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        //        label.backgroundColor = .red
        return label
    }()
    
    private let timerLabelAndProfressUIView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //        label.textColor = .black
        label.textAlignment = .center
        //        label.font = UIFont.systemFont(ofSize: 70, weight: .bold)
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 60, weight: .regular)
        return label
    }()
    
    private let pomodoroTimerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 50, weight: .bold)
        return label
    }()
    
    private let startButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start", for: .normal)
        //        button.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupItem()
        //        let startDate = Date()
        //        let endDate: Date = {
        //            let component = DateComponents(day: 1, second: -1 )
        //            return Calendar.current.date(byAdding: component, to: startDate)!
        //        }()
        //        print("START DATE == \(startDate) END DATE == \(endDate)")
    }
    
    //    func calendarr(didSelect date: Date) {
    //
    //    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutSub()
    }
    
    //MARK: - Update
    func update(model: TimerModelData, timerCounting: Bool, index: Int, checkDay: Int) {
        self.weekDay = checkDay
        weekDayAdd()
        timerTime = model.timerTime
        timerCellColor = model.timerColor ?? "#15C08E"
        timerUpdateTime = model.timerUpdateTime
        nameLabel.text = model.name
        startTime = model.startTimer
        stopTime = model.stopTimer
        editTimerTime = model.editTimerTime
        self.timerCounting = model.timerCounting
        self.index = index
        timerDoneSelected = model.timerDone
        isPomodoroTimerOnOff = model.pomodoroTimerOnOff
        if model.pomodoroTimerOnOff == true {
            pomodoroStartTime = model.pomdoroStartTime
            pomodoroStopTime = model.pomdoroStopTime
            guard let workOrBreak = model.pomodorTimerWorkOrBreak else { return }
            isPomodorTimerWorkOrBreak = workOrBreak
            //            if isPomodorTimerWorkOrBreak == true {
            //                pomodoroUpdateWorkTime = model.pomodoroTimerUpdateTime
            //            }else if isPomodorTimerWorkOrBreak == false{
            //                pomodoroUpdateBreakTime = model.pomodoroTimerUpdateTime
            //            }
        }
        //        progressBar.firstAnimation(value: 0.0)
        if toDay == weekDay {
            addModelIndexDelegate?.addModelIndex(index: index)
        }
        autoStart()
    }
    
    //MARK: - Auto start
    private func autoStart() {
        //        if isPomodoroTimerOnOff == true {
        //            if isPomodorTimerWorkOrBreak == true {
        //                setPomodoroTimeLabel(pomodoroUpdateWorkTime)
        //                print("WORK TIME === \(pomodoroUpdateWorkTime)")
        //            }else {
        //                setPomodoroTimeLabel(pomodoroUpdateBreakTime)
        //                print("BRAK TIME === \(pomodoroUpdateBreakTime)")
        //            }
        //        }else {
        //            pomodoroTimerLabel.text = ""
        //        }
        
        if timerCounting {
            print("START Cell == \(nameLabel.text)")
            if toDay == weekDay {
                setTimerCounting(true)
                startTimer()
                setIndexDeleagte?.setIndex(index: self.index)
                startInt += 1
//                print("AUTO START === \(nameLabel.text) == \(startInt)")
            }else {
                startTimerFake()
            }
            //            if isFirstAnimation == true {
            //                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            //                    self.progressBar.firstAnimation(value: 0.5)
            //                    self.isFirstAnimation = false
            //                }
            //            }
        }else {
            print("STOP cell == \(nameLabel.text)")
            stopInt += 1
//            print("AUTO STOP === \(nameLabel.text) === \(stopInt)")
            setTimerCounting(false)
            stopTimer()
            if timerDoneSelected == true && toDay == weekDay {
                timerDone()
            }else {
                stopTimer()
            }
            
            if toDay == weekDay {
                setTimeLabel(timerUpdateTime)
            }else {
                if editTimerTime != nil {
                    setTimeLabel(editTimerTime!)
                }else {
                    setTimeLabel(timerTime!)
                }
            }
            //      if let start = startTime {
            //        if let stop = stopTime {
            //          let time = calcRestartTime(start: start, stop: stop)
            //          let diff = Date().timeIntervalSince(time)//burda startdan stopa nece saniye kecib onu gosterir ama bu burda lazim deyil
            //          //                    setTimeLabel(Int(diff))
            //        }
            //      }
        }
    }
    
    //MARK: - StartStopButtonAction
    @objc private func startStopButtonAction() {
        if timerCounting { //stop timer
            setStopTime(date: Date())
            //      pomodoroStopTime = Date()
            setTimerCounting(false)
            if toDay == weekDay {
                timerStartStopDelegate?.timerStartStop(index: index, timerCounting: timerCounting, startTime: startTime, stopStime: stopTime)
            }else {
                sentAlertActionDelegate?.sentAlert()
            }
            //            progressBar.pauseAnimation()
            
        }else { //start timer
            //        print("start cell test 291  name == \(nameLabel.text)")
            print("3333333")
            misStopTime = stopTime
            misStartTime = startTime
            if let stop = stopTime {
                //                guard let startTime = startTime else { return }
                
                let restartTime = calcRestartTime(start: startTime!, stop: stop)
                setStopTime(date: nil)
                print("22222222")
                //        print("RESTART  TIMEE CEll 294 === \(restartTime)  nameee == \(nameLabel.text)")
                //        print("STARTIME == \(startTime) --- stopTime == \(stop)  nameee == \(nameLabel.text)")
                setStartTime(date: restartTime)
            }else {
                setStartTime(date: Date())
            }
            setTimerCounting(true)
            if toDay == weekDay {
                timerStartStopDelegate?.timerStartStop(index: index, timerCounting: timerCounting, startTime: startTime, stopStime: stopTime)
            }else {
                sentAlertActionDelegate?.sentAlert()
            }
        }
    }
    
    //MARK: - Stop In Edit
    //Edit vc den dayy false edende eger timer isdeyirse bu timrei stop edir
    //Bu uje lazim deyil sora bax cunki timer start olubsa onu editden stop elemek olmur
    func stopInEdit() {
        setStopTime(date: Date())
        pomodoroStopTime = Date()
        //            stopTimer()
        setTimerCounting(false)
        timerStartStopDelegate?.timerStartStop(index: index, timerCounting: timerCounting, startTime: startTime, stopStime: stopTime)
    }
    
    //MARK: - Start timer
    func startTimer() {
        let timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(refreshValue), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .common)
        timer.tolerance = 0.1
        self.timer = timer
        removeBool = true
        if toDay == weekDay {
            UIView.animate(withDuration: 0.3) {
                self.timerLabel.textColor = .white
                self.startButton.setTitle("Pause", for: .normal)
                self.startButton.backgroundColor = .white
                self.startButton.setTitleColor(.black, for: .normal)
            }
        }else {
            timerLabel.textColor = .black
            startButton.setTitle("Start", for: .normal)
            startButton.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
            startButton.setTitleColor(.white, for: .normal)
        }
        
        
        //circular bar
        //        if animteBool == false {
        //            DispatchQueue.main.asyncAfter(deadline: .now() + 0.27) {
        ////                self.progressBar.firstAnimation(value: self.updateCircularBar())
        //                self.progressBar.basicAnimationFunc()
        //                self.progressBar.resumeAnimation()
        //                self.animteBool = true
        //                print("AAAAAAAAAA")
        //            }
        //        }else {
        //            print("CELL RESUMEE")
        //            progressBar.resumeAnimation()
        //        }
    }
    
    //MARK: - Refresh Value
    @objc private func refreshValue() {
        if testBoool == false {
            print("TIMER start time == \(startTime) == \(nameLabel.text)")
            print("TIMER STOP time == \(secondsToHoursMinutesSeconds(Int(startTime!.timeIntervalSince(Date(timeIntervalSinceNow: TimeInterval(-timerTime!)))))) == \(nameLabel.text)")
            testBoool = true
        }
        
        weekDayAdd()
        if let start = startTime, let timerTime = timerTime {
            let diff = start.timeIntervalSince(Date(timeIntervalSinceNow: TimeInterval(-timerTime)))
            //            let diff = Date().timeIntervalSince(start)
            
            if self.toDay == self.weekDay {
                self.setTimeLabel(Int(diff))
            }else {
                if self.editTimerTime != nil {
                    self.setTimeLabel(self.editTimerTime!)
                }else {
                    self.setTimeLabel(timerTime)
                }
            }
            setTimerUpdateTimeDeleagte?.setTimerNewTime(newTime: Int(diff), index: index!)
            if Int(diff) <= 0 {
                stopTimer()
                if toDay == weekDay {
                    timerDone()
                }
                setTimerCounting(false)
                setTimeLabel(self.timerTime!)
                setStartTime(date: nil)
                setStopTime(date: nil)
                animteBool = false
            }
        }
    }
    
    //MARK: - Start Timer Fake
    //if today != weekday
    private func startTimerFake() {
        timerLabel.textColor = .black
        startButton.setTitle("Start", for: .normal)
        startButton.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        startButton.setTitleColor(.white, for: .normal)
        
        if self.editTimerTime != nil {
            self.setTimeLabel(self.editTimerTime!)
        }else {
            self.setTimeLabel(timerTime!)
        }
    }
    
    //MARK: - Stop timer
    func stopTimer() {
        testBoool = false
        timerLabel.textColor = .black
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
        removeBool = false
        if toDay == weekDay {
            UIView.animate(withDuration: 0.3) {
                self.startButton.setTitle("Start", for: .normal)
                self.startButton.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                self.startButton.setTitleColor(.white, for: .normal)
            }
        }else {
            startButton.setTitle("Start", for: .normal)
            startButton.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
            startButton.setTitleColor(.white, for: .normal)
        }
    }
    
    private func timerDone() {
        startButton.setTitle("Done", for: .normal)
        startButton.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        startButton.setTitleColor(.black, for: .normal)
    }
    
    //MARK: - MisTimer
    //Start basanda eger basqa timerde start olubsa onda bu isdeyecey yoxsa startTime, stopTimeda vaxtlar sef olacaq
    func missTimer() {
        setStopTime(date: misStopTime)
        setStartTime(date: misStartTime)
        setTimerCounting(false)
    }
    
    //MARK: - Edit Timer
    @objc private func editTimerAction() {
        guard let index = index else { return }
        showEditVcDelegate?.showEditVc(index: index)
    }
    
    //MARK: - Timer Remove
    @objc private func timerRemove() {
        guard let modelIndex = timerRemoveIndex else { return }
        removeTimerDelegate?.removeIndex(modelIndex: modelIndex, deleteBool: removeBool, cellIndex: index!)
    }
    
    //MARK: - Timer Is Remove
    func timerIsRemove() {
        setStartTime(date: nil)
        setStopTime(date: nil)
    }
    
    private func calcRestartTime(start: Date, stop: Date) -> Date {
        let diff = start.timeIntervalSince(stop)
//        print("DIFFF == \(secondsToHoursMinutesSeconds(Int(diff)))")
//        print(Int(diff))
//        print(Date().addingTimeInterval(diff))
//        print(secondsToHoursMinutesSeconds(300))
        return Date().addingTimeInterval(diff)
    }
    
    //timer label add timer
    private func setTimeLabel(_ val: Int) {
        let time = secondsToHoursMinutesSeconds(val)
        let timeString = makeTimeString(hour: time.0, min: time.1, sec: time.2)
        timerLabel.text = timeString
    }
    
    private func secondsToHoursMinutesSeconds(_ ms: Int) -> (Int, Int, Int) {
        let hour = ms / 3600
        let min = (ms % 3600) / 60
        let sec = (ms % 3600) % 60
        return (hour, min, sec)
    }
    
    private func makeTimeString(hour: Int, min: Int, sec: Int) -> String {
        var timeString = ""
        timeString += String(format: "%2d", hour)
        timeString += ":"
        timeString += String(format: "%02d", min)
        timeString += ":"
        timeString += String(format: "%02d", sec)
        return timeString
    }
    
    //    private func updateCircularBar() -> Float {
    //        var bbb = String()
    //        if let timerTimeee = timerTime {
    //            let aaa = timerTimeee - timerUpdateTime
    //            bbb = String(format:"%.02f", Float(aaa * 100) / Float(timerTimeee))
    ////            circulerStartStopTime = Float(bbb)
    //            print("TIMER TIME UPDATE == \(bbb)")
    //
    //        }
    //        print("BBBBBBBBB === \(bbb)")
    //        return Float(bbb)!
    //    }
    
    func timerCountingFalse() {
        timerCounting = false
    }
    
    private func setStartTime(date: Date?) {
        startTime = date
    }
    
    private func setStopTime(date: Date?) {
        stopTime = date
    }
    
    private func setTimerCounting(_ val: Bool) {
        timerCounting = val
    }
    
    //MARK: - Week Day yeni bugun necenci gundu
    private func weekDayAdd() {
        let date = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let today = Calendar.current.component(.weekday, from: date)
        self.toDay = today
    }
    
    //MARK: - Setup Item
    private func setupItem() {
        //        addSubview(editsImageView)
        //        editsImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        ////        editsImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        //        editsImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        //        editsImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        //        editsImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        contentView.addSubview(editsTimerButton)
        editsTimerButton.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        editsTimerButton.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 15).isActive = true
        //        editsTimerButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        //        editsTimerButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        editsTimerButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        editsTimerButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        editsTimerButton.addTarget(self, action: #selector(editTimerAction), for: .touchDown)
        
        addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        //        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35).isActive = true
        
        addSubview(removeImageView)
        removeImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        removeImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        removeImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        removeImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        contentView.addSubview(removeTimer)
        removeTimer.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        removeTimer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        removeTimer.heightAnchor.constraint(equalToConstant: 35).isActive = true
        removeTimer.widthAnchor.constraint(equalToConstant: 35).isActive = true
        removeTimer.addTarget(self, action: #selector(timerRemove), for: .touchDown)
        
        
        
        
        
        //        progressBar = ProgressBar()
        //        contentView.addSubview(progressBar)
        //        progressBar.translatesAutoresizingMaskIntoConstraints = false
        //        progressBar.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0).isActive = true
        //        progressBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        //        progressBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        //        progressBar.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100).isActive = true
        
        //        contentView.addSubview(timerLabelAndProfressUIView)
        //        timerLabelAndProfressUIView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        //        timerLabelAndProfressUIView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        //        timerLabelAndProfressUIView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        //        timerLabelAndProfressUIView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100).isActive = true
        //
        contentView.addSubview(timerLabel)
        timerLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20).isActive = true
        timerLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        timerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        timerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        
        contentView.addSubview(startButton)
        startButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
        startButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        startButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        //        startButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        startButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/6).isActive = true
        startButton.addTarget(self, action: #selector(startStopButtonAction), for: .touchDown)
        
        contentView.addSubview(pomodoroTimerLabel)
        pomodoroTimerLabel.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -20).isActive = true
        pomodoroTimerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        pomodoroTimerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
    }
    
    private func layoutSub() {
        self.backgroundColor = UIColor().hexStringToUIColor(hex: timerCellColor)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        startButton.layer.cornerRadius = 10
        startButton.clipsToBounds = true
    }
    
    
    //MARK: - Pomodoro Timer
    //    private func pomodoroTimerStart() {
    //        let pomodoroTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(refreshPomodoroValue), userInfo: nil, repeats: true)
    //        RunLoop.current.add(pomodoroTimer, forMode: .common)
    //        pomodoroTimer.tolerance = 0.1
    //        self.pomodoroTimer = pomodoroTimer
    //
    //        print("START")
    //    }
    //
    //    @objc private func refreshPomodoroValue() {
    //        if let pomodoroStartTime = pomodoroStartTime {
    //            if isPomodorTimerWorkOrBreak == true {
    //                let pomodoroDiff = pomodoroStartTime.timeIntervalSince(Date(timeIntervalSinceNow: TimeInterval(-pomodoroWorkTime )))
    //                setPomodoroTimeLabel(Int(pomodoroDiff))
    //                //                print("111111 === \(Int(pomodoroDiff))")
    //                if pomodoroDiff <= 0 {
    //                    isPomodorTimerWorkOrBreak = false
    //                    self.pomodoroStartTime = Date()
    //                    print("111111 === \(Int(pomodoroDiff))")
    //                }
    //                setPomodoroTimerUpdateTimeDeleagte?.setPomodoroNewTime(newTime: Int(pomodoroDiff), pomdoroTimerBreakOrWork: isPomodorTimerWorkOrBreak, index: index!)
    //            }else {
    //                let pomodoroDiff = pomodoroStartTime.timeIntervalSince(Date(timeIntervalSinceNow: TimeInterval(-pomodoroBreakTime )))
    //                setPomodoroTimeLabel(Int(pomodoroDiff))
    //                //                print("22222 === \(Int(pomodoroDiff))")
    //                if pomodoroDiff <= 0 {
    //                    isPomodorTimerWorkOrBreak = true
    //                    self.pomodoroStartTime = Date()
    //                    print("22222 === \(Int(pomodoroDiff))")
    //                }
    //                setPomodoroTimerUpdateTimeDeleagte?.setPomodoroNewTime(newTime: Int(pomodoroDiff), pomdoroTimerBreakOrWork: isPomodorTimerWorkOrBreak, index: index!)
    //            }
    //        }
    //    }
    //
    //    private func setPomodoroTimeLabel(_ val: Int) {
    //        let time = secondsToHoursMinutesSeconds(val)
    //        let pomodoroTimeString = makePomodoroTimeString(min: time.1, sec: time.2)
    //        pomodoroTimerLabel.text = pomodoroTimeString
    //    }
    //
    //    private func makePomodoroTimeString(min: Int, sec: Int) -> String {
    //        var timeString = ""
    //        timeString += String(format: "%02d", min)
    //        timeString += ":"
    //        timeString += String(format: "%02d", sec)
    //        return timeString
    //    }
    
}

