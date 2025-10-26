import Foundation
import AVFoundation

struct QuackPlayer {
  var quack: AVAudioPlayer?

  init() {
    guard let soundURL = Bundle.main.url(forResource: "duck", withExtension: "mp3") else {
      return
    }

    quack = try? AVAudioPlayer(contentsOf: soundURL)
    quack?.prepareToPlay()
  }

  func play() {
    quack?.play()
  }
}
