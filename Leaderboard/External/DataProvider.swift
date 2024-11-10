//
//  DataProvider.swift
//  Leaderboard
//
//  Created by Gordon Choi on 11/10/24.
//

import Foundation

struct DataProvider {
    static let shared = DataProvider()
    
    private init() {}
    
    func provideScoreRanking() async throws -> Data {
        guard let url = Bundle.main.url(forResource: "score_ranking", withExtension: "json") else {
            throw LeaderboardError.invalidURL
        }
        
        guard let data = try? Data(contentsOf: url) else {
            throw LeaderboardError.failedToGetData
        }
        
        return data
    }
    
    func provideTimeRanking() async throws -> Data {
        guard let url = Bundle.main.url(forResource: "time_ranking", withExtension: "json") else {
            throw LeaderboardError.invalidURL
        }
        
        guard let data = try? Data(contentsOf: url) else {
            throw LeaderboardError.failedToGetData
        }
        
        return data
    }
}
