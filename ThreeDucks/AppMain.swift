import SwiftUI

@main
struct AppMain: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(
                    ThreeDucksStore(
                        initial: ThreeDucksState(),
                        reducer: threeDucksReducer,
                        middlewares: [gameLogic]
                    )
                )
        }
    }
}
