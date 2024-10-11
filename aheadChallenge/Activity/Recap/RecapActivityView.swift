//
//  RecapActivityView.swift
//  aheadChallenge
//
//  Created by Kim Cortez on 10/9/24.
//

import SwiftUI

struct RecapActivityView: View {
    @ObservedObject private var controller: RecapActivityController
    var activityDone: (() -> Void)?
    
    init(activity: RecapActivity) {
        _controller = ObservedObject(wrappedValue: RecapActivityController(activity: activity))
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 0) {
                Label("Recap", image: "recap-star")
                    .font(.euclid(ofSize: 12, weight: .medium))
                    .padding(.bottom, 8)
                    .foregroundStyle(Color("FD8F55"))
                
                Text("Fill in the blank")
                    .font(.euclid(ofSize: 18, weight: .medium))
                    .padding(.bottom, 30)
                
                Text(controller.answeredQuestion)
                    .font(.euclid(ofSize: 22))
                    .foregroundStyle(Color("212121").opacity(0.6))
                    .padding(.bottom, 32)
                
                CollectionView(source: RecapActivityOptionSource(controller: controller), items: $controller.answers)
                    .disabled(controller.validated)
                
                Spacer()
                
                if let answer = controller.answerId {
                    Button {
                        withAnimation {
                            controller.check(answer: answer)
                        }
                    } label: {
                        Text("Check")
                    }
                    .buttonStyle(FilledButtonStyle())
                    .transition(.move(edge: .bottom))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(.horizontal)
            
            if controller.validated {
                AnswerResultView(isCorrect: controller.isCorrect)
                    .onContinue {
                        withAnimation {
                            controller.validated = false
                            
                            if controller.isCorrect {
                                activityDone?()
                            }
                        }
                    }
                    .transition(.move(edge: .bottom))
            }
        }
        .ignoresSafeArea()
    }
    
    func onActivityDone(_ perform: @escaping () -> Void) -> some View {
        var view = self
        view.activityDone = perform
        return view
    }
}

struct RecapActivityOptionSource: ViewSource {
    let controller: RecapActivityController
    
    func view(for content: RecapOption) -> some View {
        let viewModel = OptionViewModel(option: content.option, isEnabled: content.isEnabled)
        
        return OptionView(viewModel: viewModel).toggleStyle(ChipToggleStyle())
            .onTapGesture {
                withAnimation {
                    controller.select(answer: content.option.id)
                }
            }
    }
}

struct RecapOption: Hashable {
    let option: ActivityOption
    let isEnabled: Bool
}
