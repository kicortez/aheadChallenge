//
//  ActivityContainerView.swift
//  aheadChallenge
//
//  Created by Kim Cortez on 10/8/24.
//

import SwiftUI

struct ActivityContainerView: View {
    var body: some View {
        Text("Hello, World!")
            .onAppear {
                let decoder = JSONDecoder()
                let data = try! Data(contentsOf: Bundle.main.url(forResource: "activity-response", withExtension: "json")!)
                let activity = try! decoder.decode(ActivityResponse.self, from: data)
                print(activity)
            }
    }
}

#Preview {
    ActivityContainerView()
}
