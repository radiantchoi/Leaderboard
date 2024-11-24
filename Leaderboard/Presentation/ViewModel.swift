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
                handleError(error)
            }
        }
    }
    
    private func getTimeRankings() {
        Task {
            do {
                let rankings = try await useCase.getTimeRankings().map { AnyRanking($0, type: .time) }
                self.rankings.send(rankings)
            } catch {
                handleError(error)
            }
        }
    }
    
    /// 에러 핸들링 함수입니다.
    ///
    /// 발생한 에러와 발생 지점을 print하여 기록합니다.
    /// 이후 error subject에 보냄으로서 유저에게 보여지는 에러 정보를 조정합니다.
    ///
    /// - Parameters:
    ///     - error: 발생한 에러
    ///     - file: 에러가 발생한 파일 이름 (기본값은 이 함수를 에러 핸들링을 위해 호출한 지점의 파일 이름)
    ///     - line: 에러가 발생한 코드 줄 번호 (기본값은 이 함수를 에러 핸들링을 위해 호출한 지점의 코드 줄 번호)
    private func handleError(_ error: Error, file: String = #fileID, line: Int = #line) {
        print(error)
        print("on \(file), line \(line)")
        
        if let error = error as? LeaderboardError {
            self.error.send(error)
        } else {
            self.error.send(.unknown)
        }
    }
}
