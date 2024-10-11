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

class OptionViewModel: ObservableObject, Hashable {
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
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(option)
        hasher.combine(isEnabled)
    }
    
    static func == (lhs: OptionViewModel, rhs: OptionViewModel) -> Bool {
        lhs.option == rhs.option && lhs.isEnabled == rhs.isEnabled
    }
}

struct OptionView: View, DataConfigurable {
    @ObservedObject var viewModel: OptionViewModel
    
    var body: some View {
        Toggle(isOn: $viewModel.isEnabled, label: {
            Text(viewModel.text)
        })
        .contentShape(Rectangle())
    }
    
    static func configure(with data: OptionViewModel) -> some View {
        switch data.type {
        case .chip:
            return OptionView(viewModel: data).toggleStyle(ChipToggleStyle())
        case .text:
            return OptionView(viewModel: data).toggleStyle(ChipToggleStyle())
        }
    }
}
