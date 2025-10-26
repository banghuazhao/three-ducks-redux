import Combine
import Foundation

func bestScoreMiddleware(using persistence: some ScorePersistenceProtocol) -> Middleware<ThreeDucksState, ThreeDucksAction> {
    { state, action in
        switch action {
        case .launch:
            let score = persistence.load()
            return Just(.setPreviousBestScore(score)).eraseToAnyPublisher()
        case .winGame:
            let moves = state.moves
            let difficulty = state.gameDifficulty
            let newScore = Score(difficulty: difficulty, moves: moves)
            
            guard let previousBestScore = state.previousBestScore else {
                persistence.save(newScore)
                return Just(.setPreviousBestScore(newScore)).eraseToAnyPublisher()
            }
            
            if newScore > previousBestScore {
                persistence.save(newScore)
                return Just(.setPreviousBestScore(newScore)).eraseToAnyPublisher()
            }

        default:
            break
        }
        return Empty().eraseToAnyPublisher()
    }
}
