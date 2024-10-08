//
//  ActivityScreen.swift
//  aheadChallenge
//
//  Created by Kim Cortez on 10/8/24.
//

import Foundation

enum ActivityScreenType: String, Decodable {
    case multipleChoice = "multipleChoiceModuleScreen"
    case recap = "recapModuleScreen"
}

enum ActivityScreen: Decodable {
    case multipleChoice(MultipleChoiceActivity)
    case recap(RecapActivity)
    
    enum CodingKeys: CodingKey {
        case type
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let screen = try decoder.singleValueContainer()
        let type = try container.decode(ActivityScreenType.self, forKey: .type)
        
        switch type {
        case .multipleChoice:
            self = .multipleChoice(try screen.decode(MultipleChoiceActivity.self))
        case .recap:
            self = .recap(try screen.decode(RecapActivity.self))
        }
    }
}
