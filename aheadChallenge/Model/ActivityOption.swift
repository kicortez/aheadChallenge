//
//  ActivityOption.swift
//  aheadChallenge
//
//  Created by Kim Cortez on 10/8/24.
//

import Foundation

struct ActivityOption: Decodable, Hashable {
    let id: String
    let text: String
    let emoji: String?
}
