//
//  ViewModel.swift
//  Leaderboard
//
//  Created by Gordon Choi on 11/10/24.
//

import Combine
import Foundation

final class ViewModel {
    var rankings: CurrentValueSubject<[any Ranking], Never> = .init([])
    var error: CurrentValueSubject<LeaderboardError?, Never> = .init(nil)
    
    private let useCase: RankingUseCase
    
    init(useCase: RankingUseCase = RankingUseCaseImpl()) {
        self.useCase = useCase
    }
    
    
}
