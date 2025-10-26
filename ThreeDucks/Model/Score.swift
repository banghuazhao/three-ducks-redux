struct Score: Comparable, Codable {
  let difficulty: DifficultyLevel
  let moves: Int

  // number of moves weighted by difficulty (fewer moves the better score)
  private var adjustedMoves: Int {
    switch difficulty {
    case .hard:
      return moves
    case .normal:
      return moves * 10
    case .easy:
      return moves * 100
    }
  }

  static func < (lhs: Score, rhs: Score) -> Bool {
    lhs.adjustedMoves < rhs.adjustedMoves
  }
}
