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
        VStack(spacing: 8) {
            VStack(spacing: 10) {
                RoundedRectangle(cornerRadius: 2)
                    .frame(height: 4)
                    .foregroundStyle(Color.accent)
                
                HStack {
                    Button("", systemImage: "chevron.backward") {
                        previousScreen()
                    }
                    .frame(width: 34, height: 34)
                    
                    Spacer()
                    
                    Button("", systemImage: "xmark") {
                        endActivity()
                    }
                    .frame(width: 34, height: 34)
                }
                .tint(Color("A2A2A2"))
            }
            .padding(.horizontal)
            
            screen
            
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity)
    }
    
    @ViewBuilder
    var screen: some View {
        if let screen = viewModel.currentScreen {
            switch screen {
            case .multipleChoice(let multipleChoiceActivity):
                MultipleChoiceActivityView()
                    .onActivityDone {
                        nextScreen()
                    }
            case .recap(let recapActivity):
                RecapActivityView()
                    .onActivityDone {
                        nextScreen()
                    }
            }
        }
        else {
            VStack(spacing: 32) {
                Text("Great work!")
                    .font(.euclid(ofSize: 22, weight: .bold))
                
                Text("You have completed this activity.")
                    .font(.euclid(ofSize: 16))
                
                Button {
                    endActivity()
                } label: {
                    Text("Finish")
                }
                .buttonStyle(FilledButtonStyle())
            }
            .padding()
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
}

struct OptionView: View {
    let option: ActivityOption
    
    var body: some View {
        Toggle(isOn: .constant(false), label: {
            HStack {
                if let emoji = option.emoji {
                    Text(emoji)
                        .font(.euclid(ofSize: 24))
                }
                
                Text(option.text)
            }
        })
    }
}

protocol ScreenNavigatable {
    func nextScreen()
    func previousScreen()
    func endActivity()
}
