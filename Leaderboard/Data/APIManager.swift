//
//  APIManager.swift
//  Leaderboard
//
//  Created by Gordon Choi on 11/10/24.
//

import Foundation

enum RankingType {
    case score
    case time
}

struct APIManager {
    static let shared = APIManager()
    
    private init() {}
    
    func getRankings(_ type: RankingType) async throws -> Data {
        switch type {
        case .score:
            try await DataProvider.shared.provideScoreRanking()
        case .time:
            try await DataProvider.shared.provideTimeRanking()
        }
    }
}
