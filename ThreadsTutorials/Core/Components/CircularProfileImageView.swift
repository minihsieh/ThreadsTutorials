//
//  CircularProfileImageView.swift
//  ThreadsTutorials
//
//  Created by MiniHsieh on 2024/5/15.
//

import SwiftUI
import Kingfisher

enum ProfileImageSize {
    case xxSmall
    case xSmall
    case small
    case medium
    case large
    case xLarge
    
    var dimension: CGFloat {
        switch self {
        case .xxSmall: return 28
        case .xSmall: return 32
        case .small: return 40
        case .medium: return 48
        case .large: return 64
        case .xLarge: return 80
        }
    }
}

enum ProfileImageType: Int, CaseIterable, Identifiable {
    case feed
    case activity
    
    var type: String {
        switch self {
        case .feed: return "Feed"
        case .activity: return "Activity"
        }
    }
    
    var id: Int { return self.rawValue }
    
}

struct CircularProfileImageView: View {
    var user: User?
    let size: ProfileImageSize
    var type: ProfileImageType?
    
    var body: some View {
        ZStack {
            if let imageUrl = user?.profileImageUrl {
               KFImage(URL(string: imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: size.dimension, height: size.dimension)
                    .clipShape(.circle)
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: size.dimension, height: size.dimension)
                    .clipShape(.circle)
                    .foregroundColor(Color(.systemGray4))
            }
            
            if let type = type {
                Circle()
                    .fill(Color.white)
                    .frame(width: 20, height: 20)
                    .overlay(
                        Button {
                            
                        } label: {
                            Image(systemName: (type ==  .feed) ? "plus.circle.fill": "person.circle.fill")
                                .foregroundColor((type ==  .feed) ? .black: .purple)
                        }
                    )
                    .offset(x: 15, y: 15)
            }
        }
    }
}

#Preview {
    CircularProfileImageView(user: User.mockUser, size: .medium)
}
