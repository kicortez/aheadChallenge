//
//  OptionView.swift
//  aheadChallenge
//
//  Created by Kim Cortez on 10/9/24.
//

import SwiftUI

enum OptionViewType {
    case chip
    case text
}

class OptionViewModel: ObservableObject {
    private let option: ActivityOption
    let type: OptionViewType
    @Published var isEnabled = false
    
    init(option: ActivityOption, isEnabled: Bool, type: OptionViewType = .text) {
        self.option = option
        self.isEnabled = isEnabled
        self.type = type
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
