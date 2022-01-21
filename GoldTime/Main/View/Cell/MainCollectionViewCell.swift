//
//  MainCollectionViewCell.swift
//  GoldTime
//
//  Created by Hamid Manafov on 21.01.22.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    weak var pushhDelegate: PushTimerDetailVCDelegate?
    weak var timerRemoveDelegate: TimerRemoveDelegate?
    
    var index: Int?
    var timerRemoveIndex: TimerModelData?
    private lazy var deleteBool: Bool = false
    var aaaaa = ["1", "2", "3", "4"]
    
    private lazy var timerTime: Int = 0
    private var saveTime: Int?
    
    private lazy var seconds: Int = 0
    private lazy var minute: Int = 0
    private lazy var hourse: Int = 0
    private lazy var statickSeconds: Int = 0
    private lazy var statickMinute: Int = 0
    private lazy var statickHourse: Int = 0
    
    private var isPomodoroTimerOnOff: Bool?
    private lazy var pomodoroTime: Int? = 0
    private lazy var isPomodoroTimerStarted: Bool? = nil
    
    private lazy var startPauseBool: Bool? = false
    private lazy var startFix: Bool = false
    private var startPauseUbdate = Bool()
    
    private lazy var bugFixBool: Bool? = true
    
    
    //    private var backroundLayer: CAShapeLayer!
    //    private var foregroundLayer: CAShapeLayer!
    //    private var textLayer: CATextLayer!
    //    private var timerSecondsLayer: CGFloat!
    //    private var animteBool: Bool = false
    
    private var timerCounting: Bool = false
    private var startTime: Date?
    private var stopTime: Date?
    
    private let removeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "trash.fill")
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
        label.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        return label
    }()
    
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        //        label.font = UIFont.systemFont(ofSize: 70, weight: .bold)
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 70, weight: .bold)
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
        button.backgroundColor = .black
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        itemSetup()
        print(aaaaa.joined(separator: " DIV "))
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = #colorLiteral(red: 0.08406862617, green: 0.7534314394, blue: 0.5585784912, alpha: 1)
        
        self.layer.cornerRadius = 10
        startButton.layer.cornerRadius = 10
    }
    
    
    func update(model: TimerModelData, startFix: Bool){
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let timerLabel = "\(model.hourse):\(model.minute):\(model.seconds)"
            self.saveTime = model.timerTime
            self.seconds = model.seconds
            self.minute = model.minute
            self.hourse = model.hourse
            self.statickSeconds = model.statick
            self.timerLabel.text = timerLabel
            self.nameLabel.text = model.name
            self.startFix = startFix
            self.pomodoroTime = model.pomodoroTime
            self.isPomodoroTimerOnOff = model.pomodoroTimerOnOff
            self.isPomodoroTimerStarted = model.pomodorTimerWorkOrBreak
            
            if self.isPomodoroTimerOnOff == true {
                self.pomodoroTimerLabel.text = self.pomodoroFormatTime(pomodoroTime: model.pomodoroTime)
            }else {
                self.pomodoroTimerLabel.text = ""
            }
            
            if model.pomodorTimerWorkOrBreak == true {
                self.pomodoroTimerLabel.textColor = .white
            }else if model.pomodorTimerWorkOrBreak == false {
                self.pomodoroTimerLabel.textColor = .blue
            }
            
            //            self.startPauseBool = startFix
            //            self.startPauseBool = startPauseUbdate ?? false
            //            self.startPauseBool = model.startFix
            //            var aaaaa = model.hourse * 60 * 60 + model.minute * 60 + model.seconds
            //            print(1500 / 60 % 60)
            self.timerCounting = model.timerCounting
            if let start = self.startTime {
                print("DATASTORE TIMER start == \(Int(Date().timeIntervalSince(start)))")
            }
            print("TIMER COUNTING CELL == \(model.timerCounting)")
            print("TIMER@@  == \(self.timeString(time: TimeInterval(model.userTimerstatistics ?? 0)))")
            if model.bugFixBool == true {
//                self.startTimer()
                //                self.startPauseBool = false
                self.startButtonTarget()
                print("111111111111111")
            }else if model.bugFixBool == false {
                self.pauseTimer()
//                self.startButtonTarget()
                print("222222222222222")

            }
        }
    }
    
    private func timeString(time: TimeInterval) -> String {
        let hour = Int(time) / 3600
        let minute = Int(time) / 60 % 60
        let second = Int(time) % 60
        
        // return formated string
        return String(format: "%02ih %02im %02is", hour, minute, second)
    }
    
    @objc private func timerRemove() {
        guard let index = timerRemoveIndex else { return }
        timerRemoveDelegate?.removeIndex(modelIndex: index, deleteBool: deleteBool, cellIndex: self.index!)
    }
    
    @objc private func startButtonTarget() {
        //        if let fireDateDescription = timer.fireDate.description {
        //          print(fireDateDescription)
        //        }
        if startPauseBool == false{
            bugFixBool = true
            pushhDelegate?.timerStartDelegate(index: index, startPauseBool: startPauseBool!, bugFixBool: bugFixBool, secondTimerDontStart: true)
            if let stop = self.stopTime
            {
                let restartTime = self.calcRestartTime(start: self.startTime!, stop: stop)
                self.stopTime = nil
                self.startTime = Date()
                print("Stop time = \(stop)")
                print("restartTime = \(restartTime)")
            }
            else
            {
                //1
                self.startTime = Date()
                print("=-=-=-=-=-=-=-=-=-=-=-=-==-==-=-=-=-=")
            }
        }else if startPauseBool == true{
            bugFixBool = false
            pushhDelegate?.timerStartDelegate(index: index, startPauseBool: startPauseBool!, bugFixBool: bugFixBool, secondTimerDontStart: false)
        }
    }
    
    //start timer view
    func startTimer() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            //            self.resumeAnimation()
            self.startButton.setTitle("Pause", for: .normal)
            self.startButton.backgroundColor = UIColor(named: "Pause")
            self.startPauseBool = true
            self.deleteBool = true
          
//            self.startTime = Date()
            print("CELL START")

        }
    }
    
    //pause timer view
    func pauseTimer() {
        //            self.pauseAnimation()
        startButton.setTitle("Start", for: .normal)
        startButton.backgroundColor = .black
        startPauseBool = false
        deleteBool = false
        timerCounting = true
        print("CELL PAUSE")
        guard let saveTime = saveTime else { return }
        timerTime = saveTime
    }
    
    //timer start logic
    func timerStart() {
        let diff = self.startTime?.timeIntervalSince(Date(timeIntervalSinceNow: TimeInterval(-self.timerTime)))
//            print("DIFF ==-=-=-==- \(Int(diff!))")
        self.saveTime = Int(diff!)
//            print("DIFF ==-=-=-==- \(self.saveTime )")
        self.setTimeLabel(Int(diff!))
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
           
//            self.seconds -= 1
//            if self.seconds == -1 {
//                self.minute -= 1
//                self.seconds = 59
//            }
//
//            if self.minute == -1 {
//                self.hourse -= 1
//                self.minute = 59
//            }
//
//            let timerSecund = self.seconds > 9 ? "\(self.seconds)" : "0\(self.seconds)"
//            let timerMinute = self.minute > 9 ? "\(self.minute):" : "0\(self.minute):"
//            let timerHourse = self.hourse == 0 ? "" : "\(self.hourse):"
            
//            self.timerLabel.text = "\(timerHourse)\(timerMinute)\(timerSecund)"
            //            self.timerLabel.text = String(format: "%02i:%02i:%02i", self.hourse, self.minute, self.seconds)
            
//            if self.hourse == 0 && self.minute == 0 && self.seconds == 0 {
//                self.seconds = self.statickSeconds
//                self.minute = self.statickMinute
//                self.hourse = self.statickHourse
//                self.timerLabel.text = "00:00:00"
//                self.startButton.setTitle("Start", for: .normal)
//                self.startButton.backgroundColor = .black
//                self.startPauseBool = false
//                print("000000000000")
//                if self.isPomodoroTimerOnOff == true {
//                    self.pomodoroTime = 10
//                    self.pomodoroTimerLabel.text = self.pomodoroFormatTime(pomodoroTime: self.pomodoroTime)
//                    self.pomodoroTimerLabel.textColor = .white
//                    self.isPomodoroTimerStarted = true
//                }
//            }
            
            if Int(diff!) == 0 {
                self.timerLabel.text = "00:00:00"
                self.startButton.setTitle("Start", for: .normal)
                self.startButton.backgroundColor = .black
                self.startPauseBool = false
                print("000000000000")
                if self.isPomodoroTimerOnOff == true {
                    self.pomodoroTime = 10
                    self.pomodoroTimerLabel.text = self.pomodoroFormatTime(pomodoroTime: self.pomodoroTime)
                    self.pomodoroTimerLabel.textColor = .white
                    self.isPomodoroTimerStarted = true
                }
            }
            
            //pomodoro timer
            if self.isPomodoroTimerOnOff == true {
                self.pomodoroTimer()
                self.pomodoroTimerLabel.text = self.pomodoroFormatTime(pomodoroTime: self.pomodoroTime)
            }
        }
    }
    
    //MARK: - Pomodoro Timer
    private func pomodoroFormatTime(pomodoroTime: Int?) -> String {
        let minutes = Int(pomodoroTime!) / 60 % 60
        let seconds = Int(pomodoroTime!) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
    
    private func pomodoroTimer() {
        pomodoroTime! -= 1
        // isPomodoroTimerStarted == true olanda pomodro timer 5 deyqe olur false olsa 25 deqyqe olur
        if pomodoroTime == 0 && isPomodoroTimerStarted == true {
            pomodoroTime = 5
            pomodoroTimerLabel.textColor = .blue
            isPomodoroTimerStarted = false
        }else if pomodoroTime == 0 && isPomodoroTimerStarted == false {
            pomodoroTime = 10
            pomodoroTimerLabel.textColor = .white
            isPomodoroTimerStarted = true
        }
    }
    
    
    func calcRestartTime(start: Date, stop: Date) -> Date
    {
        let diff = start.timeIntervalSince(stop)
        print("calcRestartTime = \(diff) , start = \(start), stop = \(stop)")
        print("calcRestartTime Date().addingTimeInterval(diff) = \(Date().addingTimeInterval(diff))")

        return Date().addingTimeInterval(diff)
    }
    
    func setTimeLabel(_ val: Int)
    {
        let time = secondsToHoursMinutesSeconds(val)
//        print("time = \(time)")
        let timeString = makeTimeString(hour: time.0, min: time.1, sec: time.2)
//        print("timeString = \(timeString)")
        timerLabel.text = timeString
    }
    
    func secondsToHoursMinutesSeconds(_ ms: Int) -> (Int, Int, Int)
    {
        let hour = ms / 3600
        let min = (ms % 3600) / 60
        let sec = (ms % 3600) % 60
        return (hour, min, sec)
    }
    
    func makeTimeString(hour: Int, min: Int, sec: Int) -> String
    {
        var timeString = ""
        timeString += String(format: "%02d", hour)
        timeString += ":"
        timeString += String(format: "%02d", min)
        timeString += ":"
        timeString += String(format: "%02d", sec)
        return timeString
    }
    
    //    override func draw(_ rect: CGRect) {
    //        let width = rect.width
    //        let height = rect.height
    //        let lineWidth = 0.03 * min(width, height)
    //
    //        backroundLayer = createCircularLayer(rect: rect, strokeColor: UIColor.white.cgColor, fillColor: UIColor.clear.cgColor, lineWidth: lineWidth)
    //        foregroundLayer = createCircularLayer(rect: rect, strokeColor: UIColor.red.cgColor, fillColor: UIColor.clear.cgColor, lineWidth: lineWidth)
    //
    ////        foregroundLayer.strokeEnd = 0.9
    //
    ////        layer.addSublayer(backroundLayer)
    ////        layer.addSublayer(foregroundLayer)
    //    }
    //
    //    private func createCircularLayer(rect: CGRect, strokeColor: CGColor, fillColor: CGColor, lineWidth: CGFloat) -> CAShapeLayer {
    //        let width = rect.width
    //        let height = rect.height
    //
    //        let center = CGPoint(x: width / 2, y: height / 2)
    //        let radius = (min(height, width) - lineWidth) / 2.2
    //
    //        let startAngle = -CGFloat.pi / 2
    //        let endAngle = startAngle + 2 * CGFloat.pi
    //
    //        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
    //
    //        let shapeLayer = CAShapeLayer()
    //        shapeLayer.path = circularPath.cgPath
    //        shapeLayer.strokeColor = strokeColor
    //        shapeLayer.fillColor = fillColor
    //        shapeLayer.lineWidth = lineWidth
    //        shapeLayer.lineCap = .round
    //        return shapeLayer
    //    }
    //
//        private func basicAnimation() {
//            let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
//            basicAnimation.toValue = 0
//            basicAnimation.duration = CFTimeInterval(timerSecondsLayer)
//            basicAnimation.fillMode = CAMediaTimingFillMode.forwards
//            basicAnimation.isRemovedOnCompletion = false
//            foregroundLayer.add(basicAnimation, forKey: "basicAnimation")
//        }
    //
    //    private func pauseAnimation(){
    //        let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
    //        layer.speed = 0.0
    //        layer.timeOffset = pausedTime
    //    }
    //
    //    private func resumeAnimation(){
    //        let pausedTime = layer.timeOffset
    //        layer.speed = 1.0
    //        layer.timeOffset = 0.0
    //        layer.beginTime = 0.0
    //        let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
    //        layer.beginTime = timeSincePause
    //    }
    
    private func itemSetup() {
        
        contentView.addSubview(removeImageView)
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
        
        contentView.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 60).isActive = true
        //        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        
        contentView.addSubview(timerLabel)
        //        timerLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20).isActive = true
        timerLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        timerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        timerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        
        contentView.addSubview(startButton)
        startButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
        startButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        startButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        startButton.addTarget(self, action: #selector(startButtonTarget), for: .touchUpInside)
        
        contentView.addSubview(pomodoroTimerLabel)
        pomodoroTimerLabel.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -20).isActive = true
        pomodoroTimerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        pomodoroTimerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
    }
    
}



//    //timerLabel
//     var hourseLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 50, weight: .medium)
//        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        label.textAlignment = .center
//        label.adjustsFontSizeToFitWidth = true
//        label.minimumScaleFactor = 0.2
//        label.text = "00 :"
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    var minuteLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 50, weight: .medium)
//        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        label.textAlignment = .center
//        label.adjustsFontSizeToFitWidth = true
//        label.minimumScaleFactor = 0.2
//        label.text = "00 :"
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    private let secundeLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 50, weight: .medium)
//        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        label.textAlignment = .center
//        label.adjustsFontSizeToFitWidth = true
//        label.minimumScaleFactor = 0.2
//        label.text = "00"
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
