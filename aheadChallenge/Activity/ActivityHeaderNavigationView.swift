//
//  ActivityHeaderNavigationView.swift
//  aheadChallenge
//
//  Created by Kim Cortez on 10/9/24.
//

import SwiftUI

struct ActivityHeaderNavigationView: View {
    let navigator: ScreenNavigatable
    
    var body: some View {
        HStack {
            if navigator.canGoBack {
                Button("", systemImage: "chevron.backward") {
                    navigator.previousScreen()
                }
                .frame(width: 34, height: 34)
            }
            
            Spacer()
            
            Button("", systemImage: "xmark") {
                navigator.endActivity()
            }
            .frame(width: 34, height: 34)
        }
        .tint(Color("A2A2A2"))
    }
}
