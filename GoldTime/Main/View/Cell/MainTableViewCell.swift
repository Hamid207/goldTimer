//
//  MainTableViewCell.swift
//  GoldTime
//
//  Created by Hamid Manafov on 21.01.22.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    weak var pushhDelegate: PushTimerDetailVCDelegate?

    
    private var timer = Timer()
    var index: Int?
    
    private var seconds: Int = 0
    private var minute: Int = 0
    private var hourse: Int = 0
    private var statickSeconds: Int = 0
    private var statickMinute: Int = 0
    private var statickHourse: Int = 0
    
    private var startPauseBool: Bool = false
    private var startFix: Bool = false
    
    private var backroundLayer: CAShapeLayer!
    private var foregroundLayer: CAShapeLayer!
    private var textLayer: CATextLayer!
    private var timerSecondsLayer: CGFloat!
    private var animteBool: Bool = false

    private let timerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Bpütün alt kateqoriyalar"
        label.font = UIFont.systemFont(ofSize: 80, weight: .regular)
        return label
    }()
    
    private let startButton: UIButton = {
         let button = UIButton()
         button.translatesAutoresizingMaskIntoConstraints = false
         button.setTitle("Start", for: .normal)
         button.backgroundColor = .black
         return button
     }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        itemSetup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(model: TimerModelData){
        let aa = "\(model.hourse):\(model.minute):\(model.seconds)"
        self.seconds = model.seconds
        self.minute = model.minute
        self.hourse = model.hourse
        self.statickSeconds = model.statick
        timerLabel.text = aa
    }
    
    override func draw(_ rect: CGRect) {
        let width = rect.width
        let height = rect.height
        let lineWidth = 0.03 * min(width, height)
        
        backroundLayer = createCircularLayer(rect: rect, strokeColor: UIColor.white.cgColor, fillColor: UIColor.clear.cgColor, lineWidth: lineWidth)
        foregroundLayer = createCircularLayer(rect: rect, strokeColor: UIColor.red.cgColor, fillColor: UIColor.clear.cgColor, lineWidth: lineWidth)

//        foregroundLayer.strokeEnd = 0.9

//        layer.addSublayer(backroundLayer)
//        layer.addSublayer(foregroundLayer)
    }
    
    private func createCircularLayer(rect: CGRect, strokeColor: CGColor, fillColor: CGColor, lineWidth: CGFloat) -> CAShapeLayer {
        let width = rect.width
        let height = rect.height
                
        let center = CGPoint(x: width / 2, y: height / 2)
        let radius = (min(height, width) - lineWidth) / 2.2
        
        let startAngle = -CGFloat.pi / 2
        let endAngle = startAngle + 2 * CGFloat.pi
        
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = strokeColor
        shapeLayer.fillColor = fillColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineCap = .round
        return shapeLayer
    }
    
    private func basicAnimation() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 0
        basicAnimation.duration = CFTimeInterval(timerSecondsLayer)
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        foregroundLayer.add(basicAnimation, forKey: "basicAnimation")
    }
    
    private func pauseAnimation(){
        let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime
    }
    
    private func resumeAnimation(){
        let pausedTime = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
    }
    
    @objc private func startButtonTarget() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
//            self.pushhDelegate?.timerStartDelegate(index: self.index!, startPauseBool: self.startPauseBool, bugFixBool: nil, secondTimerDontStart: <#Bool?#>)
            if !self.startPauseBool{
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerStart), userInfo: nil, repeats: true)
                self.startButton.setTitle("Pause", for: .normal)
                self.startButton.backgroundColor = .red
                self.startPauseBool = true
                print("1111111111111")
            }else{
                self.timer.invalidate()
                self.startButton.setTitle("Start", for: .normal)
                self.startButton.backgroundColor = .black
                self.startPauseBool = false
                print("22222222222")
                }
        }
    }
    
    @objc private func timerStart() {
        seconds -= 1
        if seconds == -1 {
            minute -= 1
            seconds = 59
        }
        
        if minute == -1 {
            hourse -= 1
            minute = 59
        }
        
        let timerSecund = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let timerMinute = minute > 9 ? "\(minute):" : "0\(minute):"
        let timerHourse = hourse == 0 ? "" : "\(hourse):"
        
        timerLabel.text = "\(timerHourse)\(timerMinute)\(timerSecund)"
        
        if hourse == 0 && minute == 0 && seconds == 0 {
            timer.invalidate()
            seconds = statickSeconds
            minute = statickMinute
            hourse = statickHourse
            timerLabel.text = "00:00:00"
            startButton.setTitle("Start", for: .normal)
            startButton.backgroundColor = .black
            startPauseBool = false
        }
    }
    
    func itemSetup() {
        contentView.addSubview(timerLabel)
        timerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        timerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        timerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
//        timerLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        contentView.addSubview(startButton)
        startButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        startButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        startButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        startButton.addTarget(self, action: #selector(startButtonTarget), for: .touchUpInside)
    }

}
