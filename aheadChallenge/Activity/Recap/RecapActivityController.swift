//
//  RecapActivityController.swift
//  aheadChallenge
//
//  Created by Kim Cortez on 10/11/24.
//

import Foundation

class RecapActivityController: ObservableObject {
    private let placeholder = "________"
    @Published var answerId: String?
    @Published var validated = false
    @Published var answers: [RecapOption] = []
    var isCorrect: Bool { answerId == activity.correctAnswer }
    
    var question: String {
        let question = activity.body
        let eyebrow = activity.eyebrow
        return question.replacingOccurrences(of: "%  \(eyebrow)  %", with: placeholder)
    }
    
    var answeredQuestion: String {
        guard let answer = answers.first(where: { $0.option.id == answerId }).map(\.option.text) else { return question }
        return question.replacingOccurrences(of: placeholder, with: answer)
    }
    
    let activity: RecapActivity
    
    init(activity: RecapActivity) {
        self.activity = activity
        answers = activity.answers.map { RecapOption(option: $0, isEnabled: false) }
    }
    
    func select(answer: String) {
        answerId = answer
        var updated = [RecapOption]()
        for answer in answers {
            updated.append(RecapOption(option: answer.option, isEnabled: answer.option.id == answerId))
        }
        answers = updated
    }
    
    func check(answer: String) {
        validated = true
    }
}
