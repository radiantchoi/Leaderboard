//
//  RankingRepository.swift
//  Leaderboard
//
//  Created by Gordon Choi on 11/10/24.
//

import Foundation

protocol RankingRepository {
    func getScoreRankings() async throws -> [ScoreRanking]
    func getTimeRankings() async throws -> [TimeRanking]
}
