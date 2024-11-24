//
//  RankingDTO.swift
//  Leaderboard
//
//  Created by Gordon Choi on 11/10/24.
//

import Foundation

struct RankingResponse: Codable {
    let data: [RankingDTO]?
}

struct RankingDTO: Codable {
    let userId: String
    let nickname: String
    let score: Int?
    let seconds: Double?
    
    func toScoreRanking() -> ScoreRanking? {
        guard let score else { return nil }
        
        return ScoreRanking(userId: userId, nickname: nickname, score: score)
    }
    
    func toTimeRanking() -> TimeRanking? {
        guard let seconds else { return nil }
        
        return TimeRanking(userId: userId, nickname: nickname, seconds: seconds)
    }
}

// MARK: - Experiment for decoding error
struct ViceRankingResponse: Codable {
    let data: [ViceRankingDTO]?
}

struct ViceRankingDTO: Codable {
    let userId: String
    let nickname: String
    let score: Int?
    let seconds: Int?
    
    func toScoreRanking() -> ScoreRanking? {
        guard let score else { return nil }
        
        return ScoreRanking(userId: userId, nickname: nickname, score: score)
    }

    func toTimeRanking() -> TimeRanking? {
        guard let seconds else { return nil }
        
        return TimeRanking(userId: userId, nickname: nickname, seconds: Double(seconds))
    }
}
