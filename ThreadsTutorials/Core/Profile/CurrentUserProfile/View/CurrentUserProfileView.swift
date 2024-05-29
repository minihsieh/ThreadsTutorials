//
//  CurrentUserProfileView.swift
//  ThreadsTutorials
//
//  Created by MiniHsieh on 2024/5/17.
//

import SwiftUI

struct CurrentUserProfileView: View {
    
    @StateObject var viewModel = CurrentUserProfileViewModel()
    @State private var showEditProfile = false
    @State private var isSharing: Bool = false
    
    private var currentUser: User? {
        return viewModel.currentUser
    }
    
    private var profileWidth: CGFloat {
        return UIScreen.main.bounds.width/2 - 16
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    ProfileHeaderView(user: currentUser)
                    
                    HStack(alignment: .center) {
                        Button {
                            showEditProfile.toggle()
                        } label: {
                            Text("Edit Profile")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .frame(width: profileWidth, height: 32)
                                .foregroundColor(.black)
                                .background(.white)
                                .cornerRadius(8)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color(.systemGray4), lineWidth: 1)
                                }
                            
                        }
                        
                        Button {
                            isSharing.toggle()
                            if let shareLink = URL(string: "https://www.threads.net/@oiomini") {
                                ShareView.shared.activityItems = [shareLink]
                                ShareView.shared.open()
                                
                            }
                            
                        } label: {
                            Text("Share Profile")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .frame(width: profileWidth, height: 32)
                                .foregroundColor(.black)
                                .background(.white)
                                .cornerRadius(8)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color(.systemGray4), lineWidth: 1)
                                }
                            
                        }
//                        .sheet(isPresented: $isSharing) {
//                            if let shareLink = URL(string: "https://www.threads.net/@oiomini") {
////                                ShareView(activityItems: [shareLink])
////                                    .presentationDetents([.medium, .large])
//
//                            }
//                        }
                    }
                    
                    // user content list view
                    if let user = currentUser {
                        UserContentListView(user: user)
                    }
                    
                }
            }
            .sheet(isPresented: $showEditProfile, content: {
                if let user = currentUser {
                    EditProfileView(user: user)
                }
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        
                    } label: {
                        Image(systemName: "globe")
                            .foregroundColor(.black)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "camera.metering.partial")
                            .foregroundColor(.black)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        AuthService.shared.signOut()
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(.black)
                    }
                }
            }
            .padding(.horizontal)
            .refreshable {
                CurrentUserProfileViewModel.shared.shouldRefresh.toggle()
            }
            
        }
        
    }
}

#Preview {
    CurrentUserProfileView()
}
