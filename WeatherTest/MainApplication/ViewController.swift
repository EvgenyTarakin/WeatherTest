//
//  ViewController.swift
//  WeatherTest
//
//  Created by Евгений Таракин on 20.05.2025.
//

import UIKit
import SnapKit
import Alamofire

final class ViewController: UIViewController {

    // MARK: - private property
    
    private lazy var backView: UIView = {
        let backView = UIView()
        backView.backgroundColor = .black.withAlphaComponent(0.5)
        backView.addSubview(activityIndicator)
        
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        return backView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        
        return activityIndicator
    }()
    
    // MARK: - Main info
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.text = "City"
        label.textColor = .white
        label.font = .systemFont(ofSize: 36)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var nowStateLabel: UILabel = {
        let label = UILabel()
        label.text = "13 | Солнечно"
        label.textColor = .white
        label.font = .systemFont(ofSize: 24)
        label.textAlignment = .center
        
        return label
    }()
    
    // MARK: - Today weather
    
    private lazy var todayBackView: UIView = {
        let backView = UIView()
        backView.backgroundColor = .clear
        backView.layer.cornerRadius = 12
        backView.clipsToBounds = true
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = backView.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        backView.addSubview(blurEffectView)
        backView.addSubview(todayLabel)
        backView.addSubview(collectionView)
        
        todayLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.left.right.equalToSuperview().inset(12)
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(todayLabel.snp.bottom)
            $0.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
        
        return backView
    }()
    
    private lazy var todayLabel: UILabel = {
        let label = UILabel()
        label.text = "Сегодня и завтра"
        label.textColor = .white
        label.font = .systemFont(ofSize: 22)
        
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCollectionLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(TodayWeatherCell.self, forCellWithReuseIdentifier: TodayWeatherCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    // MARK: - Week weather
    
    private lazy var weekBackView: UIView = {
        let backView = UIView()
        backView.backgroundColor = .clear
        backView.layer.cornerRadius = 12
        backView.clipsToBounds = true
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = backView.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        backView.addSubview(blurEffectView)
        backView.addSubview(weekLabel)
        backView.addSubview(tableView)
        
        weekLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.left.right.equalToSuperview().inset(12)
        }
        
        return backView
    }()
    
    private lazy var weekLabel: UILabel = {
        let label = UILabel()
        label.text = "Прогноз на неделю"
        label.textColor = .white
        label.font = .systemFont(ofSize: 22)
        
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .white
        tableView.rowHeight = 44
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        tableView.isScrollEnabled = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(WeekWeatherCell.self, forCellReuseIdentifier: WeekWeatherCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    // MARK: - ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        makeTableLayout()
    }

}

// MARK: - private func

private extension ViewController {
    func commonInit() {
        view.backgroundColor = .systemBlue
        
        view.addSubview(cityLabel)
        view.addSubview(nowStateLabel)
        view.addSubview(todayBackView)
        view.addSubview(weekBackView)
//        view.addSubview(backView)
        
        cityLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.left.right.equalToSuperview().inset(16)
        }
        nowStateLabel.snp.makeConstraints {
            $0.top.equalTo(cityLabel.snp.bottom)
            $0.left.right.equalToSuperview().inset(16)
        }
        todayBackView.snp.makeConstraints {
            $0.top.equalTo(nowStateLabel.snp.bottom).inset(-16)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(150)
        }
        weekBackView.snp.makeConstraints {
            $0.top.equalTo(todayBackView.snp.bottom).inset(-16)
            $0.left.right.equalToSuperview().inset(16)
//            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
//        backView.snp.makeConstraints {
//            $0.top.bottom.left.right.equalToSuperview()
//        }
    }
    
    func makeCollectionLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.15), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 0, leading: 6, bottom: 0, trailing: 6)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .horizontal
        
        return UICollectionViewCompositionalLayout(section: section, configuration: config)
    }
    
    func makeTableLayout() {
        tableView.snp.makeConstraints {
            $0.top.equalTo(weekLabel.snp.bottom)
            $0.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.height.equalTo(tableView.contentSize.height)
        }
    }
    
    func loadInfo() {
        
    }
}

// MARK: - UICollectionViewDelegate

extension ViewController: UICollectionViewDelegate { }

// MARK: - UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayWeatherCell.reuseIdentifier, for: indexPath) as? TodayWeatherCell
        else { return UICollectionViewCell() }
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeekWeatherCell.reuseIdentifier, for: indexPath) as? WeekWeatherCell
        else { return UITableViewCell() }
        
        return cell
    }
}
