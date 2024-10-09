//
//  MultipleChoiceActivityView.swift
//  aheadChallenge
//
//  Created by Kim Cortez on 10/9/24.
//

import SwiftUI

struct MultipleChoiceActivityView: View {
    let actitvity: MultipleChoiceActivity
    var activityDone: (() -> Void)?
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(actitvity.question)
                .font(.euclid(ofSize: 22))
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            if actitvity.multipleChoicesAllowed {
                Text("Select all that apply")
                    .font(.euclid(ofSize: 16))
            }
            
            Spacer()
            
            ForEach(actitvity.choices, id: \.self) { option in
                OptionView(option: option)
                    .toggleStyle(BorderToggleStyle())
                    .onTapGesture {
                        activityDone?()
                    }
            }
            
            if actitvity.multipleChoicesAllowed {
                Button {
                    activityDone?()
                } label: {
                    Text("Continue")
                }
                .buttonStyle(FilledButtonStyle())
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
