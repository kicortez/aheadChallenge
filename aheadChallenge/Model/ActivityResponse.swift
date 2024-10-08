//
//  ActivityResponse.swift
//  aheadChallenge
//
//  Created by Kim Cortez on 10/8/24.
//

import Foundation

struct ActivityResponse: Decodable {
    let id: String
    let state: String
    let stateChangedAt: Date?
    let title: String
    let description: String
    let duration: String
    let activity: Activity
}

struct Activity: Decodable {
    let screens: [ActivityScreen]
}
