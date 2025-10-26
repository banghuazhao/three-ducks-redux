import Combine

typealias Middleware<State, Action> =
    (State, Action) -> AnyPublisher<Action, Never>
