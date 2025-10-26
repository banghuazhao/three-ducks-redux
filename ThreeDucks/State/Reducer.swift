typealias Reducer<State, Action> = (State, Action) -> State

let threeDucksReducer: Reducer<ThreeDucksState, ThreeDucksAction>
    = { state, action in
        var mutableState = state
        switch action {
        case .startGame:
            mutableState.gameState = .started
            mutableState.cards = [
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
            ].shuffled()
            mutableState.selectedCards = []
            mutableState.moves = 0
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
        case .winGame:
            mutableState.gameState = .won
        case let .setFlipLocked(isLocked):
            mutableState.isFlipLocked = isLocked
        }
        return mutableState
    }
