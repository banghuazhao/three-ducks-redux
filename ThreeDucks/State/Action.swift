import Foundation

enum ThreeDucksAction {
    case startGame
    case endGame
    case flipCard(Card)
    case clearSelectedCards
    case unFlipSelectedCards
    case winGame
    case setFlipLocked(Bool)
    case setDifficulty(DifficultyLevel)
}
