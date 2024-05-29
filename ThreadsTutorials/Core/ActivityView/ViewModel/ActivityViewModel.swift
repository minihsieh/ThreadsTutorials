//
//  ActivityViewModel.swift
//  ThreadsTutorials
//
//  Created by MiniHsieh on 2024/5/23.
//

import Foundation

class ActivityViewModel: ObservableObject {
    @Published var users = [User]()
    
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
