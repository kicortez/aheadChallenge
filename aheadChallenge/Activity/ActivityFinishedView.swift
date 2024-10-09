//
//  ActivityFinishedView.swift
//  aheadChallenge
//
//  Created by Kim Cortez on 10/9/24.
//

import SwiftUI

struct ActivityFinishedView: View {
    let navigator: ScreenNavigatable
    
    var body: some View {
        VStack(spacing: 32) {
            Text("Great work!")
                .font(.euclid(ofSize: 22, weight: .bold))
            
            Text("You have completed this activity.")
                .font(.euclid(ofSize: 16))
            
            Button {
                navigator.endActivity()
            } label: {
                Text("Finish")
            }
            .buttonStyle(FilledButtonStyle())
        }
        .padding()
    }
}
