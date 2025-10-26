import Combine
import Foundation

func quackSoundMiddleware(using player: some QuackPlayerProtocol) -> Middleware<ThreeDucksState, ThreeDucksAction> { { _, action in
    switch action {
    case let .flipCard(card):
        if card.animal == .ducks, !card.isFlipped {
            player.play()
        }
    default:
        break
    }
    return Empty().eraseToAnyPublisher()
}
}
