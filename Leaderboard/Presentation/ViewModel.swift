//
//  ViewModel.swift
//  Leaderboard
//
//  Created by Gordon Choi on 11/10/24.
//

import Combine
import Foundation

final class ViewModel {
    var isScoreRanking: Bool = true
    var rankings: CurrentValueSubject<[AnyRanking], Never> = .init([])
    var error: CurrentValueSubject<LeaderboardError?, Never> = .init(nil)
    
    private let useCase: RankingUseCase
    
    init(useCase: RankingUseCase = RankingUseCaseImpl()) {
        self.useCase = useCase
    }
    
    func getRankings() {
        if isScoreRanking {
            getScoreRankings()
        } else {
            getTimeRankings()
        }
    }
    
    private func getScoreRankings() {
        Task {
            do {
                let rankings = try await useCase.getScoreRankings().map { AnyRanking($0, type: .score) }
                self.rankings.send(rankings)
            } catch {
                if let error = error as? LeaderboardError {
                    self.error.send(error)
                } else {
                    self.error.send(.unknown)
                }
            }
        }
    }
    
    private func getTimeRankings() {
        Task {
            do {
                let rankings = try await useCase.getTimeRankings().map { AnyRanking($0, type: .time) }
                self.rankings.send(rankings)
            } catch {
                if let error = error as? LeaderboardError {
                    self.error.send(error)
                } else {
                    self.error.send(.unknown)
                }
            }
        }
    }
    
    private func handleError(_ error: Error) {
        print(error)
        
        if let error = error as? LeaderboardError {
            self.error.send(error)
        } else {
            self.error.send(.unknown)
        }
    }
}
