//
//  WeekWeatherCell.swift
//  WeatherTest
//
//  Created by Евгений Таракин on 21.05.2025.
//

import UIKit
import SnapKit

final class WeekWeatherCell: UITableViewCell {
    
    // MARK: - property
    
    static let reuseIdentifier = String(describing: WeekWeatherCell.self)
    
    // MARK: - private property
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dateLabel, iconImageView, minLabel, maxLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 16
        
        return stackView
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Сегодня"
        label.textColor = .white
        label.font = .systemFont(ofSize: 18)
        
        return label
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "cross")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var minLabel: UILabel = {
        let label = UILabel()
        label.text = "12"
        label.textColor = .white
        label.font = .systemFont(ofSize: 18)
        
        return label
    }()
    
    private lazy var maxLabel: UILabel = {
        let label = UILabel()
        label.text = "30"
        label.textColor = .white
        label.font = .systemFont(ofSize: 18)
        
        return label
    }()
    
    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

// MARK: - private func

private extension WeekWeatherCell {
    func commonInit() {
        backgroundColor = .clear
        selectionStyle = .none
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalToSuperview().inset(12)
        }
    }
}

