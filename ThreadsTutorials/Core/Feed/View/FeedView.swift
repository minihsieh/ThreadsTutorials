//
//  FeedView.swift
//  ThreadsTutorials
//
//  Created by MiniHsieh on 2024/5/15.
//

import SwiftUI

struct FeedView: View {
    @StateObject var viewModel = FeedViewModel()
    
    @StateObject private var previewImageState = PreviewImageState()
    @State private var isShowingImagePreview = false
    @State private var previewImageUrl: String = ""
    
    var body: some View {
        
        NavigationStack() {
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    
                    Image("threads-app-icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                    
                    ForEach(viewModel.threads) { thread in
//                        ThreadCell(thread: thread)
//                        ThreadCell(thread: thread, isShowingImagePreview: $isShowingImagePreview, previewImageUrl: $previewImageUrl)
                        ThreadCell(thread: thread, previewImageState: previewImageState)

                        
                    }
                }
            }
            .padding(.top, 1)
            .refreshable {
                Task { try await viewModel.fetchThreads()}
            }
            
        }
//        .sheet(isPresented: $isShowingImagePreview) {
//            if !previewImageUrl.isEmpty {
//                let _ = print("previewImageUrl:\(previewImageUrl)")
//                ImagePreviewView(previewImageUrl: previewImageUrl)
//            }
//        }
        .sheet(isPresented: $previewImageState.isShowingImagePreview, onDismiss: {
            previewImageState.previewImageUrl = ""
        }) {
            if !previewImageState.previewImageUrl.isEmpty {
                ImagePreviewView(previewImageUrl: previewImageState.previewImageUrl)
            }
        }

    }
}

struct CustomRefreshIndicatorView: UIViewRepresentable {
    let image: UIImage
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        view.addSubview(imageView)
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

#Preview {
    NavigationStack {
        FeedView()
    }
    
}
