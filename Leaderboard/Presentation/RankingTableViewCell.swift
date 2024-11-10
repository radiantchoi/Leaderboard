//
//  RankingTableViewCell.swift
//  Leaderboard
//
//  Created by Gordon Choi on 11/10/24.
//

import UIKit

import SnapKit

final class RankingTableViewCell: UITableViewCell {
    static let identifier = "RankingTableViewCell"
    
    private lazy var nicknameLabel: UILabel = {
        $0.text = "nickname"
        
        return $0
    }(UILabel())
    
    private lazy var scoreLabel: UILabel = {
        $0.text = "0"
        
        return $0
    }(UILabel())

    private lazy var timeLabel: UILabel = {
        $0.text = "0"
        
        return $0
    }(UILabel())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(nicknameLabel)
        contentView.addSubview(scoreLabel)
        contentView.addSubview(timeLabel)
    }
    
    private func setupConstraints() {
        nicknameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(8)
            $0.centerY.equalToSuperview()
        }
        
        scoreLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(8)
            $0.centerY.equalToSuperview()
        }
        timeLabel.snp.makeConstraints {
            $0.trailing.equalTo(scoreLabel)
            $0.centerY.equalToSuperview()
        }
    }
    
    func configureContents(ranking: any Ranking) {
        nicknameLabel.text = ranking.nickname
        
        if let ranking = ranking as? ScoreRanking {
            scoreLabel.isHidden = false
            scoreLabel.text = "\(ranking.score)"
            timeLabel.isHidden = true
        } else if let ranking = ranking as? TimeRanking {
            timeLabel.isHidden = false
            timeLabel.text = "\(ranking.seconds)"
            scoreLabel.isHidden = true
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nicknameLabel.text = "nickname"
        scoreLabel.text = "0"
        timeLabel.text = "0"
    }
}
