//
//  Ranking.swift
//  Leaderboard
//
//  Created by Gordon Choi on 11/10/24.
//

import Foundation

protocol Ranking: Hashable {
    var userId: String { get }
    var nickname: String { get }
}

struct ScoreRanking: Ranking {
    let userId: String
    let nickname: String
    let score: Int
}

struct TimeRanking: Ranking {
    let userId: String
    let nickname: String
    let seconds: Double
}
