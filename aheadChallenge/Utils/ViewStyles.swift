//
//  FilledButtonStyle.swift
//  aheadChallenge
//
//  Created by Kim Cortez on 10/9/24.
//

import SwiftUI

struct FilledButtonStyle: ButtonStyle {
    let shadowEnabled: Bool
    
    init(shadowEnabled: Bool = false) {
        self.shadowEnabled = shadowEnabled
    }
    
    func makeBody(configuration: Configuration) -> some View {
        Button(configuration: configuration, shadowEnabled: shadowEnabled)
    }
    
    private struct Button: View {
        @Environment(\.isEnabled) var isEnabled
        let configuration: Configuration
        let shadowEnabled: Bool
        
        var body: some View {
            configuration.label
                .font(.euclid(ofSize: 16, weight: .bold))
                .foregroundStyle(Color.white)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 54)
                .background(isEnabled ? Color.accent : Color("DDD5FB"))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(color: .accent.opacity(shadowEnabled ? 0.3 : 0), radius: 16, x: 0, y: 5)
        }
    }
}

struct BorderToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.euclid(ofSize: 14, weight: .bold))
            .foregroundStyle(Color.black)
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: configuration.isOn ? 2 : 1)
                    .foregroundStyle(configuration.isOn ? Color.accent : Color.black.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
    }
}

struct ChipToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.euclid(ofSize: 16, weight: .bold))
            .foregroundStyle(Color.black)
            .padding(.horizontal, 16)
            .padding(.vertical, 9)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .fill()
                    .foregroundStyle(Color.white)
            }
            .shadow(color: .black.opacity(configuration.isOn ? 0 : 0.06), radius: 8, x: 0, y: 2)
            .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(style: StrokeStyle(lineWidth: 1))
                        .background(Color.black.opacity(configuration.isOn ? 0.06 : 0))
                        .background(configuration.isOn ? Color.white : Color.clear)
                        .foregroundStyle(Color.black.opacity(0.06))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
            }
    }
}
