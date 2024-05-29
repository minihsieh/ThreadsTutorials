//
//  ExploreViewModel.swift
//  ThreadsTutorials
//
//  Created by MiniHsieh on 2024/5/17.
//

import Foundation

class ExploreViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var searchText = ""
    
    var searchableUsers: [User] {
        if searchText.isEmpty {
            return users
        } else {
            let lowercaseQuery = searchText.lowercased()
            return users.filter { user in
                user.username.contains(lowercaseQuery) || user.fullname.lowercased().contains(lowercaseQuery)
            }
        }
    }

    
    init() {
        Task {
            try await fetchUsers()
        }
    }
    
    @MainActor
    private func fetchUsers() async throws {
        self.users = try await UserService.shared.fetchUsers()
        
    }
}
