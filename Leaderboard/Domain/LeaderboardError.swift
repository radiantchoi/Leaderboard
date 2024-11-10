//
//  LeaderboardError.swift
//  Leaderboard
//
//  Created by Gordon Choi on 11/10/24.
//

import Foundation

enum LeaderboardError: Error {
    case invalidURL
    case failedToDecode
    case failedToGetData
}
