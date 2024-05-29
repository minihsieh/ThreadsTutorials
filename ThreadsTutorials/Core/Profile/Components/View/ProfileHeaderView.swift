//
//  ProfileHeaderView.swift
//  ThreadsTutorials
//
//  Created by MiniHsieh on 2024/5/17.
//

import SwiftUI

struct ProfileHeaderView: View {
    var user: User?
    
    init(user: User?) {
        self.user = user
    }
    
    var body: some View {
        HStack(alignment: .top) {
            VStack (alignment: .leading, spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(user?.username ?? "")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text(user?.fullname ?? "")
                        .font(.footnote)
                }
                
                if let bio = user?.bio {
                    Text(bio)
                        .font(.footnote)
                }
                
                Text("2 followers")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            CircularProfileImageView(user: user, size: .medium)
        }
    }
}
        
#Preview {
    ProfileHeaderView(user: User(id: NSUUID().uuidString, fullname: "Taylor Alison Swift", email: "taylor@gmail.com", username: "Taylor"))
}
