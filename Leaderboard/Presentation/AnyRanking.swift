//
//  AnyRanking.swift
//  Leaderboard
//
//  Created by Gordon Choi on 11/10/24.
//

import Foundation

struct AnyRanking: Hashable {
    let base: any Ranking
    
    let rankingType: RankingType
    let userId: String
    let nickname: String
    
    init(_ ranking: any Ranking, type: RankingType) {
        self.base = ranking
        self.userId = ranking.userId
        self.nickname = ranking.nickname
        
        self.rankingType = type
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(userId)
        hasher.combine(rankingType)
    }
    
    static func == (lhs: AnyRanking, rhs: AnyRanking) -> Bool {
        return lhs.userId == rhs.userId && lhs.rankingType == rhs.rankingType
    }
}
