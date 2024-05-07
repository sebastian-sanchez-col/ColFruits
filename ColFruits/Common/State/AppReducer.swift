//
//  AppReducer.swift
//  ColFruits
//
//  Created by Juan Sanchez on 7/05/24.
//

typealias Reducer<State, Action> = (State, Action) -> State

let AppReducer: Reducer<AppState, AppActions> = { state, action in
    var mutatingState = state
    
    switch action {
    case .setSelected(let newSelectedFruit):
        mutatingState.selectedFruit = newSelectedFruit
    case .setFruits(let newFruits):
        mutatingState.fruits = newFruits
    }
    return mutatingState
}
