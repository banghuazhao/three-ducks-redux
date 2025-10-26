typealias Reducer<State, Action> = (State, Action) -> State

let threeDucksReducer: Reducer<ThreeDucksState, ThreeDucksAction>
    = { state, action in
        var mutableState = state
        switch action {
        case .launch:
            mutableState.gameState = .title
        case .startGame:
            mutableState.gameState = .started
            mutableState.cards = cards(for: mutableState.gameDifficulty)
            mutableState.selectedCards = []
            mutableState.moves = 0
        case .winGame:
            mutableState.gameState = .won
        case .endGame:
            mutableState.gameState = .title
        case let .flipCard(card):
            guard !mutableState.isFlipLocked,
                  mutableState.selectedCards.count < 2,
                  !mutableState.selectedCards.contains(card),
                  let index = mutableState.cards.firstIndex(where: { $0 == card }) else {
                break
            }
            var cards = mutableState.cards
            var mutableCard = cards[index]
            guard !mutableCard.isFlipped else { break }
            var flippedCard = Card(id: mutableCard.id, animal: mutableCard.animal, isFlipped: true)
            cards[index] = flippedCard
            mutableState.cards = cards
            mutableState.selectedCards.append(flippedCard)
            mutableState.moves += 1
        case .clearSelectedCards:
            mutableState.selectedCards = []
        case .unFlipSelectedCards:
            let cards = mutableState.cards.map { card in
                mutableState.selectedCards.contains(card) ?
                    Card(id: card.id, animal: card.animal, isFlipped: false) : card
            }
            mutableState.selectedCards = []
            mutableState.cards = cards
        case let .setFlipLocked(isLocked):
            mutableState.isFlipLocked = isLocked
        case let .setDifficulty(difficulty):
            mutableState.gameDifficulty = difficulty
        case let .setPreviousBestScore(score):
            mutableState.previousBestScore = score
        }
        return mutableState
    }

private func cards(for difficult: DifficultyLevel) -> [Card] {
    var base: [Card] = [
        Card(animal: .bat),
        Card(animal: .bat),
        Card(animal: .ducks),
        Card(animal: .ducks),
        Card(animal: .bear),
        Card(animal: .bear),
        Card(animal: .pelican),
        Card(animal: .pelican),
        Card(animal: .horse),
        Card(animal: .horse),
        Card(animal: .elephant),
        Card(animal: .elephant),
    ]
    switch difficult {
    case .easy: break
    case .normal:
        base.append(contentsOf: [
            Card(animal: .monkey),
            Card(animal: .monkey),
            Card(animal: .owl),
            Card(animal: .owl),
        ])
    case .hard:
        base.append(contentsOf: [
            Card(animal: .monkey),
            Card(animal: .monkey),
            Card(animal: .owl),
            Card(animal: .owl),
            Card(animal: .rabbit),
            Card(animal: .rabbit),
            Card(animal: .turtle),
            Card(animal: .turtle),
        ])
    }
    return base.shuffled()
}
