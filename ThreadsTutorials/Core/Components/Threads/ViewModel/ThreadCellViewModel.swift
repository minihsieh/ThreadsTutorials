//
//  ThreadCellViewModel.swift
//  ThreadsTutorials
//
//  Created by MiniHsieh on 2024/5/28.
//

import Foundation


class ThreadCellViewModel: ObservableObject {
    
    @Published var thread: Thread
    private let service = ThreadService()
    
    init(thread: Thread) {
        self.thread = thread
        checkIfLikeThread()
        checkUpdateThread()
    }
    
    @MainActor
    func likeThread() {
        service.likeThread(thread) {
            self.thread.didLike = true
        }
    }
    
    @MainActor
    func unlikeThread() {
        service.unlikeThread(thread) {
            self.thread.didLike = false
        }
    }
    
    func checkIfLikeThread() {
        service.checkIfLikeThread(thread) { didLike in
            if didLike {
                self.thread.didLike = true
            }
        }
    }
    
    func checkUpdateThread() {
        service.checkUpdateThread(thread) { thread in
            self.thread.like = thread.like
        }
    }
}
