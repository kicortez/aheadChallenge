//
//  MultipleChoiceActivityViewModel.swift
//  aheadChallenge
//
//  Created by Kim Cortez on 10/10/24.
//

import Foundation

struct MultipleChoiceActivityViewModel {
    private let activity: MultipleChoiceActivity
    
    var question: String {
        activity.question
    }
    
    var isMultipleChoiceAllowed: Bool {
        activity.multipleChoicesAllowed
    }
    
    init(actitvity: MultipleChoiceActivity) {
        self.activity = actitvity
    }
}
