//
//  RankingRepositoryImpl.swift
//  Leaderboard
//
//  Created by Gordon Choi on 11/10/24.
//

import Foundation

final class RankingRepositoryImpl: RankingRepository {
    func getScoreRankings() async throws -> [ScoreRanking] {
        let data = try await APIManager.shared.getRankings(.score)
        
        guard let scoreRankingsData = try? JSONDecoder().decode(RankingResponse.self, from: data) else {
            throw LeaderboardError.failedToDecode
        }
        
        guard let scoreRankings = scoreRankingsData.data else {
            throw LeaderboardError.failedToGetData
        }
        
        return scoreRankings.compactMap { $0.toScoreRanking() }
    }
    
    func getTimeRankings() async throws -> [TimeRanking] {
        let data = try await APIManager.shared.getRankings(.time)
        
        guard let timeRankingsData = try? JSONDecoder().decode(ViceRankingResponse.self, from: data) else {
            throw LeaderboardError.failedToDecode
        }
        
        guard let timeRankings = timeRankingsData.data else {
            throw LeaderboardError.failedToGetData
        }
        
        return timeRankings.compactMap { $0.toTimeRanking() }
    }
}
