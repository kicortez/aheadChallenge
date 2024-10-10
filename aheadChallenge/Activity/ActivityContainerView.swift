//
//  ActivityContainerView.swift
//  aheadChallenge
//
//  Created by Kim Cortez on 10/8/24.
//

import SwiftUI

struct ActivityContainerView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ActivityScreensViewModel
    
    var body: some View {
        Group {
            if !viewModel.screens.isEmpty && !viewModel.isFinished {
                VStack(spacing: 8) {
                    VStack(spacing: 10) {
                        ActivityProgressView()
                        
                        ActivityHeaderNavigationView(navigator: self)
                    }
                    .padding(.horizontal)
                    
                    TabView(selection: $viewModel.currentPage ) {
                        ForEach(Array(viewModel.screens.enumerated()), id: \.offset) { index, screen in
                            ActivityScreen(for: screen)
                                .tag(index)
                        }
                    }
                    
                    Spacer()
                }
                .frame(minWidth: 0, maxWidth: .infinity)
            }
            else {
                ActivityFinishedView(navigator: self)
            }
        }
        .environmentObject(viewModel)
    }
    
    @ViewBuilder
    func ActivityScreen(for screen: ActivityScreen) -> some View {
        switch screen {
        case .multipleChoice(let activity):
            MultipleChoiceActivityView(activity: activity)
                .onActivityDone {
                    nextScreen()
                }
        case .recap(let activity):
            RecapActivityView(activity: activity)
                .onActivityDone {
                    nextScreen()
                }
        }
    }
}

extension ActivityContainerView: ScreenNavigatable {
    func nextScreen() {
        viewModel.nextScreen()
    }
    
    func previousScreen() {
        viewModel.previousScreen()
    }
    
    func endActivity() {
        dismiss()
    }
    
    var canGoBack: Bool { viewModel.canGoBack }
}

protocol ScreenNavigatable {
    func nextScreen()
    func previousScreen()
    func endActivity()
    var canGoBack: Bool { get }
}
