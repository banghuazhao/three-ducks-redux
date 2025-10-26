import Foundation

struct ScorePersistence {
  let scoreKey = "bestScore"

  func load() -> Score? {
    let decoder = PropertyListDecoder()
    guard
      let scoreData = UserDefaults.standard.value(forKey: scoreKey) as? Data,
      let score = try? decoder.decode(Score.self, from: scoreData)
    else {
      return nil
    }
    return score
  }

  func save(_ score: Score) {
    let encoder = PropertyListEncoder()
    guard let scoreData = try? encoder.encode(score) else {
      return
    }

    UserDefaults.standard.setValue(scoreData, forKey: scoreKey)
  }
}
