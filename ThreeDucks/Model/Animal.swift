import SwiftUI

enum Animal: String {
  case bat, bear, elephant, horse, monkey, owl, pelican, rabbit, turtle
  case ducks

  var image: Image {
    Image(rawValue)
  }
}
