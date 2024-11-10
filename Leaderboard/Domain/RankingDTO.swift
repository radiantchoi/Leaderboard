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
    let id: String
    let nickname: String
    let score: Int?
    let seconds: Int?
    
    func toScoreRanking() -> ScoreRanking? {
        guard let score else { return nil }
        
        return ScoreRanking(userId: id, nickname: nickname, score: score)
    }
    
    func toTimeRanking() -> TimeRanking? {
        guard let seconds else { return nil }
        
        return TimeRanking(userId: id, nickname: nickname, seconds: seconds)
    }
}
