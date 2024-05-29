//
//  UserCell.swift
//  ThreadsTutorials
//
//  Created by MiniHsieh on 2024/5/15.
//

import SwiftUI

struct UserCell: View {
    let user: User
    var type: ProfileImageType?
    @State private var followed: Bool = false
    
    var body: some View {
        HStack {
            CircularProfileImageView(user: user, size: .small, type: type)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(user.username)
                    .fontWeight(.semibold)
                
                Text(user.fullname)
            }
            .font(.footnote)
            
            Spacer()
            
            Button {
                followed.toggle()
            } label: {
                Text(followed ? "Unfollow" : "Follow")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(width: 100, height: 32)
                    .foregroundColor(followed ? .white: .black)
                    .background(followed ? .black: .white)
                    .cornerRadius(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.systemGray4), lineWidth: 1)
                    }
            }
        }
        .padding(.horizontal)
        
        
    }
}

//#Preview {
//    UserCell(user: dev.user)
//}

struct UserCell_Previews: PreviewProvider {
    static var previews: some View {
        UserCell(user: dev.user)
    }
}
