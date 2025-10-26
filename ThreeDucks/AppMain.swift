import SwiftUI

@main
struct AppMain: App {
    let store = ThreeDucksStore(
        initial: ThreeDucksState(),
        reducer: threeDucksReducer,
        middlewares: [
            gameLogicMiddleware,
            bestScoreMiddleware(using: ScorePersistence())
        ]
    )

    init() {
        store.dispatch(.launch)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
