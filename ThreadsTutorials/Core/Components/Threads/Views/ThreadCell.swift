//
//  ThreadCell.swift
//  ThreadsTutorials
//
//  Created by MiniHsieh on 2024/5/15.
//

import SwiftUI
import Firebase
import Kingfisher

struct ThreadCell: View {
    @ObservedObject var viewModel: ThreadCellViewModel
    @ObservedObject var previewImageState: PreviewImageState
    
    init(thread: Thread, previewImageState: PreviewImageState) {
        self.viewModel = ThreadCellViewModel(thread: thread)
        self.previewImageState = previewImageState
    }
    
    var body: some View {
        VStack {
            
            HStack(alignment: .top, spacing: 12) {
                VStack {
                    CircularProfileImageView(user: viewModel.thread.user, size: .small, type: .feed)
                    
                    if viewModel.thread.isReply {
                        Divider()
                    }
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(viewModel.thread.user?.username ?? "")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        
                        Text(viewModel.thread.timestamp.timestampString())
                            .font(.caption)
                            .foregroundColor(Color(.systemGray3))
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundColor(Color(.darkGray))
                        }
                    }
                    
                    Text(viewModel.thread.caption)
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                    
                    if let imageUrl = viewModel.thread.postImageUrl {
                        KFImage(URL(string: imageUrl))
                            .resizable()
                            .scaledToFill()
//                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(10)
                            .onTapGesture {
                                previewImageState.previewImageUrl = imageUrl
                                previewImageState.isShowingImagePreview.toggle()
                            }
                        
                    }
                    
                    HStack(spacing: 16) {
                        HStack(spacing: 5) {
                            Button{
                                viewModel.thread.didLike ?? false ? viewModel.unlikeThread() : viewModel.likeThread()
                            } label: {
                                Image(systemName: viewModel.thread.didLike ?? false ? "heart.fill" : "heart")
                                    .foregroundColor(viewModel.thread.didLike ?? false ? Color.red : Color.black)
                            }
                            
                            Text("\(viewModel.thread.like)")
                                .font(.footnote)
                                .foregroundColor(.black)
                        }
                        
                        HStack(spacing: 5) {
                            Button{
                                
                            } label: {
                                Image(systemName: "message")
                            }
                            
                            Text("2")
                                .font(.footnote)
                                .foregroundColor(.black)
                        }
                        
                        HStack(spacing: 5) {
                            Button{
                                
                            } label: {
                                Image(systemName: "repeat")
                            }
                            
                            Text("3")
                                .font(.footnote)
                                .foregroundColor(.black)
                        }
                        
                        Button{
                            
                        } label: {
                            Image(systemName: "paperplane")
                        }
                    }
                    .padding(.vertical, 8)
                    .foregroundColor(.black)
                }
                
            }
            
            Divider()
        }
        .padding()
        
    }
}

//#Preview {
//    ThreadCell(thread: Thread.mockThread)
//}
