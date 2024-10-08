//
//  RecapActivity.swift
//  aheadChallenge
//
//  Created by Kim Cortez on 10/8/24.
//

import Foundation

struct RecapActivity: Decodable {
    var id: String
    let eyebrow: String
    let body: String
    let answers: [ActivityOption]
    let correctAnswer: String
}
