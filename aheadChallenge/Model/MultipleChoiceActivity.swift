//
//  MultipleChoiceActivity.swift
//  aheadChallenge
//
//  Created by Kim Cortez on 10/8/24.
//

import Foundation

struct MultipleChoiceActivity: Decodable {
    var id: String
    let question: String
    let multipleChoicesAllowed: Bool
    let choices: [ActivityOption]
}
