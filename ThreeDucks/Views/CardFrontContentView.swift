import SwiftUI

struct CardFrontContentView: View {
  var animal: Animal

  var body: some View {
    animal.image
      .resizable()
      .aspectRatio(contentMode: .fit)
  }
}

struct CardFrontContentView_Previews: PreviewProvider {
  static var previews: some View {
    CardFrontContentView(animal: .monkey)
  }
}
