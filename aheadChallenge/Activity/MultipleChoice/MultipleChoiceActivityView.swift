//
//  MultipleChoiceActivityView.swift
//  aheadChallenge
//
//  Created by Kim Cortez on 10/9/24.
//

import SwiftUI

struct MultipleChoiceActivityView: View {
    @ObservedObject private var controller: MultipleChoiceActivityController
    private var viewModel: MultipleChoiceActivityViewModel
    var activityDone: (() -> Void)?
    
    init(activity: MultipleChoiceActivity) {
        _controller = ObservedObject(wrappedValue: MultipleChoiceActivityController(activity: activity))
        viewModel = MultipleChoiceActivityViewModel(actitvity: activity)
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(viewModel.question)
                .font(.euclid(ofSize: 22))
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            if viewModel.isMultipleChoiceAllowed {
                Text("Select all that apply")
                    .font(.euclid(ofSize: 16))
            }
            
            Spacer()
            
            ForEach(controller.choices, id: \.id) { option in
                OptionView(viewModel: option)
                    .toggleStyle(BorderToggleStyle())
                    .onTapGesture {
                        controller.select(option: option)
                        if !viewModel.isMultipleChoiceAllowed {
                            activityDone?()
                        }
                    }
            }
            
            if viewModel.isMultipleChoiceAllowed {
                Button {
                    activityDone?()
                } label: {
                    Text("Continue")
                }
                .buttonStyle(FilledButtonStyle())
                .disabled(controller.needsSelection)
            }
        }
        .padding(.horizontal)
    }
    
    func onActivityDone(_ perform: @escaping () -> Void) -> some View {
        var view = self
        view.activityDone = perform
        return view
    }
}
