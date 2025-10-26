import SwiftUI

struct TitleScreenView: View {
    @EnvironmentObject var store: ThreeDucksStore

    var body: some View {
        VStack(alignment: .center, spacing: 32) {
            Spacer()

            Image("title")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Button("New Game") {
                store.dispatch(.startGame)
            }
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .background(Color.purple)
            .cornerRadius(40)
          
          if let score = store.state.previousBestScore {
            VStack(alignment: .center) {
              Text("Best Score")
                .font(.headline)

              Text("\(score.moves) moves, difficulty: \(score.difficulty.rawValue)")
                .font(.subheadline)
            }
            .foregroundColor(.purple)
          }

            Spacer()

            HStack(alignment: .center, spacing: 16) {
                ForEach(DifficultyLevel.allCases) { level in
                    Button {
                        store.dispatch(.setDifficulty(level))
                    } label: {
                        Label(
                            level.rawValue,
                            systemImage: store.state.gameDifficulty == level ? "checkmark.rectangle.portrait.fill" :
                                "rectangle.portrait"
                        )
                    }
                    .foregroundColor(level.color)
                    .padding()
                }
            }
        }
    }
}

struct TitleScreenView_Previews: PreviewProvider {
    static var previews: some View {
        TitleScreenView()
            .environmentObject(ThreeDucksStore(initial: ThreeDucksState(), reducer: threeDucksReducer))
    }
}
