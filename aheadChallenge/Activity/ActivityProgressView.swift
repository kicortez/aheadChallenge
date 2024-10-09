//
//  ActivityProgressView.swift
//  aheadChallenge
//
//  Created by Kim Cortez on 10/9/24.
//

import SwiftUI

struct ActivityProgressView: View {
    @EnvironmentObject var viewModel: ActivityScreensViewModel
    var count: CGFloat { CGFloat(viewModel.screens.count) }
    
    var body: some View {
        if count > 0 {
            GeometryReader { proxy in
                let widthPerPage = proxy.size.width / count
                
                RoundedRectangle(cornerRadius: 2)
                    .frame(height: 4)
                    .foregroundStyle(Color.accent)
                    .frame(width: widthPerPage * CGFloat(viewModel.currentPage + 1), alignment: .leading)
                    .frame(width: proxy.size.width, alignment: .leading)
                    .background(Color.black.opacity(0.08))
                    .clipShape(RoundedRectangle(cornerRadius: 2))
            }
            .frame(height: 4)
        }
    }
}
