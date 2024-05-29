//
//  ThreadsTabView.swift
//  ThreadsTutorials
//
//  Created by MiniHsieh on 2024/5/14.
//

import SwiftUI

struct ThreadsTabView: View {
    @State private var currentTab = 0
    @State private var previousTab: Int = 0
    @State private var showCreateThreadView = false
    
    var body: some View {
        TabView(selection: $currentTab) {
            FeedView()
                .tabItem {
                    Image(systemName: currentTab == 0 ? "house.fill" : "house")
                }
                .onAppear { currentTab = 0 }
                .tag(0)
            
            ExploreView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
                .onAppear{ currentTab = 1 }
                .tag(1)
            
//            CreateThreadView()
            Text("")
                .tabItem {
                    Image(systemName: "plus")
                }
                .onAppear{ currentTab = 2 }
                .tag(2)
            
            
            ActivityView()
                .tabItem {
                    Image(systemName: currentTab == 3 ? "heart.fill" : "heart")
                        .environment(\.symbolVariants, .none)
                }
                .onAppear { currentTab = 3 }
                .tag(3)
            
            CurrentUserProfileView()
                .tabItem {
                    Image(systemName: currentTab == 4 ? "person.fill" : "person")
                        .environment(\.symbolVariants, .none)
                }
                .onAppear { currentTab = 4 }
                .tag(4)
        }
        .onChange(of: currentTab) { oldValue, newValue in
            previousTab = oldValue
            currentTab = newValue
            showCreateThreadView = (newValue == 2)
        }
        .sheet(isPresented: $showCreateThreadView, onDismiss: {
            currentTab = previousTab
        } , content: {
            CreateThreadView()
        })
        .tint(Color.primary)
    }
}

#Preview {
    ThreadsTabView()
}
