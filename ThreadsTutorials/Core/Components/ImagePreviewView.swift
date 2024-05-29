//
//  ImagePreviewView.swift
//  ThreadsTutorials
//
//  Created by MiniHsieh on 2024/5/24.
//

import SwiftUI
import Kingfisher

struct ImagePreviewView: View {
    
    let previewImageUrl: String
    
    @Environment(\.presentationMode) var presentationMode
    @State private var isPresented = false
    
    @State private var zoomScale: CGFloat = 1
    @State private var previousZoomScale: CGFloat = 1
    private let minZoomScale: CGFloat = 1
    private let maxZoomScale: CGFloat = 10
    
    
    var body: some View {
        photoView
    }
    
    var photoView: some View {
        GeometryReader { proxy in
            // Wrap the image with a scroll view.
            // Doing so would limit the photo scroll within the
            // bounds of the scroll view, but will still have
            // the same functionality of adding pan gesture support.
            ZStack(alignment: .top) {
                ScrollView(
                    [.vertical, .horizontal],
                    showsIndicators: false
                ) {
                    if isPresented {
                        KFImage(URL(string: previewImageUrl))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .onTapGesture(count: 2, perform: onImageDoubleTapped)
                            .gesture(zoomGesture)
                            .frame(width: proxy.size.width * max(minZoomScale, zoomScale))
                            .frame(maxHeight: .infinity)
                    }
                }
                .background(Color.black)
                .onAppear {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        isPresented = true
                    }
                }
                .onDisappear {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        isPresented = false
                    }
                }
                
                // 左上按鈕
                Button {
                    // 添加取消操作
                    print("previewImageUrl:\(previewImageUrl)")
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                        .opacity(0.3)
                }
                .position(x: 50, y: 50)
                    
                // 右上按鈕
                Button {
                    // 添加分享操作
                } label: {
                    Image(systemName: "ellipsis.circle.fill")
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                        .opacity(0.3)
                }
                .position(x: proxy.size.width - 50, y: 50)
            }
            
        }
    }
    
    
    var zoomGesture: some Gesture {
        MagnificationGesture()
            .onChanged(onZoomGestureStarted)
            .onEnded(onZoomGestureEnded)
    }
    
    
    /// Resets the zoom scale back to 1 – the photo scale at 1x zoom
    func resetImageState() {
        withAnimation(.interactiveSpring()) {
            zoomScale = 1
        }
    }
    
    /// On double tap
    func onImageDoubleTapped() {
        /// Zoom the photo to 5x scale if the photo isn't zoomed in
        if zoomScale == 1 {
            withAnimation(.spring()) {
                zoomScale = maxZoomScale
            }
        } else {
            /// Otherwise, reset the photo zoom to 1x
            resetImageState()
        }
    }
    
    func onZoomGestureStarted(value: MagnificationGesture.Value) {
        withAnimation(.easeIn(duration: 0.1)) {
            let delta = value / previousZoomScale
            previousZoomScale = value
            let zoomDelta = zoomScale * delta
            var minMaxScale = max(minZoomScale, zoomDelta)
            minMaxScale = min(maxZoomScale, minMaxScale)
            zoomScale = minMaxScale
        }
            
    }
    
    func onZoomGestureEnded(value: MagnificationGesture.Value) {
        previousZoomScale = 1
        if zoomScale <= minZoomScale {
            resetImageState()
        } else if zoomScale > maxZoomScale {
            zoomScale = maxZoomScale
        }
    }
}

#Preview {
    ImagePreviewView(previewImageUrl: "https://firebasestorage.googleapis.com:443/v0/b/threadstutorials-fff1b.appspot.com/o/profile_images%2FEF57710E-45C9-42D0-B6CB-EB474E8D294D?alt=media&token=550b7a70-0485-4df1-80cb-03563e9065d3")
}
