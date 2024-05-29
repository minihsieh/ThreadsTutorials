//
//  StickyButtonHeaders.swift
//  ThreadsTutorials
//
//  Created by MiniHsieh on 2024/5/23.
//

import SwiftUI

struct StickyButtonHeaders: View {
    @State private var selectedFilter: ActivityFilter = .all
    
    var body: some View {
        ZStack(alignment: .top) {
            GeometryReader { reader in
                Color.white
                    .frame(height: reader.safeAreaInsets.top, alignment: .top)
                    .ignoresSafeArea()
               
                
                
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(ActivityFilter.allCases) { filter in
                        if (selectedFilter == filter) {
                            Button(filter.title) {
                                selectedFilter = filter
                            }
                            .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                            .font(.headline)
                            .background(Color.black)
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                .stroke()
                                .fill(Color.black.opacity(0.5)))
                        } else {
                            Button(filter.title) {
                                selectedFilter = filter
                            }
                            .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                            .font(.headline)
                            .background(Color.white)
                            .foregroundColor(Color.black)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 1)
                                .fill(Color.black.opacity(0.5)))
                        }
                    }
                }
                .padding(.horizontal, 20)
                .background(Color.white)
            }
            
        }
        
        
    }
}

#Preview {
    StickyButtonHeaders()
}
