//
//  BeginActivityView.swift
//  aheadChallenge
//
//  Created by Kim Cortez on 10/9/24.
//

import SwiftUI

struct BeginActivityView: View {
    @ObservedObject var controller: ActivityController
    @State private var beginActivity = false
    
    var body: some View {
        content
            .fullScreenCover(isPresented: $beginActivity) {
                ActivityContainerView(viewModel: controller.getScreensViewModel())
            }
    }
    
    @ViewBuilder
    var content: some View {
        if let viewModel = controller.viewModel{
            VStack(spacing: 32) {
                Text(viewModel.title)
                    .font(.euclid(ofSize: 22, weight: .bold))
                
                Text(viewModel.description)
                    .font(.euclid(ofSize: 16))
                
                Button {
                    beginActivity = true
                } label: {
                    Text("Begin")
                }
                .buttonStyle(FilledButtonStyle())
            }
            .padding()
        }
        else {
            Label("No activities available", systemImage: "exclamationmark.circle")
        }
    }
}
