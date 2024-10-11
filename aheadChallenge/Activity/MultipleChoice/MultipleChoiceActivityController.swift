//
//  MultipleChoiceActivityController.swift
//  aheadChallenge
//
//  Created by Kim Cortez on 10/10/24.
//

import Foundation

class MultipleChoiceActivityController: ObservableObject {
    private let activity: MultipleChoiceActivity
    
    @Published var selections: Set<String>
    
    init(activity: MultipleChoiceActivity) {
        self.activity = activity
        self.selections = Set<String>()
    }
    
    var needsSelection: Bool { selections.isEmpty }
    
    func select(option: OptionViewModel) {
        guard selections.insert(option.id).inserted == false else { return }
        selections.remove(option.id)
    }
    
    var choices: [OptionViewModel] {
        activity.choices.map { OptionViewModel(option: $0, isEnabled: selections.contains($0.id)) }
    }
}
