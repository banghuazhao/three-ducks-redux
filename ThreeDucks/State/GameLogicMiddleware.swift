import Combine
import Foundation

let gameLogic: Middleware<ThreeDucksState, ThreeDucksAction> = { state, action in
    switch action {
    case .flipCard:
        if state.cards.allSatisfy({ $0.isFlipped }) {
            return Just(.winGame)
                .delay(for: 1, scheduler: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
        if state.selectedCards.count == 2, !state.isFlipLocked {
            let first = state.selectedCards[0]
            let second = state.selectedCards[1]
            if first.animal == second.animal {
                return Just(.clearSelectedCards).eraseToAnyPublisher()
            } else {
                let lock = Just(ThreeDucksAction.setFlipLocked(true))
                    .eraseToAnyPublisher()
                let unFlip = Just(ThreeDucksAction.unFlipSelectedCards)
                    .delay(for: 1, scheduler: DispatchQueue.main)
                    .eraseToAnyPublisher()
                let unlock = Just(ThreeDucksAction.setFlipLocked(false))
                    .eraseToAnyPublisher()
                return lock
                    .append(unFlip)
                    .append(unlock)
                    .eraseToAnyPublisher()
            }
        }
    default:
        break
    }
    return Empty().eraseToAnyPublisher()
}
