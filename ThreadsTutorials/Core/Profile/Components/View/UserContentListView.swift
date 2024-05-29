//
//  UserContentListView.swift
//  ThreadsTutorials
//
//  Created by MiniHsieh on 2024/5/17.
//

import SwiftUI

struct UserContentListView: View {
    
    @StateObject var viewModel: UserContentListViewModel
//    @ObservedObject var viewModel: CurrentUserProfileViewModel
    @State private var selectedFilter: ProfileThreadFilter = .threads
    @Namespace private var animation
    @StateObject private var previewImageState = PreviewImageState()
    
    private var filterBarWidth: CGFloat {
        let count = CGFloat(ProfileThreadFilter.allCases.count)
        return UIScreen.main.bounds.width/count - 16
    }

    init (user: User) {
        self._viewModel = StateObject(wrappedValue: UserContentListViewModel(user: user))
    }
        
    var body: some View {
        VStack {
            HStack {
                ForEach(ProfileThreadFilter.allCases) { filter in
                    VStack {
                        // 項目名稱
                        Text(filter.title)
                            .font(.subheadline)
                            .fontWeight(selectedFilter == filter ? .semibold : .regular)
                        
                        // 底線設定
                        if selectedFilter == filter {
                            Rectangle()
                                .foregroundColor(.black)
                                .frame(width: filterBarWidth, height: 1)
                                .matchedGeometryEffect(id: "item", in: animation)
                            
                        } else {
                            Rectangle()
                                .foregroundColor(.black)
                                .frame(width: filterBarWidth, height: 0)
//                                .matchedGeometryEffect(id: "item", in: animation)
                        }
                    }
                    .onTapGesture {
                        withAnimation(.default) {
                            selectedFilter = filter
                        }
                    }
                }
            }
            
            LazyVStack(spacing: 0) {
                ForEach(viewModel.threads(forFilter: self.selectedFilter)) { thread in
                    ThreadCell(thread: thread, previewImageState: previewImageState)
                }
            }
        }
        .padding(.vertical, 8)
        .sheet(isPresented: $previewImageState.isShowingImagePreview, onDismiss: {
            previewImageState.previewImageUrl = ""
        }) {
            if !previewImageState.previewImageUrl.isEmpty {
                ImagePreviewView(previewImageUrl: previewImageState.previewImageUrl)
            }
        }
        
    }
}

#Preview {
    UserContentListView(user: User.mockUser)
}
