//
//  RankingUseCase.swift
//  Leaderboard
//
//  Created by Gordon Choi on 11/10/24.
//

import Foundation

protocol RankingUseCase {
    func getScoreRankings() async throws -> [ScoreRanking]
    func getTimeRankings() async throws -> [TimeRanking]
}

final class RankingUseCaseImpl: RankingUseCase {
    private let rankingRepository: RankingRepository
    
    init(rankingRepository: RankingRepository = RankingRepositoryImpl()) {
        self.rankingRepository = rankingRepository
    }
    
    func getScoreRankings() async throws -> [ScoreRanking] {
        try await rankingRepository.getScoreRankings()
    }
    
    func getTimeRankings() async throws -> [TimeRanking] {
        try await rankingRepository.getTimeRankings()
    }
}
