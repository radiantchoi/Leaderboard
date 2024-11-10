//
//  ViewController.swift
//  Leaderboard
//
//  Created by Gordon Choi on 11/10/24.
//

import Combine
import UIKit

import SnapKit

final class ViewController: UIViewController {
    private lazy var toggleSwitch: UISwitch = {
        return $0
    }(UISwitch())
    
    private lazy var boardTableView: UITableView = {
        $0.backgroundColor = .black
        
        return $0
    }(UITableView())
    
    private var dataSource: DataSource?
    private var cancellables = Set<AnyCancellable>()
    
    private let viewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        observeUIEvents()
        observeObjects()
        
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.getRankings()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(toggleSwitch)
        view.addSubview(boardTableView)
        
        toggleSwitch.isOn = true
    }
    
    private func setupConstraints() {
        toggleSwitch.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        boardTableView.snp.makeConstraints {
            $0.top.equalTo(toggleSwitch.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func observeUIEvents() {
        toggleSwitch.addTarget(self, action: #selector(toggleSwitchTapped), for: .valueChanged)
    }
    
    private func observeObjects() {
        viewModel.rankings
            .receive(on: DispatchQueue.main)
            .sink { [weak self] rankings in
                guard let self else { return }
                print(rankings)
                
                var snapshot = dataSource?.snapshot() ?? makeNewSnapshot()
                
                let oldItems = snapshot.itemIdentifiers(inSection: .ranking)
                snapshot.deleteItems(oldItems)
                
                let newItems = rankings.map { Item.rankingItem($0) }
                snapshot.appendItems(newItems, toSection: .ranking)
                
                dataSource?.apply(snapshot, animatingDifferences: true)
            }
            .store(in: &cancellables)
        
        viewModel.error
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                print(error)
            }
            .store(in: &cancellables)
    }
    
    @objc private func toggleSwitchTapped() {
        viewModel.isScoreRanking.toggle()
        viewModel.getRankings()
    }
}

extension ViewController {
    typealias DataSource = UITableViewDiffableDataSource<Section, Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
    
    enum Section {
        case ranking
    }
    
    enum Item: Hashable {
        case rankingItem(AnyRanking)
    }
    
    private func setupTableView() {
        boardTableView.delegate = self
        
        registerCells()
        setDataSource()
        
        let snapshot = makeNewSnapshot()
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
    
    private func registerCells() {
        boardTableView.register(RankingTableViewCell.self, forCellReuseIdentifier: RankingTableViewCell.identifier)
    }
    
    private func setDataSource() {
        dataSource = DataSource(tableView: boardTableView) { (tableView, indexPath, item) -> UITableViewCell? in
            switch item {
            case .rankingItem(let item):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: RankingTableViewCell.identifier, for: indexPath) as? RankingTableViewCell else {
                    return UITableViewCell()
                }
                
                cell.configureContents(ranking: item)
                
                return cell
            }
        }
    }
    
    private func makeNewSnapshot() -> Snapshot {
        var snapshot = Snapshot()
        
        snapshot.appendSections([.ranking])
        
        return snapshot
    }
}

extension ViewController: UITableViewDelegate {
    
}
