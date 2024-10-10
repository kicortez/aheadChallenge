//
//  OptionView.swift
//  aheadChallenge
//
//  Created by Kim Cortez on 10/9/24.
//

import SwiftUI

class OptionViewModel: ObservableObject {
    private let option: ActivityOption
    
    @Published var isEnabled = false
    
    init(option: ActivityOption, isEnabled: Bool) {
        self.option = option
        self.isEnabled = isEnabled
    }
    
    var id: String { option.id }
    var text: String { (option.emoji ?? "") + " " + option.text }
}

struct OptionView: View {
    @ObservedObject var viewModel: OptionViewModel
    
    var body: some View {
        Toggle(isOn: $viewModel.isEnabled, label: {
            Text(viewModel.text)
        })
        .contentShape(Rectangle())
    }
}
