//
//  OptionView.swift
//  aheadChallenge
//
//  Created by Kim Cortez on 10/9/24.
//

import SwiftUI

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
