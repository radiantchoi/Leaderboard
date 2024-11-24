//
//  RankingUseCase.swift
//  Leaderboard
//
//  Created by Gordon Choi on 11/10/24.
//

import Foundation

protocol RankingUseCase {
    /// 점수에 따른 순위를 가져옵니다.
    /// 
    /// 서버 사이드에서 순위대로 정렬되어 반환됩니다.
    ///
    /// - Returns: 점수에 따른 순위 배열
    /// - Throws: 레포지토리에서 디코딩에 실패했을 경우 `LeaderboardError.failedToDecode`,
    ///  디코딩에는 성공했으나 자료가 없을 경우 `LeaderboardError.failedToGetData`
    func getScoreRankings() async throws -> [ScoreRanking]
    
    /// 소요 시간에 따른 순위를 가져옵니다.
    ///
    /// 서버 사이드에서 순위대로 정렬되어 반환됩니다.
    ///
    /// - Returns: 소요 시간에 따른 순위 배열
    /// - Throws: 레포지토리에서 디코딩에 실패했을 경우 `LeaderboardError.failedToDecode`,
    ///  디코딩에는 성공했으나 자료가 없을 경우 `LeaderboardError.failedToGetData`
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
