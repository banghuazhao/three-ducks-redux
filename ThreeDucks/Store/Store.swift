import Combine
import Foundation

typealias ThreeDucksStore = Store<ThreeDucksState, ThreeDucksAction>

class Store<State, Action>: ObservableObject {
    @Published private(set) var state: State

    private let reducer: Reducer<State, Action>

    private let queue = DispatchQueue(
        label: "com.raywenderlich.ThreeDucks.store",
        qos: .userInitiated)

    private let middlewares: [Middleware<State, Action>]

    private var subscriptions: Set<AnyCancellable> = []

    init(
        initial: State,
        reducer: @escaping Reducer<State, Action>,
        middlewares: [Middleware<State, Action>] = []
    ) {
        state = initial
        self.reducer = reducer
        self.middlewares = middlewares
    }

    func dispatch(_ action: Action) {
        queue.sync {
            dispatch(state, action)
        }
    }

    private func dispatch(_ currentState: State, _ action: Action) {
        let newState = reducer(currentState, action)
        middlewares.forEach { middleware in
            let publisher = middleware(newState, action)
            publisher
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: dispatch)
                .store(in: &subscriptions)
        }
        state = newState
    }
}
