//
//  ThreadsTextFieldModifier.swift
//  ThreadsTutorials
//
//  Created by MiniHsieh on 2024/5/14.
//

import SwiftUI

struct ThreadsTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .padding(12)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal, 24)
    }
}
