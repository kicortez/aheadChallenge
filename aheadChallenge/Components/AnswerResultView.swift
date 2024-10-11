//
//  AnswerResultView.swift
//  aheadChallenge
//
//  Created by Kim Cortez on 10/9/24.
//

import SwiftUI

struct AnswerResultView: View {
    let isCorrect: Bool
    var continueTapped: (() -> Void)?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Rectangle()
                .frame(height: 2)
                .foregroundStyle(isCorrect ? Color.green : Color.red)
            
            VStack(alignment: .leading, spacing: 24) {
                Text(isCorrect ? "You're correct" : "Try again")
                
                Button {
                    continueTapped?()
                } label: {
                    Text("Continue")
                }
                .buttonStyle(FilledButtonStyle(shadowEnabled: true))
            }
            .padding(.horizontal, 24)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(Color.white)
    }
    
    func onContinue(_ perform: @escaping () -> Void) -> AnswerResultView {
        var view = self
        view.continueTapped = perform
        return view
    }
}
