//
//  aheadChallengeApp.swift
//  aheadChallenge
//
//  Created by Kim Cortez on 10/8/24.
//

import SwiftUI

@main
struct aheadChallengeApp: App {
    @StateObject var controller = ActivityController()
    
    var body: some Scene {
        WindowGroup {
            BeginActivityView(controller: controller)
                .task {
                    controller.getActivity()
                }
        }
    }
}
