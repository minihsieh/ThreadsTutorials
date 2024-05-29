//
//  FeedViewModel.swift
//  ThreadsTutorials
//
//  Created by MiniHsieh on 2024/5/19.
//

import Foundation

@MainActor
class FeedViewModel: ObservableObject {
    @Published var threads = [Thread]()
    
    init() {
        Task {
            try await fetchThreads()
        }
    }
    
    
    func fetchThreads() async throws {
        self.threads = try await ThreadService.fetchThread()
        try await fetchUserDataForThreads()
    }
    
    private func fetchUserDataForThreads() async throws {
        for i in 0 ..< threads.count {
            let thread = threads[i]
            let ownerUid = thread.ownerUid
            let threadUser = try await UserService.shared.fetchUser(withUid: ownerUid)
            
            threads[i].user = threadUser
        }
    }
}

class PreviewImageState: ObservableObject {
    @Published var previewImageUrl: String = ""
    @Published var isShowingImagePreview: Bool = false
}
