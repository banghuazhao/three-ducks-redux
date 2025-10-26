import SwiftUI

struct GameWinScreenView: View {
    @EnvironmentObject var store: ThreeDucksStore
    var body: some View {
        VStack(alignment: .center, spacing: 32) {
            Spacer()
            Text("Well Done!")
                .font(.title)
                .foregroundColor(.white)

            Image("ducks")
                .resizable()
                .aspectRatio(contentMode: .fit)

            Button("Go Again") {
                store.dispatch(.endGame)
            }
            .font(.headline)
            .foregroundColor(.purple)
            .padding()
            .background(Color.white)
            .cornerRadius(40)

            Spacer()
        }
        .background(Color.purple)
    }
}

struct GameWinScreenView_Previews: PreviewProvider {
    static var previews: some View {
        GameWinScreenView()
    }
}
