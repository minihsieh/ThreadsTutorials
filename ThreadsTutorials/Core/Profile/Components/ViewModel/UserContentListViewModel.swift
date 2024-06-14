//
//  UserContentListViewModel.swift
//  ThreadsTutorials
//
//  Created by MiniHsieh on 2024/5/19.
//

import Foundation
import Combine


class UserContentListViewModel: ObservableObject {
    
    @Published var threads = [Thread]()
    @Published var likedthreads = [Thread]()
    
    private var cancellables = Set<AnyCancellable>()
    let user: User
    
    init(user: User) {
        self.user = user
        setupSubscriptions()
//        Task { try await fetchUserThreads() }
    }
    
    private func setupSubscriptions() {
        // 在這裡添加對 shouldRefresh 的觀察
        CurrentUserProfileViewModel.shared.$shouldRefresh
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                Task {
                    do {
                        try await self.fetchUserThreads()
                        try await self.fetchLikedThreads()
                    } catch {
                        print("Error fetching user threads: \(error)")
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    @MainActor
    func fetchUserThreads() async throws {
        var threads = try await ThreadService.fetchUserThreads(uid: user.id)
        
        for i in 0..<threads.count {
            threads[i].user = self.user
        }
        self.threads = threads
    }
    
    @MainActor
    func fetchLikedThreads() async throws {
        let likedThreads = try await ThreadService.fetchLikeThreads(forUid: user.id)
        self.likedthreads = likedThreads.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() })
        
        for i in 0..<likedThreads.count {
            let uid = likedThreads[i].ownerUid
            let user = try await UserService.shared.fetchUser(withUid: uid)
            self.likedthreads[i].user = user
        }
        
    }
    
    func threads(forFilter filter: ProfileThreadFilter) -> [Thread] {
        switch filter {
        case .threads:
            return threads
        case .replies:
            return threads
        case .rethread:
            return likedthreads
        }
    }
    
    
    
    
}
