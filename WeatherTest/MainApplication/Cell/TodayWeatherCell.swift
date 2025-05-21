//
//  TodayWeatherCell.swift
//  WeatherTest
//
//  Created by Евгений Таракин on 21.05.2025.
//

import UIKit
import SnapKit

final class TodayWeatherCell: UICollectionViewCell {
    
    // MARK: - property
    
    static let reuseIdentifier = String(describing: TodayWeatherCell.self)
    
    // MARK: - private property
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [timeLabel, imageView, weaterLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 0
        
        return stackView
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "01"
        label.textColor = .white
        label.font = .systemFont(ofSize: 20)
        
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "cross")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var weaterLabel: UILabel = {
        let label = UILabel()
        label.text = "13"
        label.textColor = .white
        label.font = .systemFont(ofSize: 20)
        
        return label
    }()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

// MARK: - private func

private extension TodayWeatherCell {
    func commonInit() {
        backgroundColor = .clear
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview().inset(2)
        }
    }
}

