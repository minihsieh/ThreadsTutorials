//
//  ActivityFilter.swift
//  ThreadsTutorials
//
//  Created by MiniHsieh on 2024/5/23.
//

import Foundation


enum ActivityFilter: Int, CaseIterable, Identifiable {
    case all
    case follow
    case replies
    case mention
    case quote
    case forward
    case verified
    
    var title: String {
        switch self {
        case .all: return "All"
        case .follow: return "Follow"
        case .replies: return "Replies"
        case .mention: return "Mention"
        case .quote: return "Quote"
        case .forward: return "Rorward"
        case .verified: return "Verified"
        }
    }
    
    var id: Int { return self.rawValue }
    
}
