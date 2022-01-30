//
//  AddColorTableViewCell.swift
//  GoldTime
//
//  Created by Hamid Manafov on 28.01.22.
//

import UIKit

class AddColorTableViewCell: UITableViewCell {
    
    weak var sentColorDelegate: SentColorDelegate?
        
    private let colors: [UIColor] = [#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1),#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1),#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1),#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1),#colorLiteral(red: 0.5725490196, green: 0.5647058824, blue: 0, alpha: 1),#colorLiteral(red: 0.4784313725, green: 0.5058823529, blue: 1, alpha: 1),#colorLiteral(red: 1, green: 0.1843137255, blue: 0.5725490196, alpha: 1),#colorLiteral(red: 0.4509803922, green: 0.9803921569, blue: 0.4745098039, alpha: 1),#colorLiteral(red: 0.462745098, green: 0.8392156863, blue: 1, alpha: 1),#colorLiteral(red: 0.9098039216, green: 1, blue: 0.2117647059, alpha: 1),#colorLiteral(red: 1, green: 0.6784313725, blue: 0.6745098039, alpha: 1),#colorLiteral(red: 1, green: 0.4196078431, blue: 0.6, alpha: 1),#colorLiteral(red: 0.137254902, green: 1, blue: 0.3529411765, alpha: 1),#colorLiteral(red: 0.4235294118, green: 0.2352941176, blue: 1, alpha: 1)]
    private lazy var checkMarkArray: [Int : Bool] = [1 : false, 2 : false, 3 : false, 4 : false, 5 : false, 6 : false, 7 : false, 8 : false, 9 : false, 10 : false,11 : false, 12 : false, 13 : false, 14 : false, 15 : false, 16 : false, 17 : false, 18 : false, 19 : false, 20 : false, 21 : false]
    
    private let gradientLayer = CAGradientLayer()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return cv
    }()
    
    private let colorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        itemSetup()
    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
    }
    
    override func layoutSubviews() {
        self.backgroundColor = .clear
        colorView.layer.cornerRadius = 10
    }
    
    private func setupGradient() {
        self.layer.addSublayer(gradientLayer)
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
    }
    
    private func itemSetup() {
        contentView.addSubview(colorView)
        colorView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        colorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        colorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        colorView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        colorView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(IconsCell.self, forCellWithReuseIdentifier: "AddColorTableViewCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.topAnchor.constraint(equalTo: colorView.topAnchor, constant: 5).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: colorView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: colorView.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: colorView.bottomAnchor, constant: -5).isActive = true
    }

}

extension AddColorTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddColorTableViewCell", for: indexPath) as! IconsCell
        let item = colors[indexPath.item]
        let chekMarkItem = checkMarkArray[indexPath.item + 1]
        cell.update(color: item, isSelected: chekMarkItem!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: colorView.frame.width / 7.8 , height: colorView.frame.height - 10)
//        return CGSize(width: colorView.frame.width / 7.34 , height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.reloadData()
        for i in 1...checkMarkArray.count {
            checkMarkArray[i] = false
        }
        
        if checkMarkArray[indexPath.item + 1] == false {
            checkMarkArray[indexPath.item + 1] = true
            var color: String?
            switch indexPath.item {
                case 0: color = "#EC3C1A"
                case 1: color = "#3DACF7"
                case 2: color = "#3802DA"
                case 3: color = "#F3AF22"
                case 4: color = "#579F2B"
                case 5: color = "#929000"
                case 6: color = "#7A81FF"
                case 7: color = "#FF2F92"
                case 8: color = "#73FA79"
                case 9: color = "#76D6FF"
                case 10: color = "#E8FF36"
                case 11: color = "#FFADAC"
                case 12: color = "#FF6B99"
                case 13: color = "#23FF5A"
                case 14: color = "6C3CFF"
                default:
                    color = "#15C08E"
            }
            sentColorDelegate?.setColorDelegate(color: color)
        }
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

private class IconsCell: UICollectionViewCell  {
        
    private let colorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let checkMarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "checkmark.circle")
        imageView.tintColor = .black
        imageView.isHidden = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        checkMarkImageView.isHidden = true
    }
    
    func update(color: UIColor, isSelected: Bool) {
        colorView.backgroundColor = color
        if isSelected == true {
            checkMarkImageView.isHidden = false
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        itemSetup()
//        self.contentView.layer.borderWidth = 1
//        self.contentView.layer.borderColor = UIColor.black.cgColor
//        colorView.layer.cornerRadius = self.frame.height / 2
        colorView.layer.cornerRadius = 10
    }
    
    private func itemSetup() {
        addSubview(colorView)
        colorView.frame = self.bounds
        
        addSubview(checkMarkImageView)
        checkMarkImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        checkMarkImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        checkMarkImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/2).isActive = true
        checkMarkImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2).isActive = true
    }
}
