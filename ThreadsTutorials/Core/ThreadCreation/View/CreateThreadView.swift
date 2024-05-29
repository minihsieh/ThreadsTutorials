//
//  CreateThreadView.swift
//  ThreadsTutorials
//
//  Created by MiniHsieh on 2024/5/15.
//

import SwiftUI
import PhotosUI

struct CreateThreadView: View {
    @StateObject var viewModel = CreateThreadViewModel()
    @State private var caption = ""
    @Environment(\.dismiss) var dismiss
    
    private var user: User? {
        UserService.shared.currentUser
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack(alignment: .top) {
                    CircularProfileImageView(user: user, size: .small)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text(user?.username ?? "")
                            .fontWeight(.semibold)
                        
                        TextField("What's News", text: $caption, axis: .vertical)
                        
                        if let image = viewModel.postImage {
                            image
                                .resizable()
                                .scaledToFit()
//                                .aspectRatio(contentMode: .fill)
//                                .frame(maxHeight: 300.0)
                                .cornerRadius(10)
                        }
                        
                        HStack(spacing: 16) {
                            
                            PhotosPicker(selection: $viewModel.selectedImage) {
                                Image(systemName: "photo.on.rectangle")
                                    .font(.system(size: 20))
                            }
                            
                            Button{
                                
                            } label: {
                                Image(systemName: "camera")
                                    .font(.system(size: 20))
                            }
                            
                            Button{
                                
                            } label: {
                                Image(systemName: "doc")
                                    .font(.system(size: 20))
                            }
                            
                            Button{
                                
                            } label: {
                                Image(systemName: "mic")
                                    .font(.system(size: 20))
                            }
                            
                            Button{
                                
                            } label: {
                                Image(systemName: "number")
                                    .font(.system(size: 20))
                            }
                            
                            Button{
                                
                            } label: {
                                Image(systemName: "text.alignleft")
                                    .font(.system(size: 20))
                            }
                        }
                        .foregroundColor(Color.gray)
                        
                        Text("Add a thread")
                            .foregroundColor(Color(.systemGray))
                            
                        
                    }
                    .font(.footnote)
                    
                    Spacer()
                    
                    if !caption.isEmpty {
                        Button{
                            caption = ""
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .foregroundColor(.gray)
                                .frame(width: 12, height: 12)
                            
                        }
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .navigationTitle("New Thread")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button ("Cancel") {
                        dismiss()
                    }
                    .font(.subheadline)
                    .foregroundColor(.black)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Post") {
                        Task {
                            try await viewModel.uploadThresd(caption: caption)
                            // Current Prifile那邊也要刷新
                            CurrentUserProfileViewModel.shared.shouldRefresh.toggle()
                            dismiss()
                        }
                    }
                    .opacity(caption.isEmpty ? 0.5:1.0)
                    .disabled(caption.isEmpty)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                }
            }
        }
    }
}

#Preview {
    CreateThreadView()
}
