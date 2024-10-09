//
//  RecapActivityView.swift
//  aheadChallenge
//
//  Created by Kim Cortez on 10/9/24.
//

import SwiftUI

struct RecapActivityView: View {
    var activityDone: (() -> Void)?
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 0) {
                Text("Recap")
                    .font(.euclid(ofSize: 12, weight: .medium))
                    .padding(.bottom, 8)
                
                Text("Fill in the blank")
                    .font(.euclid(ofSize: 18, weight: .medium))
                    .padding(.bottom, 30)
                
                Text("Our brains make us misbehave on ________ – without us fully realizing what we’re actually doing.")
                    .font(.euclid(ofSize: 22))
                    .foregroundStyle(Color("212121").opacity(0.6))
                    .padding(.bottom, 32)
                
                ForEach(1...3, id: \.self) { option in
                    OptionView(option: ActivityOption(id: "", text: "Option \(option)", emoji: nil))
                        .toggleStyle(ChipToggleStyle())
                }
                
                Spacer()
                
                Button {
                    activityDone?()
                } label: {
                    Text("Check")
                }
                .buttonStyle(FilledButtonStyle())
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(.horizontal)
            
            // TODO: Handle result
//            AnswerResultView()
        }
    }
    
    func onActivityDone(_ perform: @escaping () -> Void) -> some View {
        var view = self
        view.activityDone = perform
        return view
    }
}
