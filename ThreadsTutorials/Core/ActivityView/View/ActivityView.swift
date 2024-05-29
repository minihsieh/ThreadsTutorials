//
//  ActivityView.swift
//  ThreadsTutorials
//
//  Created by MiniHsieh on 2024/5/15.
//

import SwiftUI

struct ActivityView: View {
    @StateObject var viewModel = ActivityViewModel()
    
    var body: some View {
        
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                
                LazyVStack(alignment: .leading, spacing: 5, pinnedViews: [.sectionHeaders]) {
                    Text("Activity")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.leading, 20)
                    
                    Section{
                        ForEach(viewModel.users) { user in
                            NavigationLink(value: user) {
                                VStack {
                                    UserCell(user: user ,type: .activity)
                                    Divider()
                                        .padding(.leading, 60)
                                }
                                .padding(.vertical, 4)
                            }
                        }
                    } header: {
                        StickyButtonHeaders()
                    }
                    
                }
            }
            .navigationDestination(for: User.self, destination: { user in
                ProfileView(user: user)
            })
            .padding(.top, 1)
            
        }
        

    }
}

#Preview {
    ActivityView()
}
