import SwiftUI

struct CardView: View {
  var card: Card

  var body: some View {
    ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
      RoundedRectangle(cornerRadius: 16, style: .continuous)
        .fill(card.isFlipped && card.animal == .ducks ? Color.purple : Color.black)

      if card.isFlipped {
        CardFrontContentView(animal: card.animal)
          .padding()
      } else {
        CardBackContentView()
          .padding()
      }
    }
    .rotation3DEffect(
      card.isFlipped ?
        Angle(degrees: 180):
        Angle(degrees: 0), axis: (x: 0, y: 10, z: 0))
  }
}

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    CardView(card: Card(animal: .owl, isFlipped: false))
    CardView(card: Card(animal: .owl, isFlipped: true))
    CardView(card: Card(animal: .ducks, isFlipped: true))
  }
}
