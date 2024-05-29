//
//  ProfileView.swift
//  ThreadsTutorials
//
//  Created by MiniHsieh on 2024/5/15.
//

import SwiftUI

struct ProfileView: View {
    let user: User
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                ProfileHeaderView(user: user)
                
                Button {
                    
                } label: {
                    Text("Follow")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(width: 352, height: 32)
                        .foregroundColor(.white)
                        .background(.black)
                        .cornerRadius(8)
                }
                
                // user content list view
                UserContentListView(user: user)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                HStack(spacing: 10) {
                    Button {
                        
                    } label: {
                        Image(systemName: "camera.metering.partial")
                            .foregroundColor(.black)
                            .frame(width: 20, height: 20)
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "bell")
                            .foregroundColor(.black)
                            .frame(width: 20, height: 20)
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .foregroundColor(.black)
                            .frame(width: 20, height: 20)
                    }
                    
                }
                
            }
            
//            ToolbarItem(placement: .topBarTrailing) {
//                Button {
//                    
//                } label: {
//                    Image(systemName: "bell")
//                        .foregroundColor(.black)
//                }
//            }
//            
//            ToolbarItem(placement: .topBarTrailing) {
//                Button {
//                    
//                } label: {
//                    Image(systemName: "ellipsis.circle")
//                        .foregroundColor(.black)
//                }
//            }
        }
        
    }
}

#Preview {
    ProfileView(user: User(id: NSUUID().uuidString, fullname: "Taylor Alison Swift", email: "taylor@gmail.com", username: "Taylor"))
}
