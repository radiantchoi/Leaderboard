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
    
    private lazy var contentWrappingView = UIView()
    
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
        contentView.backgroundColor = .white
        
        contentView.addSubview(contentWrappingView)
        
        contentWrappingView.addSubview(nicknameLabel)
        contentWrappingView.addSubview(scoreLabel)
        contentWrappingView.addSubview(timeLabel)
    }
    
    private func setupConstraints() {
        contentWrappingView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview().inset(8)
        }
        
        scoreLabel.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview().inset(8)
        }
        timeLabel.snp.makeConstraints {
            $0.top.bottom.trailing.equalTo(scoreLabel).inset(8)
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
