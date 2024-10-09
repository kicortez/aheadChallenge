//
//  Font.swift
//  aheadChallenge
//
//  Created by Kim Cortez on 10/9/24.
//

import SwiftUI

extension Font {
    static func euclid(ofSize size: CGFloat = UIFont.labelFontSize, weight: Font.Weight = .regular) -> Font {
        return Font.custom("Euclid Circular B", size: size).weight(weight)
    }
}
