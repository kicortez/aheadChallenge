//
//  MultipleChoiceActivityView.swift
//  aheadChallenge
//
//  Created by Kim Cortez on 10/9/24.
//

import SwiftUI

struct MultipleChoiceActivityView: View {
    var activityDone: (() -> Void)?
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Were you able to use any of them when angry?")
                .font(.euclid(ofSize: 22))
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text("Select all that apply")
                .font(.euclid(ofSize: 16))
            
            Spacer()
            
            ForEach(1...3, id: \.self) { option in
                OptionView(option: ActivityOption(id: "", text: "Option \(option)", emoji: nil))
                    .toggleStyle(BorderToggleStyle())
            }
            
            Button {
                activityDone?()
            } label: {
                Text("Check")
            }
            .buttonStyle(FilledButtonStyle())
        }
    }
    
    func onActivityDone(_ perform: @escaping () -> Void) -> some View {
        var view = self
        view.activityDone = perform
        return view
    }
}
