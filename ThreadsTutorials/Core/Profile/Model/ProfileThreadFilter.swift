//
//  ProfileThreadFilter.swift
//  ThreadsTutorials
//
//  Created by MiniHsieh on 2024/5/16.
//

import Foundation

enum ProfileThreadFilter: Int, CaseIterable, Identifiable {
    case threads
    case replies
    case rethread
    
    var title: String {
        switch self {
        case .threads: return "Threads"
        case .replies: return "Replies"
        case .rethread: return "Rethread"
        }
    }
    
    var id: Int { return self.rawValue }
    
}
