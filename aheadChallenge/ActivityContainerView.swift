//
//  ActivityContainerView.swift
//  aheadChallenge
//
//  Created by Kim Cortez on 10/8/24.
//

import SwiftUI

struct ActivityContainerView: View {
    var body: some View {
//        RecapActivityView()
        MultipleChoiceActivityView()
    }
}

struct MultipleChoiceActivityView: View {
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
            
            Button(action: {}, label: {
                Text("Check")
            })
            .buttonStyle(FilledButtonStyle())
        }
    }
}

struct RecapActivityView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Recap")
                .font(.euclid(ofSize: 12, weight: .medium))
            
            Text("Fill in the blank")
                .font(.euclid(ofSize: 18, weight: .medium))
            
            Text("Our brains make us misbehave on ________ – without us fully realizing what we’re actually doing.")
                .font(.euclid(ofSize: 22))
                .foregroundStyle(Color("212121").opacity(0.6))
             
            ForEach(1...3, id: \.self) { option in
                OptionView(option: ActivityOption(id: "", text: "Option \(option)", emoji: nil))
                    .toggleStyle(ChipToggleStyle())
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Text("Check")
            }
            .buttonStyle(FilledButtonStyle())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
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

#Preview {
    ActivityContainerView()
}
