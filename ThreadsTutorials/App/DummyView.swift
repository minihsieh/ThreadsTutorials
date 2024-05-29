//
//  DummyView.swift
//  ThreadsTutorials
//
//  Created by MiniHsieh on 2024/5/22.
//

import SwiftUI


struct DummyView: View {
    @State private var isRefreshing = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    if isRefreshing {
                        TopPullToRefreshImageView()
                    }
                    
                    // Your content goes here
                    ForEach(0..<10) { index in
                        Text("Item \(index)")
                            .padding(10)
                    }
                }
            }
            .refreshable {
                isRefreshing = true
                // Perform your refresh operation here
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    isRefreshing = false
                }
            }
        }
    }
}

#Preview {
    DummyView()
}


struct TopPullToRefreshImageView: View {
    @State private var isAnimating = false
    
    var body: some View {
        Image("threads-app-icon")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 40)
            .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
            .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
            .onAppear {
                self.isAnimating = true
            }
            .onDisappear {
                self.isAnimating = false
            }
    }
}
