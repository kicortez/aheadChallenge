//
//  aheadChallengeTests.swift
//  aheadChallengeTests
//
//  Created by Kim Cortez on 10/8/24.
//

import XCTest
@testable import aheadChallenge

final class DecodeTests: XCTestCase {

    // Tests decoding of sample activity response. Changes in API response can be checked against this test for backwards compatibility with the app
    func testActivityResponse() throws {
        let decoder = JSONDecoder()
        let resource = try XCTUnwrap(Bundle.main.url(forResource: "activity-response", withExtension: "json"))
        let data = try Data(contentsOf: resource)
        let activity = try decoder.decode(ActivityResponse.self, from: data)
        
        XCTAssertEqual(activity.id, "76O5QM3zhF4jfJFMkM7zlU1ysadasfsdgaEG2")
        XCTAssertEqual(activity.state, "REVIEWED")
        XCTAssertNil(activity.stateChangedAt)
        XCTAssertEqual(activity.title, "Retake control of your mind")
        XCTAssertEqual(activity.description, "When anger takes over, we often do things we later regret, like yelling or grumpily ruminating. Let’s learn to retake control of our minds - with science-proven techniques!")
        XCTAssertEqual(activity.duration, "3 min")
    }
    
}
