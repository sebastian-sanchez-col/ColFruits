//
//  Store.swift
//  ColFruits
//
//  Created by Juan Sanchez on 7/05/24.
//

import Foundation
import Combine

typealias AppStore = Store<AppState, AppActions>

class Store<State, Action>: ObservableObject {
  @Published private(set) var state: State
  private let reducer: Reducer<State, Action>
  private var subscriptions: Set<AnyCancellable> = []

  init(
    initial: State,
    reducer: @escaping Reducer<State, Action>
  ) {
    self.state = initial
    self.reducer = reducer
  }

  func dispatch(_ action: Action) {
      DispatchQueue.main.async { [self] in
          self.dispatch(self.state, action)
      }
  }

  private func dispatch(_ currentState: State, _ action: Action) {
    let newState = reducer(currentState, action)
    state = newState
  }
}
